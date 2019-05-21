--cpu_usage-per_second-per-session.sql
prompt CPU Usage (per second): This metric represents the CPU usage per second by the database processes, measured in hundredths of a second. 
prompt A change in the metric value may occur because of a change in either workload mix or workload throughput being performed by the database. Although there is no ‘correct’ value for this metric, it can be used to detect a change in the operation of a system. For example, an increase in Database CPU usage from 500 to 750 indicates that the database is using 50% more CPU. ('No correct value' means that there is no single value that can be applied to any database. The value is a characteristic of the system and the applications running on the system.)

set lines 400
set pages 1500
col begin_time for a20
col metric_name for a20
col average heading 'CPU Usage|Per Sec|Average' for 9999999
col host_cpu_usage_per_sec heading 'Host|CPU|Usage|Per Sec' for 999999
col host_cpu_utilization_percent heading 'Host|CPU|Util|Percent' for 999999
col PCT_CPU_USAGE_PER_SEC heading 'CPU Usage|Per Second|Percent' for 999
col host_cnt_cpu_based_80 heading 'CPU Count|Used|Based on|80 CPUs' for 999
/*
set verify off
with a as (
select to_char(begin_interval_time,'MM/DD/YYYY HH24:MI') begin_time, 
metric_name, round(average) average,
(select average from DBA_HIST_SYSMETRIC_SUMMARY z where z.snap_id = b.snap_id and z.metric_name='Host CPU Usage Per Sec') host_cpu_usage_per_sec,
(select average from DBA_HIST_SYSMETRIC_SUMMARY z where z.snap_id = b.snap_id and z.metric_name='Host CPU Utilization (%)') host_cpu_utilization_percent
from 
DBA_HIST_SYSMETRIC_SUMMARY a, dba_hist_snapshot b
           WHERE b.end_interval_time > '22-AUG-13' --sysdate-&days
             AND a.snap_id = b.snap_id
and metric_name = 'CPU Usage Per Sec'
order by begin_interval_time)
select begin_time||';'||metric_name||';'||average||';'||round(host_cpu_usage_per_sec)||';'||round(host_cpu_utilization_percent)||';'||round(((average* 100) / host_cpu_usage_per_sec))
--(host_cpu_utilization_percent*80/100) host_cnt_cpu_based_80,
from a
/
*/

set lines 400
set pages 1500
col begin_time for a20
col metric_name for a20
col maxval heading 'CPU Usage|Per Sec|Maxval' for 9999999
col host_cpu_usage_per_sec heading 'Host|CPU|Usage|Per Sec' for 999999
col host_cpu_utilization_percent heading 'Host|CPU|Util|Percent' for 999999
col PCT_CPU_USAGE_PER_SEC heading 'CPU Usage|Per Second|Percent' for 999
col host_cnt_cpu_based_80 heading 'CPU Count|Used|Based on|80 CPUs' for 999
set verify off
with a as (
select to_char(begin_interval_time,'MM/DD/YYYY HH24:MI') begin_time, 
metric_name, round(Maxval) Maxval,
(select Maxval from DBA_HIST_SYSMETRIC_SUMMARY z where z.snap_id = b.snap_id and z.metric_name='Host CPU Usage Per Sec') host_cpu_usage_per_sec,
(select Maxval from DBA_HIST_SYSMETRIC_SUMMARY z where z.snap_id = b.snap_id and z.metric_name='Host CPU Utilization (%)') host_cpu_utilization_percent
from 
DBA_HIST_SYSMETRIC_SUMMARY a, dba_hist_snapshot b
           WHERE b.end_interval_time > '22-AUG-13' --sysdate-&days
             AND a.snap_id = b.snap_id
and metric_name = 'CPU Usage Per Sec'
order by begin_interval_time)
select begin_time||';'||metric_name||';'||Maxval||';'||round(host_cpu_usage_per_sec)||';'||round(host_cpu_utilization_percent)||';'||round(((Maxval* 100) / host_cpu_usage_per_sec))
--(host_cpu_utilization_percent*80/100) host_cnt_cpu_based_80,
from a
/