col STATUS format a9
col hrs format 999.99
col start_time for a16
col end_time for a16
set pagesize 100
select
SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi')   end_time,
elapsed_seconds/3600                   hrs
from V$RMAN_BACKUP_JOB_DETAILS
order by session_key;