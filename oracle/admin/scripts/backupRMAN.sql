set feedback off
set linesize 150
col INPUT_MBYTES format 999,999
select START_TIME,END_TIME,INPUT_TYPE,STATUS,round(INPUT_BYTES/1024/1024)INPUT_MBYTES,OUTPUT_DEVICE_TYPE,AUTOBACKUP_DONE
from V$RMAN_BACKUP_JOB_DETAILS
order by start_time;
col controlfile_included format a20
select
CONTROLFILE_INCLUDED       ,
PIECES                       ,
START_TIME                    ,
ELAPSED_SECONDS                ,
DEVICE_TYPE              ,
round(ORIGINAL_INPUT_BYTES/1024/1024) IMPUT_MBYTES
from v$BACKUP_SET_DETAILS
order by start_time
/
