REM	This is the test harness I use to try out different ideas. It shows two vital sets of statistics for me
REM	
REM	* The elapsed time difference between two approaches. It very simply shows me which approach is faster by the wall clock
REM	* How many resources each approach takes. This can be more meaningful then even the wall clock timings. 
REM	For example, if one approach is faster then the other but it takes thousands of latches (locks), I might avoid it simply because it will not scale as well. 
REM ======================================================================
REM Runstats.sql		Version 1.1	31 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	
REM Dependencias:
REM	In order to run this test harness you must at a minimum have:
REM	
REM	* Access to V$STATNAME, V$MYSTAT, v$TIMER and V$LATCH
REM	* You must be granted select DIRECTLY on SYS.V_$STATNAME, SYS.V_$MYSTAT, SYS.V_$TIMER and SYS.V_$LATCH. It will not work to have select on these via a ROLE.
REM	* The ability to create a table -- run_stats -- to hold the before, during and after information.
REM	* The ability to create a package -- rs_pkg -- the statistics collection/reporting piece 
REM
REM Notas:
REM The way this test harness works is by saving the system statistics and latch information into a temporary table. We then run a test and take another snapshot. 
REM We run the second test and take yet another snapshot. Now we can show the amount of resources used by approach 1 and approach 2.
REM You should note also that the LATCH information is collected on a SYSTEM WIDE basis.
REM If you run this on a multi-user system, the latch information may be technically "incorrect" as you will count the latching information for other sessions - not just your session. 
REM This test harness works best in a simple, controlled test environment.
REM
REM Precauciones:
REM	
REM ======================================================================
REM


REM The table we need is very simple:

create global temporary table run_stats
( runid varchar2(15),
  name varchar2(80),
  value int )
on commit preserve rows;

REM then you can create this view:

create or replace view stats
as select 'STAT...' || a.name name, b.value
      from v$statname a, v$mystat b
     where a.statistic# = b.statistic#
    union all
    select 'LATCH.' || name,  gets
      from v$latch
	union all
	select 'STAT...Elapsed Time', hsecs from v$timer;

REM Now the test harness package itself is very simple. Here it is:

create or replace package runstats_pkg
as
    procedure rs_start;
    procedure rs_middle;
    procedure rs_stop( p_difference_threshold in number default 0 );
end;
/

create or replace package body runstats_pkg
as

g_start number;
g_run1  number;
g_run2  number;

procedure rs_start
is 
begin
    delete from run_stats;

    insert into run_stats 
    select 'before', stats.* from stats;
        
    g_start := dbms_utility.get_time;
end;

procedure rs_middle
is
begin
    g_run1 := (dbms_utility.get_time-g_start);
 
    insert into run_stats 
    select 'after 1', stats.* from stats;
    g_start := dbms_utility.get_time;

end;

procedure rs_stop(p_difference_threshold in number default 0)
is
begin
    g_run2 := (dbms_utility.get_time-g_start);

    dbms_output.put_line
    ( 'Run1 ran in ' || g_run1 || ' hsecs' );
    dbms_output.put_line
    ( 'Run2 ran in ' || g_run2 || ' hsecs' );
	if ( g_run2 <> 0 )
	then
    dbms_output.put_line
    ( 'run 1 ran in ' || round(g_run1/g_run2*100,2) || 
      '% of the time' );
	end if;
    dbms_output.put_line( chr(9) );

    insert into run_stats 
    select 'after 2', stats.* from stats;

    dbms_output.put_line
    ( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) || 
      lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

    for x in 
    ( select rpad( a.name, 30 ) || 
             to_char( b.value-a.value, '999,999,999' ) || 
             to_char( c.value-b.value, '999,999,999' ) || 
             to_char( ( (c.value-b.value)-(b.value-a.value)), '999,999,999' ) data
        from run_stats a, run_stats b, run_stats c
       where a.name = b.name
         and b.name = c.name
         and a.runid = 'before'
         and b.runid = 'after 1'
         and c.runid = 'after 2'
         -- and (c.value-a.value) > 0
         and abs( (c.value-b.value) - (b.value-a.value) ) 
               > p_difference_threshold
       order by abs( (c.value-b.value)-(b.value-a.value))
    ) loop
        dbms_output.put_line( x.data );
    end loop;

    dbms_output.put_line( chr(9) );
    dbms_output.put_line
    ( 'Run1 latches total versus runs -- difference and pct' );
    dbms_output.put_line
    ( lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) || 
      lpad( 'Diff', 12 ) || lpad( 'Pct', 10 ) );

    for x in 
    ( select to_char( run1, '999,999,999' ) ||
             to_char( run2, '999,999,999' ) ||
             to_char( diff, '999,999,999' ) ||
             to_char( round( run1/decode( run2, 0, to_number(0), run2) *100,2 ), '99,999.99' ) || '%' data
        from ( select sum(b.value-a.value) run1, sum(c.value-b.value) run2,
                      sum( (c.value-b.value)-(b.value-a.value)) diff
                 from run_stats a, run_stats b, run_stats c
                where a.name = b.name
                  and b.name = c.name
                  and a.runid = 'before'
                  and b.runid = 'after 1'
                  and c.runid = 'after 2'
                  and a.name like 'LATCH%'
                )
    ) loop
        dbms_output.put_line( x.data );
    end loop;
end;

end;
/

/*
exec runStats_pkg.rs_start;
exec runStats_pkg.rs_middle;
exec runStats_pkg.rs_stop;
*/
