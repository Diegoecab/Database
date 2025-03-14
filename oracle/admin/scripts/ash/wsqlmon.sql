-----------------------------------------------------------------------------------------------------------------------
--
-- File name:   wsqlmon.sql (based on asqlmon.sql v1.1)
--
-- Purpose:     Report SQL-monitoring-style drill-down into where in an execution plan the execution time is spent
--
-- Author:      Tanel Poder
--
-- Copyright:   (c) http://blog.tanelpoder.com - All rights reserved.
--
-- Disclaimer:  This script is provided "as is", no warranties nor guarantees are
--              made. Use at your own risk :)
--              
-- Usage:       @wsqlmon <sqlid> <child#> <begin_snap_id> <end_snap_id)
--
-- Example      @wsqlmon g510xbhrxhcqd 0 1 999999999
--
-- Notes:       This script runs on Oracle 11g+ and you should have the
--              Diagnostics and Tuning pack licenses for using it as it queries
--              some separately licensed views.
--
-- Modification: 
--              jkstill 2016-08-23 - made to work with AWR and renamed to wsqlmon.sql
------------------------------------------------------------------------------------------------------------------------
SET LINESIZE 999 PAGESIZE 5000 TRIMOUT ON TRIMSPOOL ON 

COL asqlmon_operation  HEAD Plan_Operation FOR a70
COL asqlmon_predicates HEAD PREDICATES     FOR a70 word_wrap
COL options   FOR a30

COL asqlmon_plan_hash_value HEAD PLAN_HASH_VALUE
COL asqlmon_sql_id          HEAD SQL_ID  NOPRINT
COL asqlmon_sql_child       HEAD CHILD#  NOPRINT
COL asqlmon_sample_time     HEAD SAMPLE_HOUR
COL projection FOR A50 truncate

COL pct_child HEAD "Activity %" FOR A8
COL pct_child_vis HEAD "Visual" FOR A20

COL asqlmon_id        HEAD "ID" FOR 9999
COL asqlmon_parent_id HEAD "PID"  FOR 9999
COL obj_alias_qbc_name for a40 truncate

COL event format a50


BREAK ON asqlmon_plan_hash_value SKIP 1 ON asqlmon_sql_id SKIP 1 ON asqlmon_sql_child SKIP 1 ON asqlmon_sample_time SKIP 1 DUP ON asqlmon_operation

PROMPT
--PROMPT -- ASQLMon v1.1 - by Tanel Poder ( http://blog.tanelpoder.com ) - Display SQL execution plan line level activity breakdown from ASH

WITH  sample_times AS (
    select * from dual
), 
sq AS (
SELECT
    count(*) samples
  , ash.sql_id
  , ash.sql_child_number
  , ash.sql_plan_hash_value
  , NVL(ash.sql_plan_line_id,1) sql_plan_line_id -- this is because simple "planless" operations like single-row insert
  , ash.sql_plan_operation
  , ash.sql_plan_options
  , ash.session_state
  , ash.event
--  , AVG(ash.p3) avg_p3 -- p3 is sometimes useful for listing block counts for IO wait events
FROM
    dba_hist_active_sess_history ash
WHERE
    1=1
AND ash.sql_id LIKE '&&1'
AND ash.sql_child_number LIKE '&2'
and ash.snap_id between &3 and &4
GROUP BY
    ash.sql_id
  , ash.sql_child_number
  , ash.sql_plan_hash_value
  , NVL(ash.sql_plan_line_id,1)
  , ash.sql_plan_operation
  , ash.sql_plan_options
  , ash.session_state
  , ash.event
)
SELECT
    plan.sql_id            asqlmon_sql_id
  --, plan.child_number      asqlmon_sql_child
--  , plan.plan_hash_value asqlmon_plan_hash_value
  , sq.samples seconds
  , LPAD(TO_CHAR(ROUND(RATIO_TO_REPORT(sq.samples) OVER (PARTITION BY sq.sql_id, sq.sql_plan_hash_value) * 100, 1), 999.9)||' %',8) pct_child
  , '|'||RPAD( NVL( LPAD('#', ROUND(RATIO_TO_REPORT(sq.samples) OVER (PARTITION BY sq.sql_id, sq.sql_plan_hash_value) * 10), '#'), ' '), 10,' ')||'|' pct_child_vis
--, LPAD(plan.id,4)||CASE WHEN parent_id IS NULL THEN '    ' ELSE ' <- ' END||LPAD(plan.parent_id,4) asqlmon_plan_id
  , plan.id asqlmon_id
  , plan.parent_id asqlmon_parent_id
  , LPAD(' ', depth, ' ') || plan.operation ||' '|| plan.options || NVL2(plan.object_name, ' ['||plan.object_name ||']', null) asqlmon_operation
  , sq.session_state
  , sq.event
--  , sq.avg_p3 
  , plan.object_alias || CASE WHEN plan.qblock_name IS NOT NULL THEN ' ['|| plan.qblock_name || ']' END obj_alias_qbc_name
  , CASE WHEN plan.access_predicates IS NOT NULL THEN '[A:] '|| plan.access_predicates END || CASE WHEN plan.filter_predicates IS NOT NULL THEN ' [F:]' || plan.filter_predicates END asqlmon_predicates
--  , plan.projection
FROM
    --v$sql_plan plan
	 dba_hist_sql_plan plan
  , sq
WHERE
    1=1
AND sq.sql_id(+) = plan.sql_id
--AND sq.sql_child_number(+) = plan.child_number
AND sq.sql_plan_line_id(+) = plan.id
AND sq.sql_plan_hash_value(+) = plan.plan_hash_value
AND plan.sql_id LIKE '&1'
ORDER BY
   plan.plan_hash_value
  , plan.id
/
