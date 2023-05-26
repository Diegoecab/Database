--dba_hist_sysmetric_all.sql
set lines 170
set pages 9999

Prompt system metric values for the long-duration system metrics
Prompt remember:	DB Time = DB CPU + non_idle_wait_time (and non_idle_wait_time = DB Time - DB CPU)
Prompt 				CPU time Represents foreground and background processes spend on CPU, does not include time waiting on CPU.
prompt 				DB CPU Represents only foreground process spend on CPU.



col Physical_Read_Total_MBps heading 'Physical|Read|Total|MBps'
col Physical_Write_Total_MBps heading 'Physical|Write|Total|MBps'
col Redo_MBytes_per_sec heading 'Redo|MB|per|sec'
col Physical_Read_IOPS heading 'Physical|Read|IOPS'
col Physical_write_IOPS heading 'Physical|write|IOPS'
col Physical_redo_IOPS heading 'Physical|redo|IOPS'
col OS_LOad heading 'OS|LOad'
col DB_CPU_Usage_per_sec heading 'DB|CPU|Usage|per|sec'
col Host_CPU_util heading 'Host|CPU|util'
col Network_Mbytes_per_sec heading 'Network|MB|per|sec'
col Logons_Per_Sec heading 'Logons|Per|Sec'
col Database_Time_Per_Sec heading 'DB|Time|Per|Sec'



Break on SAMPLE_TIME on report

compute avg max of Physical_Read_Total_MBps Physical_Write_Total_MBps Redo_MBytes_per_sec Network_Mbytes_per_sec Host_CPU_util OS_LOad DB_CPU_Usage_per_sec Logons_Per_Sec on report


alter session set nls_date_format='dd-mm-yyyy hh24:mi';

select begin_time,
       round((sum(case metric_name when 'Physical Read Total Bytes Per Sec' then average end))/1024/1024,1) Physical_Read_Total_MBps,
       round((sum(case metric_name when 'Physical Write Total Bytes Per Sec' then average end))/1024/1024,1) Physical_Write_Total_MBps,
       round((sum(case metric_name when 'Redo Generated Per Sec' then average end))/1024/1024,1) Redo_MBytes_per_sec,
       round(sum(case metric_name when 'Physical Read Total IO Requests Per Sec' then average end)) Physical_Read_IOPS,
       round(sum(case metric_name when 'Physical Write Total IO Requests Per Sec' then average end)) Physical_write_IOPS,
       round(sum(case metric_name when 'Redo Writes Per Sec' then average end)) Physical_redo_IOPS,
       round(sum(case metric_name when 'Current OS Load' then average end)) OS_LOad,
	   round(sum(case metric_name when 'Database Time Per Sec' then average end)) Database_Time_Per_Sec,
       round(sum(case metric_name when 'CPU Usage Per Sec' then average end)) DB_CPU_Usage_per_sec,
       round(sum(case metric_name when 'Host CPU Utilization (%)' then average end)) Host_CPU_util, --NOTE 100% = 1 loaded RAC node
       round((sum(case metric_name when 'Network Traffic Volume Per Sec' then average end))/1024/1024,1) Network_Mbytes_per_sec,
	   round(sum(case metric_name when 'Logons Per Sec' then average end)) Logons_Per_Sec
from dba_hist_sysmetric_summary
where begin_time > SYSDATE - INTERVAL '&1' MINUTE
group by begin_time
union all
select begin_time,
       round((sum(case metric_name when 'Physical Read Total Bytes Per Sec' then value end))/1024/1024,1) Physical_Read_Total_MBps,
       round((sum(case metric_name when 'Physical Write Total Bytes Per Sec' then value end))/1024/1024,1) Physical_Write_Total_MBps,
       round((sum(case metric_name when 'Redo Generated Per Sec' then value end))/1024/1024,1) Redo_MBytes_per_sec,
       round(sum(case metric_name when 'Physical Read Total IO Requests Per Sec' then value end)) Physical_Read_IOPS,
       round(sum(case metric_name when 'Physical Write Total IO Requests Per Sec' then value end)) Physical_write_IOPS,
       round(sum(case metric_name when 'Redo Writes Per Sec' then value end)) Physical_redo_IOPS,
       round(sum(case metric_name when 'Current OS Load' then value end)) OS_LOad,
	   round(sum(case metric_name when 'Database Time Per Sec' then value end)) Database_Time_Per_Sec,
       round(sum(case metric_name when 'CPU Usage Per Sec' then value end)) DB_CPU_Usage_per_sec,
       round(sum(case metric_name when 'Host CPU Utilization (%)' then value end)) Host_CPU_util, --NOTE 100% = 1 loaded RAC node
       round((sum(case metric_name when 'Network Traffic Volume Per Sec' then value end))/1024/1024,1) Network_Mbytes_per_sec,
	   round(sum(case metric_name when 'Logons Per Sec' then value end)) Logons_Per_Sec
from v$sysmetric_history
where begin_time > SYSDATE - INTERVAL '&1' MINUTE
group by begin_time
order by 1
/