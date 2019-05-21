--citi_stats_schema.sql
alter session set current_schema=DBADMIN;
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
set verify off
set lines 400
col status for a15
col job_id for 9999
col schema_name for a20

select job_id, status, started, schema_name, cnt_stale, executed, round((executed*100)/cnt_stale) pct_executed from (
select a.job_id, b.status, started, schema_name, count(*) cnt_stale, 
(
select count(*) from  dbadmin.dbs_stale_stats z 
where job_id = a.job_id 
and schema_name=a.schema_name 
and exists (select 1 from dbs_stats_queue_details where job_id = z.job_id and schema_name = z.schema_name and stale_id = z.stale_id and status='SUCCEEDED')
) executed
from
dbs_stale_stats a, dbadmin.dbs_stats_queue b 
where schema_name like upper('%&schema_name%') 
and a.job_id=b.job_id
and started > trunc (sysdate - nvl(&days,0))
group by a.job_id, b.status, started, schema_name order by a.job_id desc
) a
/