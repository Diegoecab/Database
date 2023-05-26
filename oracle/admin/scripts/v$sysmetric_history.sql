--v$sysmetric_history.sql
set lines 350
set pages 9999
set verify off

col C_CPU                 heading 'CPU'
col C_OTHER               heading 'OTH|ER'
col C_APPLICATION         heading 'APP|LIC|ATI|ON'
col C_CONFIGURATION       heading 'CON|FIG|URA|TIO|N'
col C_ADMINISTRATIVE      heading 'ADM|INI|STR|ATI|VE'
col C_CONCURRENCY         heading 'CON|CUR|REN|CY'
col C_COMMIT              heading 'COM|MIT'
col C_NETWORK             heading 'NET|WOR|K'
col C_USER_IO             heading 'USE|R_I|O'
col C_SYSTEM_IO           heading 'SYS|TEM|IO'
col C_SCHEDULER           heading 'SCH|EDU|LER'
col C_CLUSTER             heading 'CLU|STE|R'
col C_QUEUEING            heading 'QUE|UEI|NG'
col MAX_AVERAGE_WAITER_COUNT heading 'MAX|AVG|WAI|TER|CNT'
col CPU_COUNT for a10 heading 'CPU|CNT'

alter session set nls_date_format='dd-mm-yyyy hh24:mi';

PROMPT Wait events

SELECT TO_CHAR(begin_time,'hh24:mi') BEGIN_TIME
,      round(c_cpu           ,1) C_CPU
,      round(c_other         ,1) C_OTHER
,      round(c_application   ,1) C_APPLICATION
,      round(c_configuration ,1) C_CONFIGURATION
,      round(c_administrative,1) C_ADMINISTRATIVE
,      round(c_concurrency   ,1) C_CONCURRENCY
,      round(c_commit        ,1) C_COMMIT
,      round(c_network       ,1) C_NETWORK
,      round(c_user_io       ,1) C_USER_IO
,      round(c_system_io     ,1) C_SYSTEM_IO
,      round(c_scheduler     ,1) C_SCHEDULER
,      round(c_cluster       ,1) C_CLUSTER
,      round(c_queueing      ,1) C_QUEUEING
,      MAX(CEIL(c_queueing)) OVER() MAX_AVERAGE_WAITER_COUNT
,      (SELECT value FROM v$parameter WHERE name='cpu_count') CPU_COUNT
FROM (
   SELECT * 
   FROM (
      SELECT begin_time
      ,      wait_class#
      ,      SUM(average_waiter_count) OVER (PARTITION BY begin_time ORDER BY wait_class#) average_waiter_count_acc
      FROM (
         SELECT begin_time,
                wait_class#,
                average_waiter_count 
         FROM v$waitclassmetric_history
         WHERE wait_class# <> 6
        UNION
         SELECT begin_time
         ,      -1 wait_class#
         ,      value/100 average_waiter_count 
         FROM v$sysmetric_history 
         WHERE metric_id = 2075
           AND group_id = 2
           )
        ) tb 
   PIVOT (
      MAX(average_waiter_count_acc) 
      FOR wait_class# IN (-1 as c_cpu,0 AS c_other,1 AS c_application,2 AS c_configuration,3 AS c_administrative,4 AS c_concurrency,
                          5 AS c_commit,7 AS c_network, 8 AS c_user_io,9 AS c_system_io,10 AS c_scheduler,11 AS c_cluster,12 AS c_queueing)
         )
   ORDER BY begin_time
     )
ORDER BY begin_time;



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


Prompt system metric values for the long-duration system metrics for last hour


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
order by 1;