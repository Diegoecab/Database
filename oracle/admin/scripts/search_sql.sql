--search_sql
col sql_text for a100
col sql_fulltext for a60
col user_name for a10
col end_interval_time for a21
col elapsed_time_delta for 999999
set feedback off
set echo off
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
PROMP Buscar SQL en Cursor Cache, o AWR Snapshots (Falta agregar AWR Baseline y SQL Tuning Set)
SET pages 1000
SET verify off
SET heading on
--ACCEPT PSCHEMA prompt 'Parsing Schema Name: '
ACCEPT SQL_TEXT prompt 'SQL Text like: '
--ACCEPT SQL_ID prompt 'SQL ID: '
--ACCEPT ETIME prompt 'Elapsed Time (sec): '
--ACCEPT EXECUTIONS prompt 'Executions: '

PROMPT Cursor Cache
SELECT   sql_id, sql_fulltext, plan_hash_value, --parsing_schema_name,
         elapsed_time, executions
    FROM v$sql
   WHERE UPPER (sql_fulltext) LIKE UPPER ('&SQL_TEXT%')
ORDER BY elapsed_time DESC;

PROMPT AWR Snapshots
SELECT   stat.sql_id, plan_hash_value, --parsing_schema_name,
         elapsed_time_delta, stat.snap_id, ss.end_interval_time,
         executions_delta
    FROM dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   WHERE stat.sql_id = txt.sql_id
     AND stat.dbid = txt.dbid
     AND ss.dbid = stat.dbid
     AND ss.instance_number = stat.instance_number
     AND stat.snap_id = ss.snap_id
     AND ss.begin_interval_time >= SYSDATE - 7
     AND UPPER (sql_text) LIKE UPPER('&SQL_TEXT%')
ORDER BY elapsed_time_delta DESC;

SELECT  sql_text
    FROM dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   WHERE stat.sql_id = txt.sql_id
     AND stat.dbid = txt.dbid
     AND ss.dbid = stat.dbid
     AND ss.instance_number = stat.instance_number
     AND stat.snap_id = ss.snap_id
     AND ss.begin_interval_time >= SYSDATE - 7
     AND UPPER (sql_text) LIKE UPPER('&SQL_TEXT%')
ORDER BY elapsed_time_delta DESC;



--SELECT STAT.SQL_ID, SQL_TEXT, PLAN_HASH_VALUE, PARSING_SCHEMA_NAME, ELAPSED_TIME_DELTA, STAT.SNAP_ID, SS.END_INTERVAL_TIME, EXECUTIONS_DELTA FROM DBA_HIST_SQLSTAT STAT, DBA_HIST_SQLTEXT TXT, DBA_HIST_SNAPSHOT SS WHERE STAT.SQL_ID = TXT.SQL_ID AND STAT.DBID = TXT.DBID AND SS.DBID = STAT.DBID AND SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER AND STAT.SNAP_ID = SS.SNAP_ID AND STAT.DBID = ? AND STAT.INSTANCE_NUMBER = ? AND SS.BEGIN_INTERVAL_TIME >= sysdate-7 AND UPPER(SQL_TEXT) LIKE ? AND ELAPSED_TIME_DELTA >= ? ORDER BY ELAPSED_TIME_DELTA DESC


--SELECT SQL_ID, SQL_FULLTEXT, PLAN_HASH_VALUE, PARSING_SCHEMA_NAME, ELAPSED_TIME, EXECUTIONS FROM V$SQL WHERE 
--UPPER(SQL_FULLTEXT) LIKE '&SQL_TEXT%' AND ELAPSED_TIME >= '&ETIME' ORDER BY ELAPSED_TIME DESC