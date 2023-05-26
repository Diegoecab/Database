set lines 900
set pages 1000
SELECT
report_id,
con_id,
inst_id,
status,
username,
module,
action,
service_name,
program,
sid,
session_serial#,
elapsed_time,
-- gives up to 2000 characters of SQL statement
sql_text,
sql_id,
sql_exec_start,
sql_exec_id,
sql_plan_hash_value,
first_refresh_time,
last_refresh_time,
refresh_count
FROM gv$sql_monitor
WHERE sql_text IS NOT NULL
/