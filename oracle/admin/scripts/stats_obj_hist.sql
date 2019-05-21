--stats_obj_hist
set lines 400
set verify off

col run_duration for a20
select a.job_id, b.stale_id, started, run_duration, a.table_name, last_analyzed, a.partition_name, inserts, updates, deletes, num_rows
from dbadmin.dbs_stale_stats a, dbadmin.dbs_stats_queue_details b 
where
a.schema_name like upper('%&schema_name%') 
and a.table_name like upper ('%&table_name%')
and nvl(a.partition_name,0) like upper(nvl('%&partition_name%',0))
and b.stale_id = a.stale_id
/
