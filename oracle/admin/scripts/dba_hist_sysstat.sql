--dba_hist_sysstat
REM 
REM 

set lines 400
set pages 999
set trimout on
set trimspool on
set feed on
col bytes heading 'mbytes'
col avg_bytes for 999999 justify r
set verify off
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

prompt
prompt Statistics example:
prompt user calls
prompt user commits
prompt

col n format a30


select stat_name, to_date(to_char(begin_interval_time,'dd/mm/yyyy hh24'),'dd/mm/yyyy hh24') begin_interval_time, value
from dba_hist_sysstat a, dba_hist_snapshot b
--where stat_name like '%stat%'
where upper(stat_name) like upper('%&stat%')
and a.snap_id=b.snap_id 
and begin_interval_time > sysdate-&days
--group by begin_interval_time,name
order by begin_interval_time
/

prompt avg x day
prompt


select stat_name, round(avg(value)), trunc(begin_interval_time)
begin_interval_time, to_char (trunc(begin_interval_time), 'Dy') "DAY"
from dba_hist_sysstat a, dba_hist_snapshot b
--where stat_name like '%stat%'
where upper(stat_name) like upper('%&stat%')
and a.snap_id=b.snap_id 
and begin_interval_time > sysdate-&days
group by trunc(begin_interval_time),stat_name
order by begin_interval_time
/