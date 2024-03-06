--v$rman_backup_job_details.sql
col STATUS format a25
col hrs format 999.99
col start_time for a16
col end_time for a16
col compression_ratio heading 'Compress|Ratio' for 99.99
set pages 500
set lines 600
set verify off
select
SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi')   end_time,
round(compression_ratio,2) compression_ratio,
elapsed_seconds/3600                   hrs
from V$RMAN_BACKUP_JOB_DETAILS
--where STATUS='RUNNING'
order by START_TIME;