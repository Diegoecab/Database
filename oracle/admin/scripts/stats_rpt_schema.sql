select trunc(c.started), round(sum(((b.started + run_duration) - b.started ) *24*60),1) sum_mins, count(*) from 
dbadmin.dbs_stale_stats a, dbadmin.dbs_stats_queue_details b, dbadmin.dbs_stats_queue c
 where
a.schema_name like  upper('%&schema_name%') and b.stale_id = a.stale_id
and c.job_id = a.job_id
group by trunc(c.started) order by 1
/
