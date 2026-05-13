
-- -------------------------------------------------------------------------
--
-- Script:      runstats.anon.sql
--
-- Author:      Adrian Billington, using Tom Kyte's RUNSTATS
--              www.oracle-developer.net
--
-- Description: This version of Tom Kyte's RUNSTATS uses an anonymous block
--              for those times when you can't get explicit grants on the V$
--              views (i.e. cannot compile the RUNSTATS package or view).
--
--              Note that this is a script-based version and as such
--              requires sqlplus or an IDE that supports sqlplus commands.
--
-- Usage:       Familiarity with Tom Kyte's RUNSTATS is assumed. To use it,
--              do the following:
--
--              1. create the RUNSTATS_GTT global temporary table, using the
--                 DDL following this header;
--
--              2. save the remainder of this file as "runstats.sql" to be
--                 used in sqlplus or a "sqlplus-friendly" IDE;
--
--              3. store each of the two alternative methods in separate
--                 .sql scripts and call as follows:
--
--                 SQL> @runstats "script1_name" "script2_name"
--
--                 Note that the scripts will be embedded in the runstats
--                 block as nested anonymous blocks at runtime. This means
--                 they must contain valid PL/SQL blocks only (i.e. 
--                 {DECLARE}..BEGIN..{EXCEPTION}..END;) without a terminator
--                 ("/").
--
-- -------------------------------------------------------------------------

--
-- Create this table before using runstats...
--

create global temporary table runstats_gtt
( runid varchar2(15),
  name  varchar2(80),
  value int )
on commit preserve rows;


--
-- Paste the following into a "runstats.sql" script... 
--

set serveroutput on size 1000000

define method1 = &1;
define method2 = &2;

declare

   g_start pls_integer;
   g_run1  pls_integer;
   g_run2  pls_integer;

   procedure set_timer is
   begin
      g_start := dbms_utility.get_time;
   end set_timer;

   function get_time return pls_integer is
   begin
      return dbms_utility.get_time-g_start;
   end get_time;

   procedure delete_stats is
   begin
      delete from runstats_gtt;
   end delete_stats;

   procedure insert_stats( p_id in varchar2 ) is
   begin
      insert into runstats_gtt
      select p_id, ilv.*
      from  (
             select 'STAT...' || a.name as name
             ,      b.value
             from   v$statname a
             ,      v$mystat   b
             where  a.statistic# = b.statistic#
             union all
             select 'LATCH.' || name
             ,      gets
             from   v$latch
             union all
             select 'STAT...Elapsed Time'
             ,      hsecs from v$timer
            ) ilv;
   end insert_stats;

   procedure rs_start is 
   begin
       delete_stats;
       insert_stats('before');
       set_timer;
   end rs_start;

   procedure rs_middle is
   begin
       g_run1 := get_time;
       insert_stats('after 1');
       set_timer;
   end rs_middle;

   procedure rs_stop(p_difference_threshold in number default 0) is
   begin

       g_run2 := get_time;

       dbms_output.put_line( 'Run1 ran in ' || g_run1 || ' hsecs' );
       dbms_output.put_line( 'Run2 ran in ' || g_run2 || ' hsecs' );
       dbms_output.put_line( 'Run 1 ran in ' || round(g_run1/g_run2*100,2) || '% of the time' );
       dbms_output.put_line( chr(9) );

       insert_stats('after 2');

       dbms_output.put_line ( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) || 
                              lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

       for x in ( select rpad( a.name, 30 ) || 
                            to_char( b.value-a.value, '999,999,999' ) || 
                            to_char( c.value-b.value, '999,999,999' ) || 
                            to_char( ( (c.value-b.value)-(b.value-a.value)), '999,999,999' ) as data
                  from   runstats_gtt a 
                  ,      runstats_gtt b
                  ,      runstats_gtt c
                  where  a.name = b.name
                  and    b.name = c.name
                  and    a.runid = 'before'
                  and    b.runid = 'after 1'
                  and    c.runid = 'after 2'
                  and    abs( (c.value-b.value) - (b.value-a.value) ) > p_difference_threshold
                  order  by 
                         abs( (c.value-b.value)-(b.value-a.value)) )
       loop
           dbms_output.put_line( x.data );
       end loop;

       dbms_output.put_line( chr(9) );
       dbms_output.put_line( 'Run1 latches total versus runs -- difference and pct' );
       dbms_output.put_line( lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) || 
                             lpad( 'Diff', 12 ) || lpad( 'Pct', 10 ) );
   
       for x in ( select to_char( run1, '999,999,999' ) ||
                            to_char( run2, '999,999,999' ) ||
                            to_char( diff, '999,999,999' ) ||
                            to_char( round( run1/run2*100,2 ), '99,999.99' ) || '%' as data
                  from  (
                         select sum(b.value-a.value)                       as run1
                         ,      sum(c.value-b.value)                       as run2
                         ,      sum( (c.value-b.value)-(b.value-a.value) ) as diff
                         from   runstats_gtt a
                         ,      runstats_gtt b
                         ,      runstats_gtt c
                         where  a.name = b.name
                         and    b.name = c.name
                         and    a.runid = 'before'
                         and    b.runid = 'after 1'
                         and    c.runid = 'after 2'
                         and    a.name like 'LATCH%'
                        ) ) 
       loop
           dbms_output.put_line( x.data );
       end loop;
   end rs_stop;

begin
   rs_start();
   @&method1
   rs_middle();
   @&method2
   rs_stop();
end;
/

undefine method1
undefine method2


