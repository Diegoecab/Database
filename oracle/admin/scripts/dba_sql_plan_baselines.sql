--@dba_sql_plan_baselines
set lines 200
COLUMN sql_handle FORMAT A20
COLUMN plan_name FORMAT A30

SELECT created, sql_handle, plan_name, enabled, accepted,fixed,origin, executions
FROM   dba_sql_plan_baselines
WHERE  sql_text LIKE '%&1%';