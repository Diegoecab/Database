--dba_hist_snapshot_username

--Buscar sqlid en los snapshots

col begin_interval_time for a25
col end_interval_time for a25
set pages 1000
set lines 300
accept days prompt 'Days: '

Prompt  Registros de snapshots AWR

select snap_id,begin_interval_time,end_interval_time,error_count from dba_hist_snapshot 
where begin_interval_time > sysdate - &days
order by snap_id;

set lines 400

SELECT   STAT.SQL_ID,
           PLAN_HASH_VALUE,
		   round(SHARABLE_MEM/1024/1024) SHARABLE_MEM_MB,
		   SS.END_INTERVAL_TIME,
           PARSING_SCHEMA_NAME,
		   rows_processed_total,
           ELAPSED_TIME_DELTA,
		   round((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000) avg_etime,
		   round(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)/60) avg_etime_m,
           STAT.SNAP_ID,
		   MODULE
    FROM   DBA_HIST_SQLSTAT STAT, DBA_HIST_SQLTEXT TXT, DBA_HIST_SNAPSHOT SS
   WHERE       STAT.SQL_ID = TXT.SQL_ID
           AND STAT.DBID = TXT.DBID
           AND SS.DBID = STAT.DBID
           AND SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER
           AND STAT.SNAP_ID = SS.SNAP_ID
           AND STAT.DBID = (select dbid from v$database)
           AND STAT.INSTANCE_NUMBER = (select instance_number from v$instance)
		   AND UPPER(PARSING_SCHEMA_NAME) = upper('&schema')
           AND STAT.SNAP_ID BETWEEN &SNAPI and &SNAPF
ORDER BY   STAT.SNAP_ID
/


