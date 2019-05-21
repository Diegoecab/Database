create or replace package runstats_pkg authid current_user as

   /*
   || ----------------------------------------------------------------------------
   ||
   || Name:        RUNSTATS_PKG
   ||
   || Description: PL/SQL-only version of Tom Kyte's RUNSTATS test harness.
   ||              All output is the same format and structure. Runtimes are the
   ||              same.
   ||
   ||              Key Differences
   ||              ---------------
   ||
   ||                 a) All logic is encapsulated in a single PL/SQL package
   ||                    (no runstats global temporary table or stats view);
   ||
   ||                 b) This uses invoker rights and dynamic SQL to workaround
   ||                    the sites where developers cannot get explicit grants
   ||                    on the required V$ views, but instead have access via
   ||                    roles or other privileges;
   ||
   ||                 c) There is a new option to pause and resume runstats in
   ||                    between runs. This is useful, for example, when you 
   ||                    need to reset some data before the second run. See 
   ||                    usage notes below for details;
   ||                    
   ||                 d) This requires at least version 9.2 to run because it
   ||                    makes use of string-indexed and multi-level associative
   ||                    arrays to store the intermediate stats;
   ||
   ||                 e) Because this version uses associative arrays, a small
   ||                    "primer" procedure exists in the body to minimise the
   ||                    potential side-effects on PGA memory reporting. As a 
   ||                    result, PGA memory reporting when using this package
   ||                    should be valid (i.e. incurred by whatever is being
   ||                    tested and not from the intrusion of RUNSTATS_PKG).
   ||
   || Usage:       Standard Runstats
   ||              -----------------
   ||              BEGIN
   ||                 runstats_pkg.rs_start;
   ||                 --<do run 1>--
   ||                 runstats_pkg.rs_middle;
   ||                 --<do run 2>--
   ||                 runstats_pkg.rs_stop(<reporting threshold>);
   ||              END;
   ||
   ||              Resumable Runstats
   ||              ------------------
   ||              BEGIN
   ||                 runstats_pkg.rs_start;
   ||                 --<do run 1>--
   ||                 runstats_pkg.rs_pause;
   ||                 --<do some work e.g. to reset test data>--
   ||                 runstats_pkg.rs_resume;
   ||                 --<do run 2>--
   ||                 runstats_pkg.rs_stop(<reporting threshold>);
   ||              END;
   ||
   ||              This mode will raise one of the following exceptions if not
   ||              used as above:
   ||
   ||                -20000: Attempt to resume runstats when it was 
   ||                        never paused.
   ||
   ||                -20001: Attempt to stop a paused runstats that was never
   ||                        resumed.
   ||
   || Notes:       Serveroutput must be on (and set higher than default).
   ||
   ||              Adrian Billington, www.oracle-developer.net.
   ||
   || ----------------------------------------------------------------------------
   */

   procedure rs_start;
   procedure rs_middle;
   procedure rs_pause;
   procedure rs_resume; 
   procedure rs_stop( p_difference_threshold in number default 0 );

end;
/



