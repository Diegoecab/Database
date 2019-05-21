col what for a100
col nls_env for a20
col interval for a40
col misc_env for a30
col job for 99999
col schema_user for a20
col priv_user for a10
col misc_env for a5
col log_user for a20
col failures for 99999
col drop_job for a100

set linesize 400
set pagesize 100

select schema_user,job,what,last_date,last_sec,next_date,total_time,log_user,broken,interval,failures, 
'execute sys.DBMS_IJOB.REMOVE('||job||');' drop_job from dba_jobs
where broken like upper('%&broken%')
and schema_user like upper('%&schema_user%')
;