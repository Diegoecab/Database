col what for a40
col nls_env for a20
col interval for a10
col misc_env for a30
col job for 999
col schema_user for a10
col priv_user for a10
col misc_env for a5
col log_user for a10
col failures for 9
set linesize 200
set pagesize 100
select job,what,last_date,last_sec,next_date,total_time,log_user,priv_user,schema_user,broken,interval,failures from dba_jobs;