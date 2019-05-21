REM	Total number of work areas executed with optimal memory size, one-pass memory size, and multi-pass memory size
REM ======================================================================
REM work_areas_stats.sql		Version 1.1	30 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	
REM Dependencias:
REM	
REM
REM Notas:
REM These statistics are cumulative since the instance or the session was started.
REM Precauciones:
REM	
REM ======================================================================
REM
col name format a32

SELECT name, cnt, decode(total, 0, 0, round(cnt*100/total)) percentage
    FROM (SELECT name, value cnt, (sum(value) over ()) total
    FROM V$SYSSTAT 
    WHERE name like 'workarea exec%');