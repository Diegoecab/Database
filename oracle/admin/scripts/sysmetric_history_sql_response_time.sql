--sysmetric_history_sql_response_time minutes
set pages 1000
set verify off


COLUMN avgplusstddev NEW_VALUE _avgplusstddev NOPRINT
COLUMN avg_standard_deviation NEW_VALUE _standard_deviation NOPRINT
COLUMN Average NEW_VALUE _Average NOPRINT


with ucpsec
as
(select avg(average - STANDARD_DEVIATION ) m1,
        avg(average +  STANDARD_DEVIATION ) m2
from dba_hist_sysmetric_summary
where metric_name='User Calls Per Sec'
)
select
      avg(a.average) "Average",
       avg(a.average + a.STANDARD_DEVIATION)  "avgplusstddev",
	   avg(a.STANDARD_DEVIATION) avg_standard_deviation
from dba_hist_sysmetric_summary a,
dba_hist_sysmetric_summary b,
ucpsec e
where a.metric_name='SQL Service Response Time'
and b.metric_name='User Calls Per Sec'
and a.snap_id = b.snap_id
and b.average between e.m1 and e.m2
/

select to_char(begin_time,'dd-mm-yyyy hh24:mi') btime,
 value, round(value/&_standard_deviation,1) timesplusstddev
 from gv$sysmetric_history
 where 
 begin_time > SYSDATE - INTERVAL '&1' MINUTE
 and METRIC_NAME in ('SQL Service Response Time')
 ORDER BY 1
/

Prompt Summary


select avg(value) avg_value_current, &_Average avg_hist, &_standard_deviation stddev, round(avg(value)/&_standard_deviation,1) timesplusstddev
 from gv$sysmetric_history
 where 
 begin_time > SYSDATE - INTERVAL '&1' MINUTE
 and METRIC_NAME in ('SQL Service Response Time')
 ORDER BY 1
/