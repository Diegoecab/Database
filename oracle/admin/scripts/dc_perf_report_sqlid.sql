--dc_perf_report_sqlid 
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF
set serveroutput on

begin
for vv in (
 
SELECT
    distinct sql_id from (
SELECT
    distinct sql_id /*SQIDs in ASH*/
FROM (
SELECT
    * 
FROM (
    WITH bclass AS (SELECT class, ROWNUM r from v$waitstat)
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(sysdate AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , &1
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
	  , time_model_name
	  --, program
	  , machine
	  , module
--    , MAX(sql_exec_id) - MIN(sql_exec_id) 
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
	  , event2
	  , instance_number as inst_id
    FROM
        (SELECT
             a.*
           , session_id sid
           , session_serial# serial
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p1 ELSE null END, '0XXXXXXXXXXXXXXX') p1hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p2 ELSE null END, '0XXXXXXXXXXXXXXX') p2hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p3 ELSE null END, '0XXXXXXXXXXXXXXX') p3hex
           , NVL(event, session_state)||
                CASE 
                    WHEN event like 'enq%' AND session_state = 'WAITING'
                    THEN ' [mode='||BITAND(p1, POWER(2,14)-1)||']'
                    WHEN a.event IN (SELECT name FROM v$event_name WHERE parameter3 = 'class#')
                    THEN ' ['||CASE WHEN a.p3 <= (SELECT MAX(r) FROM bclass) 
                               THEN (SELECT class FROM bclass WHERE r = a.p3)
                               ELSE (SELECT DECODE(MOD(BITAND(a.p3,TO_NUMBER('FFFF','XXXX')) - 17,2),0,'undo header',1,'undo data', 'error') FROM dual)
                               END  ||']' 
                    ELSE null 
                END event2 -- event is NULL in ASH if the session is not waiting (session_state = ON CPU)
           , CASE WHEN a.session_type = 'BACKGROUND' OR REGEXP_LIKE(a.program, '.*\([PJ]\d+\)') THEN
                REGEXP_REPLACE(SUBSTR(a.program,INSTR(a.program,'(')), '\d', 'n')
             ELSE
                '('||REGEXP_REPLACE(REGEXP_REPLACE(a.program, '(.*)@(.*)(\(.*\))', '\1'), '\d', 'n')||')'
             END || ' ' program2
           , CASE WHEN BITAND(time_model, POWER(2, 01)) = POWER(2, 01) THEN 'DBTIME '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 02)) = POWER(2, 02) THEN 'BACKGROUND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 03)) = POWER(2, 03) THEN 'CONNECTION_MGMT '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 04)) = POWER(2, 04) THEN 'PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 05)) = POWER(2, 05) THEN 'FAILED_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 06)) = POWER(2, 06) THEN 'NOMEM_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 07)) = POWER(2, 07) THEN 'HARD_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 08)) = POWER(2, 08) THEN 'NO_SHARERS_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 09)) = POWER(2, 09) THEN 'BIND_MISMATCH_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 10)) = POWER(2, 10) THEN 'SQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 11)) = POWER(2, 11) THEN 'PLSQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 12)) = POWER(2, 12) THEN 'PLSQL_RPC '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 13)) = POWER(2, 13) THEN 'PLSQL_COMPILATION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 14)) = POWER(2, 14) THEN 'JAVA_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 15)) = POWER(2, 15) THEN 'BIND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 16)) = POWER(2, 16) THEN 'CURSOR_CLOSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 17)) = POWER(2, 17) THEN 'SEQUENCE_LOAD '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 18)) = POWER(2, 18) THEN 'INMEMORY_QUERY '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 19)) = POWER(2, 19) THEN 'INMEMORY_POPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 20)) = POWER(2, 20) THEN 'INMEMORY_PREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 21)) = POWER(2, 21) THEN 'INMEMORY_REPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 22)) = POWER(2, 22) THEN 'INMEMORY_TREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 23)) = POWER(2, 23) THEN 'TABLESPACE_ENCRYPTION ' END time_model_name 
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
      , dba_users u
      , (SELECT
             object_id,data_object_id,owner,object_name,subobject_name,object_type
           , owner||'.'||object_name obj
           , owner||'.'||object_name||' ['||object_type||']' objt
         FROM dba_objects) o
    WHERE
        a.user_id = u.user_id (+)
    AND a.current_obj# = o.object_id(+)
    AND &2
    AND sample_time BETWEEN &3 AND &4
    GROUP BY
        &1, event2, instance_number, time_model_name, machine, module
    ORDER BY
        TotalSeconds DESC
       , &1
) WHERE
    ROWNUM <= 5
