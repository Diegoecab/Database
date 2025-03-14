-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

------------------------------------------------------------------------------------------------------------------------
--
-- File name:   dasqlmon.sql (v1.1)
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
-- Usage:       @dasqlmon <sqlid> <plan_hash_value> <from_time> <to_time>
--	@ash/dasqlmon 9t2w9qzyagf3h 361673312 sysdate+(1/1440*-500) sysdate+(1/1440*-200)
--  @ash/dasqlmon 1ntpr2hkbspd9 32142486 trunc(sysdate) sysdate
-- @ash/dasqlmon 8n0jvgdz8jv84 1735514003 trunc(sysdate-30)  sysdate
--@ash/dasqlmon 0792c6u5hspfx 1127158721 trunc(sysdate-30) sysdate
--@ash/dasqlmon 0tpqv24664f7s 3902699488 trunc(sysdate-10) sysdate

--
-- Notes:       This script runs on Oracle 11g+ and you should have the
--              Diagnostics license for using it as it queries
--              some separately licensed views.
--
------------------------------------------------------------------------------------------------------------------------
SET LINESIZE 999 PAGESIZE 5000 TRIMOUT ON TRIMSPOOL ON 

COL asqlmon_operation  HEAD Plan_Operation FOR a70
COL asqlmon_predicates HEAD PREDICATES     FOR a60 word_wrap
COL obj_alias_qbc_name FOR a40
COL options   FOR a30

COL asqlmon_plan_hash_value HEAD PLAN_HASH_VALUE
COL asqlmon_sql_id          HEAD SQL_ID  NOPRINT
COL asqlmon_sql_child       HEAD "CHILD"  PRINT
COL asqlmon_sample_time     HEAD SAMPLE_HOUR
COL projection FOR A520

COL pct_child HEAD "Activity %" FOR A8
COL pct_child_vis HEAD "Visual" FOR A12

COL asqlmon_id        HEAD "ID" FOR 9999
COL asqlmon_parent_id HEAD "PID"  FOR 9999


BREAK ON asqlmon_plan_hash_value SKIP 1 ON asqlmon_sql_id SKIP 1 ON asqlmon_sql_child SKIP 1 ON asqlmon_sample_time SKIP 1 DUP ON asqlmon_operation

PROMPT
PROMPT -- ASQLMon v1.1 - by Tanel Poder ( http://blog.tanelpoder.com ) - Display SQL execution plan line level activity breakdown from ASH

WITH  sample_times AS (
    select * from dual
), 
sq AS (
SELECT
    count(*) samples
  , ash.sql_id
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
AND ash.sql_id LIKE '&1'
AND ash.sql_plan_hash_value LIKE '&2'
AND ash.sample_time BETWEEN &3 AND &4
GROUP BY
    ash.sql_id
  , ash.sql_plan_hash_value
  , NVL(ash.sql_plan_line_id,1)
  , ash.sql_plan_operation
  , ash.sql_plan_options
  , ash.session_state
  , ash.event
)
SELECT
    plan.sql_id            asqlmon_sql_id
  , plan.plan_hash_value asqlmon_plan_hash_value
  , sq.samples * 10 seconds
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
    dba_hist_sql_plan plan
  , sq
WHERE
    1=1
AND sq.sql_id(+) = plan.sql_id
AND sq.sql_plan_line_id(+) = plan.id
AND sq.sql_plan_hash_value(+) = plan.plan_hash_value
AND plan.sql_id LIKE '&1'
AND plan.plan_hash_value LIKE '&2'
ORDER BY
    plan.plan_hash_value
  , plan.id
/
