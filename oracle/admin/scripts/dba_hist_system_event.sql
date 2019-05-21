--dba_hist_system_event.sql

--@nls_date
alter session set nls_date_format='DD-MON-YY';

@v$database
@v$instance

prompt
col event_name for a50
set lines 400
set pages 50000

select distinct WAIT_CLASS from V$SYSTEM_WAIT_CLASS;

prompt

select min(a.snap_id) min_snap_id, max(a.snap_id) max_snap_id, trunc(begin_interval_time) "DATE", a.wait_class wait_class, a.event_name event_name
, round(avg(a.total_waits)) total_waits_avg
, avg(a.total_timeouts) total_timeouts_avg
, round(avg((a.time_waited_micro)/1000000))  time_seconds_avg
, round(avg(decode ((a.total_waits), 0, to_number(NULL),((a.time_waited_micro)/1000) / (a.total_waits) ))) avgwait
from
dba_hist_system_event a,
dba_hist_snapshot b
where
(a.snap_id >= (select min(snap_id) from dba_hist_snapshot where to_char(begin_interval_time,'DD-MON-YY') = to_char(to_date('&BngTime'),'DD-MON-YY')))
and 
(a.snap_id <= (select max(snap_id) from dba_hist_snapshot where to_char(end_interval_time,'DD-MON-YY') = to_char(to_date('&EndTime'),'DD-MON-YY')))
and upper(wait_class) like upper('%&wait_class%')
and upper(event_name) like upper('%&event_name%')
and a.total_waits         > 0
and a.wait_class          <> 'Idle'
and b.snap_id = a.snap_id
group by trunc(begin_interval_time), a.wait_class,a.event_name
order by 1 --, a.wait_class, a.event_name
/