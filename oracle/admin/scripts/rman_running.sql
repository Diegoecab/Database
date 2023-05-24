--rman_running
col STATUS format a10 truncate
col hrs format 999.99
col start_time heading 'First backup|command|time' for a20
col end_time heading 'Last backup|command|time' for a20
col compression_ratio heading 'Compress|Ratio' for 99.99
set pages 500
set lines 300
set verify off
col time_taken_display for a20 truncate
col avg_output_kbytes_per_sec heading 'output|kbytes per sec|Average' for 999999
col avg_input_kbytes_per_sec heading 'input|kbytes per sec|Average' for 999999
col input_kbytes_per_sec heading 'input|kbytes per sec' for 999999
col output_kbytes_per_sec heading 'output|kbytes per sec' for 999999
col output_device_type heading 'Device' for a10 truncate
col actual_elap_hours heading 'Actual|Elapsed|Time(Hs)' for 999
col elap_hours heading 'Elapsed|Time(Hs)'for 999
col elap_mins heading 'Elapsed|Time(Min)' for 99999
col avg_hrs heading 'Avg|Elapsed|Time(Hs)' for 99999
col elap_pct heading 'Elapsed|Time|Taken(%)' for 9999
col actual_elap_pct heading 'Actual|Elapsed|Time|Taken(%)' for 9999
col avg_mb_x_min heading 'MBytes| per|Min(avg)' for 9999
col mb_x_min heading 'MBytes| per Min' for 9999
col input_gb heading 'Input|MB'
col output_gb heading 'Output|MB'

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';


with stats as (
select
 INPUT_TYPE,output_device_type, count(*) cnt, min(START_TIME) min_start_time, max(end_time) last_end_time,round(max(elapsed_seconds/3600),1) max_hrs,round(min(elapsed_seconds/3600),1) min_hrs,
round(avg(elapsed_seconds/3600),1)                   avg_hrs,
round(median(elapsed_seconds/3600),1)                   median_hrs,
round(stddev (elapsed_seconds/3600),1)                   stddev_hrs,
round(avg(input_bytes_per_sec/1024),1) avg_input_kbytes_per_sec,
round(avg(output_bytes_per_sec/1024),1) avg_output_kbytes_per_sec,
round(avg((input_bytes/1024/1024)/(elapsed_seconds/60)),1) avg_mb_x_min
from V$RMAN_BACKUP_JOB_DETAILS
where STATUS='COMPLETED'
group by INPUT_TYPE,output_device_type
),
running as (
select
session_key,  input_type, output_device_type, status, start_time,end_time,
round((elapsed_seconds/3600),1) elap_hours,round((elapsed_seconds/60),1) elap_mins,
round((input_bytes_per_sec/1024),1) input_kbytes_per_sec,
round((output_bytes_per_sec/1024),1) output_kbytes_per_sec,
round(input_bytes/1024/1024/1024,1) input_gb,
round(input_bytes/1024/1024/1024,1) output_gb,
(input_bytes/1024/1024)/(elapsed_seconds/60) mb_x_min
from V$RMAN_BACKUP_JOB_DETAILS
where STATUS like 'RUNNING%'
) select a.*,'|',b.avg_hrs,b.avg_mb_x_min,b.avg_input_kbytes_per_sec,avg_output_kbytes_per_sec,'|',a.elap_hours*100/b.avg_hrs elap_pct from running a join stats b 
on b.input_type=a.input_type and b.output_device_type=a.output_device_type
 order by elap_pct;