create or replace package body runstats_pkg as

   /*
   || Array offsets into the main runstats array, used to
   || determine the start and end points of a run...
   */
   c_run1 constant pls_integer := 1;
   c_run2 constant pls_integer := 2;
   c_run3 constant pls_integer := 3;
   c_run4 constant pls_integer := 4;

   /*
   || A range of (sub)types for capturing statistics information...
   */
   subtype st_statname is varchar2(80);
   subtype st_output is varchar2(255);

   type aat_statistic is table of integer
      index by st_statname;

   type aat_runstats is table of aat_statistic
      index by pls_integer;

   /*
   || This is the "runstats array". It will hold 3 sets of statistics on 
   || a standard "start-middle-stop" run, or 4 sets of statistics on a 
   || "start-pause-resume-stop" run...
   */
   ga_runstats aat_runstats;

   /*
   || Booleans to enable pausing and resuming between runs...
   */
   g_paused    boolean := false;
   g_resumed   boolean := false;

   -----------------------------------------------------------------------------

   procedure rs_snap( p_run      in pls_integer,
                      p_runstats in out nocopy aat_runstats ) is

      type rt_statistic is record
      ( name  st_statname
      , value integer );

      rc_stat sys_refcursor;
      r_stat  rt_statistic;

   begin
      /*
      || Dynamic SQL (combined with invoker rights in the spec) works around
      || the need to have explicit select granted on the referenced v$ views.
      || Of course, we still need access granted via a role or other privilege
      || but I've always been able to get the latter and rarely the former.
      ||
      || Using a ref cursor and loop rather than bulk collect to minimise
      || memory stats interference...
      */
      open rc_stat for 'select ''STAT..'' || a.name
                        ,      b.value
                        from   v$statname a
                        ,      v$mystat   b
                        where  a.statistic# = b.statistic#
                        union all
                        select ''LATCH.'' || name
                        ,      gets 
                        from   v$latch
                        union all
                        select ''STAT..elapsed time''
                        ,      hsecs
                        from   v$timer';
      loop
         fetch rc_stat into r_stat;
         exit when rc_stat%notfound;
         p_runstats(p_run)(r_stat.name) := r_stat.value;
      end loop;
      close rc_stat;
   end rs_snap;

   -----------------------------------------------------------------------------

   procedure rs_reset is
   begin
      ga_runstats.delete;
      g_paused := false;
      g_resumed := false;
   end rs_reset;

   -----------------------------------------------------------------------------
   
   /*
   || This procedure exists purely to add some PGA memory to our session
   || before we start filling associative arrays with runstats data. This
   || will prevent the PGA memory associated stats from showing up in the
   || report purely as a result of this package. We'll load up four sets of
   || stats as this will roughly cover the stat-snaps during the use of
   || runstats...
   */
   procedure rs_prime is
      aa_dummy aat_runstats;
   begin
      rs_snap(1,aa_dummy);
      for i in 2 .. 4 loop
         aa_dummy(i) := aa_dummy(1);
      end loop;
   end rs_prime;

   -----------------------------------------------------------------------------

   procedure rs_report ( p_difference_threshold in number ) is

      ix st_statname;  --<-- statname; offset for runstat array
      s1 pls_integer;  --<-- array offset for start of run1
      s2 pls_integer;  --<-- array offset for end of run1
      e1 pls_integer;  --<-- array offset for start of run2
      e2 pls_integer;  --<-- array offset for end of run2

      r1 integer;      --<-- holds value of run1 statistic
      r2 integer;      --<-- holds value of run2 statistic

      l1 integer := 0; --<-- keeps running total of latching in run1
      l2 integer := 0; --<-- keeps running total of latching in run2

      i1 pls_integer;  --<-- offset for sorted runstats array
      i2 st_statname;  --<-- offset for sorted runstats array

      /*
      || Downside of using associative arrays is that we have to sort
      || the output. So here's a couple of types and a variable to enable us 
      || to do that...
      */
      type aat_runstats_output is table of varchar2(255)
         index by st_statname;
      type aat_runstats_sorted is table of aat_runstats_output
         index by pls_integer;
      aa_runstats_sorted aat_runstats_sorted;
      
      /*
      || Procedure to add a statistic to the sorted runstats array...
      */
      procedure s ( p_statname in st_statname,
                    p_r1_value in integer,
                    p_r2_value in integer ) is

         v_offset pls_integer;
         v_output st_output;

      begin

         /*
         || Workaround the offset limits of a PLS_INTEGER...
         */
         v_offset := least(abs(p_r2_value-p_r1_value),2147483647);
                      
         v_output := rpad(p_statname,30)                ||
                     to_char(p_r1_value,'999,999,999' ) ||
                     to_char(p_r2_value,'999,999,999' ) ||
                     to_char(p_r2_value-p_r1_value,'999,999,999');

         aa_runstats_sorted(v_offset)(p_statname) := v_output;

      end s;

      /*
      || Small function to calculate the statistic for a run. Calculates 
      || the difference between the start and end offset for a run in the
      || runstats array...
      */
      function f ( p_start_offset in pls_integer,
                   p_end_offset   in pls_integer,
                   p_statname     in st_statname ) return number is
      begin
         return ga_runstats(p_end_offset)(p_statname) - 
                ga_runstats(p_start_offset)(p_statname);
      end f;

   begin

      /*
      || Set up the run1 and run2 offsets into the runstats array according
      || to whether the middle section was a straight run through or paused...
      */
      s1 := c_run1;
      s2 := c_run2;

      if not (g_paused and g_resumed) then
         e1 := c_run2;
         e2 := c_run3;
      else
         e1 := c_run3;
         e2 := c_run4;
      end if;

      /*
      || Output the elapsed timings...
      */
      r1 := f(s1,s2,'STAT..elapsed time');
      r2 := f(e1,e2,'STAT..elapsed time');

      dbms_output.put_line( 'Run1 ran in ' || r1 || ' hsecs' );
      dbms_output.put_line( 'Run2 ran in ' || r2 || ' hsecs' );
      dbms_output.put_line( 'Run1 ran in ' || round(r1/r2*100,2) || '% of the time' );
      dbms_output.put_line( chr(10) );

      /*
      || Now output the main stats/latch output...
      */
      dbms_output.put_line( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) || 
                            lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

      ix := ga_runstats(s1).first;
      while ix is not null loop

         /*
         || Calculate the value of the current statistic for run1 and run2...
         */
         r1 := f(s1,s2,ix);
         r2 := f(e1,e2,ix);

         /*
         || If it's greater than the threshold, then output it, as long as it's
         || not the elapsed time statistic. Now here's the downside of using
         || purely associative arrays - we don't have any easy way of sorting.
         || So we have to do it ourselves. A bit of a pain, but simple enough...
         */
         if abs(r2-r1) > p_difference_threshold and ix != 'STAT..elapsed time' then
            s(ix,r1,r2);
         end if;
         
         /*
         || Keep a running tally of latching...
         */
         if ix like 'LATCH%' then
            l1 := l1 + r1;
            l2 := l2 + r2;
         end if;

         /*
         || Next statname please...
         */ 
         ix := ga_runstats(s1).next(ix);

      end loop;

      /*
      || Now we can output the sorted runstats information...
      */
      i1 := aa_runstats_sorted.first;
      while i1 is not null loop

         i2 := aa_runstats_sorted(i1).first;
         while i2 is not null loop
            dbms_output.put_line( aa_runstats_sorted(i1)(i2) );
            i2 := aa_runstats_sorted(i1).next(i2);
         end loop;

         i1 := aa_runstats_sorted.next(i1);

      end loop;
      

      /*
      || Final part of the report is the latching...
      */
      dbms_output.put_line( chr(10) );
      dbms_output.put_line( 'Run1 latches total versus run2 -- difference and pct' );
      dbms_output.put_line( lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) || 
                            lpad( 'Diff', 12 ) || lpad( 'Pct', 11 ) );
      dbms_output.put_line( to_char(l1,'999,999,999')               ||
                            to_char(l2,'999,999,999' )              ||
                            to_char(l2-l1,'999,999,999')            ||
                            to_char(round(l1/l2*100,2),'99,999.99') || '%' );

   end rs_report;

   -----------------------------------------------------------------------------

   procedure rs_start is
   begin
      rs_reset;
      rs_prime;
      rs_snap(c_run1, ga_runstats);
   end rs_start;

   -----------------------------------------------------------------------------

   procedure rs_middle is
   begin
      rs_snap(c_run2, ga_runstats);
      g_paused := false;
   end rs_middle;

   -----------------------------------------------------------------------------

   procedure rs_pause is
   begin
      rs_snap(c_run2, ga_runstats);
      g_paused := true;
   end rs_pause;

   -----------------------------------------------------------------------------

   procedure rs_resume is
   begin
      if g_paused then
         rs_snap(c_run3, ga_runstats);
         g_resumed := true;
      else
         raise_application_error(-20000, 'Runstats was not paused. Nothing to resume!' );
      end if;
   end rs_resume;

   -----------------------------------------------------------------------------

   procedure rs_stop( p_difference_threshold in number default 0 ) is
   begin
      if (g_paused=g_resumed) then
         rs_snap(case
                    when not (g_paused and g_resumed)
                    then c_run3
                    else c_run4
                 end, ga_runstats);
         rs_report( p_difference_threshold );
         rs_reset;
      elsif (g_paused and not g_resumed) then
         raise_application_error(-20001, 'Runstats was paused but not resumed. Cannot continue.' );
      end if;
   end rs_stop;

   -----------------------------------------------------------------------------

end runstats_pkg;
/

create public synonym runstats_pkg for runstats_pkg;
grant execute on runstats_pkg to public;

