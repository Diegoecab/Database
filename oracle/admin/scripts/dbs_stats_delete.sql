set feed on
set timing on
delete from dbadmin.dbs_stale_stats a 
where job_id = &job_id
and table_name in ('SM_AVERAGE','SM_ACCOUNT_MOVEMENTS')
and inserts=0 and deletes=0 and updates=0 and truncated='YES'
and not exists (select 1 from dbadmin.dbs_stats_queue_details where job_id=a.job_id and stale_id=a.stale_id)
/

commit;

set timing off