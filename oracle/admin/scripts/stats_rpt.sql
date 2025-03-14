set feed off
set echo off
set lines 120
set pages 5000
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
clear breaks
clear columns
break on job_id on report
compute sum of cnt on report
compute sum of cnt_tot on report
compute sum of cnt_exec on report
compute sum of sum_mins on report


prompt


ttitle center 'Citi DBA Global Stats Summary Report' skip 1 center ==================================== skip 5
---

prompt

select b.job_id, started, a.* from dbadmin.dbs_stats_crontab a, dbadmin.dbs_stats_queue b 
where b.status = 'RUNNING' and b.cron_id = a.cron_id order by job_id
/

ttitle off
prompt
prompt Summary Jobs

select a.job_id,cron_id,
(select count(*) from dbadmin.dbs_stale_stats where job_id = a.job_id) cnt_to_exec,
(select count(*) from dbadmin.dbs_stats_queue_details where job_id = a.job_id and status='SUCCEEDED') cnt_executed,
round(((select count(*) from dbadmin.dbs_stats_queue_details where job_id = a.job_id and status='SUCCEEDED') * 100) / (select count(*) from dbadmin.dbs_stale_stats where job_id = a.job_id)) pct_exec,
(select count(*) from dbadmin.dbs_stats_queue_details where job_id = a.job_id and status='STOPPED') cnt_stopped
from dbadmin.dbs_stats_queue_details a, dbadmin.dbs_stats_queue b
where a.job_id = b.job_id
and b.status = 'RUNNING' and b.job_id in (select job_id from dbadmin.dbs_stats_queue where status='RUNNING')
group by a.job_id,cron_id
order by a.job_id desc
/

prompt
prompt Jobs currently running - Group by job_id , schema_name

select a.job_id, a.schema_name, count(*) cnt from dbadmin.dbs_stale_stats a, dbadmin.dbs_stats_queue_details b 
where a.stale_id=b.stale_id and b.job_id in (select job_id from dbadmin.dbs_stats_queue where status='RUNNING')
and b.status = 'RUNNING'
group by a.job_id, a.schema_name order by 3 desc
/

prompt
prompt Jobs properly completed - Group by job_id , schema_name

select job_id, schema_name,
(select count(*) from dbadmin.dbs_stale_stats b where b.job_id = a.job_id and b.schema_name = a.schema_name) cnt_tot,
cnt_exec,
round(((a.cnt_exec)*100) / (select count(*) from dbadmin.dbs_stale_stats b where b.job_id = a.job_id and b.schema_name = a.schema_name)) pct_exec,
sum_mins
from (
select a.job_id, a.schema_name, count(*) cnt_exec, round(sum(((started + run_duration) - started ) *24*60),1) sum_mins
from dbadmin.dbs_stale_stats a, dbadmin.dbs_stats_queue_details b
where a.stale_id=b.stale_id and b.job_id in (select job_id from dbadmin.dbs_stats_queue where status='RUNNING')
and b.status = 'SUCCEEDED'
group by a.job_id, a.schema_name ) a
order by pct_exec, sum_mins desc
/

prompt