UNION ALL
SELECT
    * 
FROM (
    WITH bclass AS (SELECT class, ROWNUM r from v$waitstat)
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , &1
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
	  , time_model_name
	  --, program
	  , machine
	  , module
--    , MAX(sql_exec_id) - MIN(sql_exec_id) 
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
	  , event2
	  , inst_id
    FROM
        (SELECT
             a.*
           , session_id sid
           , session_serial# serial
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p1 ELSE null END, '0XXXXXXXXXXXXXXX') p1hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p2 ELSE null END, '0XXXXXXXXXXXXXXX') p2hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p3 ELSE null END, '0XXXXXXXXXXXXXXX') p3hex
           , NVL(event, session_state)||
                CASE 
                    WHEN event like 'enq%' AND session_state = 'WAITING'
                    THEN ' [mode='||BITAND(p1, POWER(2,14)-1)||']'
                    WHEN a.event IN (SELECT name FROM v$event_name WHERE parameter3 = 'class#')
                    THEN ' ['||CASE WHEN a.p3 <= (SELECT MAX(r) FROM bclass) 
                               THEN (SELECT class FROM bclass WHERE r = a.p3)
                               ELSE (SELECT DECODE(MOD(BITAND(a.p3,TO_NUMBER('FFFF','XXXX')) - 17,2),0,'undo header',1,'undo data', 'error') FROM dual)
                               END  ||']' 
                    ELSE null 
                END event2 -- event is NULL in ASH if the session is not waiting (session_state = ON CPU)
           , CASE WHEN a.session_type = 'BACKGROUND' OR REGEXP_LIKE(a.program, '.*\([PJ]\d+\)') THEN
                REGEXP_REPLACE(SUBSTR(a.program,INSTR(a.program,'(')), '\d', 'n')
             ELSE
                '('||REGEXP_REPLACE(REGEXP_REPLACE(a.program, '(.*)@(.*)(\(.*\))', '\1'), '\d', 'n')||')'
             END || ' ' program2
           , CASE WHEN BITAND(time_model, POWER(2, 01)) = POWER(2, 01) THEN 'DBTIME '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 02)) = POWER(2, 02) THEN 'BACKGROUND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 03)) = POWER(2, 03) THEN 'CONNECTION_MGMT '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 04)) = POWER(2, 04) THEN 'PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 05)) = POWER(2, 05) THEN 'FAILED_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 06)) = POWER(2, 06) THEN 'NOMEM_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 07)) = POWER(2, 07) THEN 'HARD_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 08)) = POWER(2, 08) THEN 'NO_SHARERS_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 09)) = POWER(2, 09) THEN 'BIND_MISMATCH_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 10)) = POWER(2, 10) THEN 'SQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 11)) = POWER(2, 11) THEN 'PLSQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 12)) = POWER(2, 12) THEN 'PLSQL_RPC '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 13)) = POWER(2, 13) THEN 'PLSQL_COMPILATION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 14)) = POWER(2, 14) THEN 'JAVA_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 15)) = POWER(2, 15) THEN 'BIND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 16)) = POWER(2, 16) THEN 'CURSOR_CLOSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 17)) = POWER(2, 17) THEN 'SEQUENCE_LOAD '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 18)) = POWER(2, 18) THEN 'INMEMORY_QUERY '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 19)) = POWER(2, 19) THEN 'INMEMORY_POPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 20)) = POWER(2, 20) THEN 'INMEMORY_PREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 21)) = POWER(2, 21) THEN 'INMEMORY_REPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 22)) = POWER(2, 22) THEN 'INMEMORY_TREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 23)) = POWER(2, 23) THEN 'TABLESPACE_ENCRYPTION ' END time_model_name 
        FROM gv$active_session_history a) a
      , dba_users u
      , (SELECT
             object_id,data_object_id,owner,object_name,subobject_name,object_type
           , owner||'.'||object_name obj
           , owner||'.'||object_name||' ['||object_type||']' objt
         FROM dba_objects) o
    WHERE
        a.user_id = u.user_id (+)
    AND a.current_obj# = o.object_id(+)
    AND &2
    AND sample_time BETWEEN &3 AND &4
    GROUP BY
        &1, event2, inst_id, time_model_name, machine, module
    ORDER BY
        TotalSeconds DESC
       , &1
)
WHERE
    ROWNUM <= 5)
union all
SELECT
    distinct sql_id /*SQIDs in sql changed plans*/
