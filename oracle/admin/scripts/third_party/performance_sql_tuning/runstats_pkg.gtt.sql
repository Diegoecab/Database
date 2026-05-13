
create global temporary table runstats_gtt
( runid  integer
, name   varchar2(80)
, value  number
)
on commit preserve rows;


create or replace package runstats_pkg authid current_user as

   /*
   || ----------------------------------------------------------------------------
   ||
   || Name:        RUNSTATS_PKG
   ||
   || Description: Version of Tom Kyte's RUNSTATS test harness. All output is the
   ||              same format and structure. Runtimes are the same.
   ||
   ||              Key Differences
   ||              ---------------
   ||
   ||                 a) This uses invoker rights and dynamic SQL to workaround
   ||                    the sites where developers cannot get explicit grants
   ||                    on the required V$ views, but instead have access via
   ||                    roles or other privileges. As a result, the STATS view
   ||                    from TK's original is removed;
   ||
   ||                 b) There is a new option to pause and resume runstats in
   ||                    between runs. This is useful, for example, when you 
   ||                    need to reset some data before the second run. See 
   ||                    usage notes below for details;
   ||
   ||                 c) Requires at least 9.0 to run as it uses analytic functions
   ||                    statically compiled (these had to be dynamic in 8i).
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
   || Type and variable for timing capture...  
   */
   type aat_timing is table of pls_integer
      index by pls_integer;
   ga_timings aat_timing;

   /*
   || Booleans to enable pausing and resuming between runs...
   */
   g_paused    boolean := false;
   g_resumed   boolean := false;

   -----------------------------------------------------------------------------

   procedure rs_snap( p_run in number ) is
      pragma autonomous_transaction;
   begin
      /*
      || Dynamic SQL (combined with invoker rights in the spec) works around
      || the need to have explicit select granted on the referenced v$ views.
      || Of course, we still need access granted via a role or other privilege
      || but I've always been able to get the latter and rarely the former...
      */
      execute immediate 'insert into runstats_gtt (runid, name, value)
                         select :runid
                         ,      name
                         ,      value
                         from  (
                                select ''STAT..'' || a.name as name
                                ,      b.value
                                from   v$statname a
                                ,      v$mystat   b
                                where  a.statistic# = b.statistic#
                                union all
                                select ''LATCH.'' || name
                                ,      gets 
                                from   v$latch
                               )'
      using p_run;
      commit;
      ga_timings(p_run) := dbms_utility.get_time;
   end rs_snap;

   -----------------------------------------------------------------------------

   procedure rs_reset is
      pragma autonomous_transaction;
   begin
      delete from runstats_gtt;
      commit;
      g_paused := false;
      g_resumed := false;
   end rs_reset;

   -----------------------------------------------------------------------------
   
   procedure rs_report ( p_difference_threshold in number ) is

      s1 number;  --<-- runid for start of run1
      s2 number;  --<-- runid for end of run1
      e1 number;  --<-- runid for start of run2
      e2 number;  --<-- runid for end of run2

      t1 integer; --<-- holds runtime of run1
      t2 integer; --<-- holds runtime of run2

      l1 integer := 0; --<-- keeps running total of latching in run1
      l2 integer := 0; --<-- keeps running total of latching in run2

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
      t1 := ga_timings(e1)-ga_timings(s1);
      t2 := ga_timings(e2)-ga_timings(s2);
      dbms_output.put_line( 'Run1 ran in ' || t1 || ' hsecs' );
      dbms_output.put_line( 'Run2 ran in ' || t2 || ' hsecs' );
      dbms_output.put_line( 'Run1 ran in ' || round(t1/t2*100,2) || '% of the time' );
      dbms_output.put_line( chr(10) );

      /*
      || Main runstats report... 
      */
      dbms_output.put_line( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) || 
                            lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

      for r in ( with value_nodes as (
                         select runid
                         ,      name
                         ,      value                                                       as s1_val     
                         ,      lead(value,(e1-s1)) over (partition by name order by runid) as e1_val
                         ,      lead(value,(s2-s1)) over (partition by name order by runid) as s2_val
                         ,      lead(value,(e2-s1)) over (partition by name order by runid) as e2_val
                         from   runstats_gtt
                         )
                 ,    run_stats as (
                         select runid
                         ,      name
                         ,      e1_val-s1_val as run1
                         ,      e2_val-s2_val as run2
                         from   value_nodes
                         where  runid = c_run1
                         )
                 select runid
                 ,      name
                 ,      run1
                 ,      run2
                 ,      run2-run1 as diff
                 from   run_stats
                 where  abs(run2-run1) > p_difference_threshold 
                 order  by 
                        abs(run2-run1) )
      loop

         /*
         || Output the statistic, as long as it's not the elapsed time (we'll report this at the end)...
         */
         dbms_output.put_line( rpad(r.name,30)                ||
                               to_char(r.run1,'999,999,999' ) ||
                               to_char(r.run2,'999,999,999' ) ||
                               to_char(r.diff,'999,999,999') );

         /*
         || Keep a running tally of latching or runtime...
         */
         if r.name like 'LATCH%' then
            l1 := l1 + r.run1;
            l2 := l2 + r.run2;
         end if;

      end loop;

      /*
      || Final part of the report is the timing and latching...
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
      rs_snap(c_run1);
   end rs_start;

   -----------------------------------------------------------------------------

   procedure rs_middle is
   begin
      rs_snap(c_run2);
      g_paused := false;
   end rs_middle;

   -----------------------------------------------------------------------------

   procedure rs_pause is
   begin
      rs_snap(c_run2);
      g_paused := true;
   end rs_pause;

   -----------------------------------------------------------------------------

   procedure rs_resume is
   begin
      if g_paused then
         rs_snap(c_run3);
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
                 end);
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
