--shared_pool_usage_dly.sql

set lines 400
set pages 999
set termout on
set trimout on
set trimspool on
set feed off
col bytes heading 'mbytes'
col avg_bytes for 999999 justify r
set verify off
set head on

col n format a30

select '"'||name||'"' n, to_date(to_char(
trunc(begin_interval_time,'dd'),'dd/mm/yyyy'),'dd/mm/yyyy')
begin_interval_time,
round(avg(bytes/1024/1024)) avg_mbytes,
round(max(bytes/1024/1024)) max_mbytes,
round(min(bytes/1024/1024)) min_mbytes
from dba_hist_sgastat a, dba_hist_snapshot b
where pool='shared pool' and a.snap_id=b.snap_id
and name like '%&name%'
and begin_interval_time > sysdate - &days
group by trunc(begin_interval_time,'dd'),name
order by 1,2
/