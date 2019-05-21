select to_char(begin_time,'DD-MON-YY HH24:MI:SS') begin_time, to_char(end_time,'DD-MON-YY HH24:MI:SS') end_time, 
round(average,4)  avg_physical_read_io_per_sec,
round((select average from DBA_HIST_SYSMETRIC_SUMMARY b where metric_name  = 'Physical Write IO Requests Per Sec' and b.begin_time=a.begin_time and b.end_time = a.end_time),4) avg_physical_write_io_per_sec,
round((select average from DBA_HIST_SYSMETRIC_SUMMARY b where metric_name  = 'CPU Usage Per Sec' and b.begin_time=a.begin_time and b.end_time = a.end_time),4) avg_db_cpu_usage_per_sec
from dba_hist_sysmetric_summary a
where metric_name = 'Physical Read IO Requests Per Sec'
and begin_time >= '01-AUG-13' order by begin_time
/