FROM (
with last_exec as (
select sql_id, username,begin_interval_time last_exec_time, 'AWR' source, round(avg_secs) avg_secs
from (
select s.sql_id,c.username,begin_interval_time,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
(SUM(elapsed_time_total)/SUM(executions_total))/1e6 avg_secs
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate+(1/1440*-&minutes)
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_total > 0
group by s.sql_id,c.username, begin_interval_time
order by avg_secs
)
where username <> 'SYS'
union --Incluyo lo que esta en memoria
select sql_id, parsing_schema_name username, last_active_time begin_interval_time, 'MEM' source, round(avg_secs) avg_secs
from (
SELECT sql_id, parsing_schema_name,  last_active_time,
       ((elapsed_time)/(executions))/1e6 avg_secs
  FROM gv$sql
 WHERE executions > 0
)
),
before_exec as (
select sql_id, username, round(min(avg_secs)) avg_secs
from (
select s.sql_id,c.username,begin_interval_time,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
SUM(elapsed_time_total)/SUM(executions_total)/1e6 avg_secs
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time < sysdate+(1/1440*-&minutes)
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_total > 0
group by s.sql_id,c.username, begin_interval_time
order by avg_secs
)
where username <> 'SYS'
group by sql_id, username
)
select last_exec.*, 
before_exec.avg_secs min_avg_secs, 
(last_exec.avg_secs-before_exec.avg_secs) diff_sec, 
round(((last_exec.avg_secs)*100)/(decode(before_exec.avg_secs,0,1,before_exec.avg_secs))) diff_perc,
(select count(distinct plan_hash_value) from DBA_HIST_SQLSTAT where sql_id=last_exec.sql_id) distinct_plan_hash_values
 from last_exec, before_exec where
last_exec.sql_id = before_exec.sql_id
and 
last_exec.username = before_exec.username
and last_exec.avg_secs > before_exec.avg_secs
and ((select count(distinct plan_hash_value) from DBA_HIST_SQLSTAT where sql_id=last_exec.sql_id) > 1)
and (
((round(((last_exec.avg_secs)*100)/(decode(before_exec.avg_secs,0,1,before_exec.avg_secs))) > &8) 
 and 
(last_exec.avg_secs-before_exec.avg_secs) > &7)
)--Diff perc and Diff time sec
order by (last_exec.avg_secs-before_exec.avg_secs) desc
) where ROWNUM <= 5
union all
SELECT
    distinct sql_id /*SQIDs in active sessions*/
FROM (
select * from (
select s.username,sid,s.serial#, s.inst_id, machine, s.program, osuser, sql_id,to_char(LOGON_TIME,'DD-MM-YY HH24:MI:SS') as LOGON_TIME, ROUND((SYSDATE-LOGON_TIME)*(24*60),1) as Min_Logged_On
  , floor(last_call_et / 60) Min_Current_SQL, decode(background,1,'Y','N') as back_process,(select distinct(sql_text) from gv$sql where sql_id=s.sql_id) as sql_text,
  p.spid from gv$session s ,gv$process p where s.paddr = p.addr
 and s.username is not null and sql_id is not null and status = 'ACTIVE' and s.username <> 'SYS') where sql_text not like '%SQL Analyze%' and ROWNUM <= 5
)
WHERE sql_id is not null and
    ROWNUM <= 15
)
) loop

if vv.sql_id is not null then

dbms_output.put_line ('spool &6 append');
dbms_output.put_line ('prompt <p>');
dbms_output.put_line ('prompt <a href = "dc_perf_report_sqlid_'||vv.sql_id||'.html"  target="_blank">SQL Details for sqlid '||vv.sql_id||'</a>');
dbms_output.put_line ('prompt </p>');
--dbms_output.put_line ('prompt <div class="content">');
dbms_output.put_line ('spool off'); 
dbms_output.put_line ('spool dc_perf_report_sqlid_'||vv.sql_id||'.html');
--dbms_output.put_line ('@report_sql_monitor_sqlid '||vv.sql_id||' HTML');
dbms_output.put_line ('prompt <pre>');
dbms_output.put_line ('@ash/ashtop username,sql_id  sql_id='''||vv.sql_id||''' "SYSDATE-INTERVAL ''600'' MINUTE" sysdate');
dbms_output.put_line ('@sql.sql '||vv.sql_id);
dbms_output.put_line ('@dba_hist_snapshot_sqlid '||vv.sql_id||' %% %% &5');
dbms_output.put_line ('@plan_table_sqlid '||vv.sql_id);
dbms_output.put_line ('@plan_table_awr_sqlid '||vv.sql_id);
dbms_output.put_line ('prompt </pre>');
dbms_output.put_line ('spool off');
--dbms_output.put_line ('</div>');
end if;
end loop;
end;
/



