set linesize 9000
column name format a25
column value format a20
column time_computed format a25
SELECT name, value, time_computed FROM v$dataguard_stats;