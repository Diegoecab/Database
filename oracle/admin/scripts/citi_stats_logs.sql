--citi_stats_logs.sql

set lines 400
col step_detail for a50
set verify off

prompt Last n runs details

select a.*,round((fh_end-fh_start) *24*60) diff_mins from
dbadmin.stat_running_logs a
where id_job > ((select max (id_job) from dbadmin.stat_running_logs) - &runs)
order by id_job
/

prompt Last n runs, elapsed time group by owner

break on id_job skip 1
compute sum of diff_hours on id_job

select id_job,min(fh_start),max(fh_end),owner_name,round(sum((FH_END-FH_START) *24*60)) diff_mins,round(sum((fh_end-fh_start) *24)) diff_hours from
dbadmin.stat_running_logs a
where id_job > ((select max (id_job) from dbadmin.stat_running_logs) - &runs)
group by id_job,owner_name
order by id_job desc,diff_mins
/