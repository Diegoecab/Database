--dba_hist_sgastat_shared_pool_gmonth
REM  
REM   This script can be used at the end of a business day to see a matrix
REM   of data for the entries in v$sgastat through the previous business day.
REM   By default we look at hours 1-13 (6am through 6pm of AWR repository
REM   data from the previous day).   You can change the where clause information
REM   to look at whatever range of time you want to see, but peak activity times is
REM   best.
REM
REM    You can load this output in to Excel and create a line graph
REM     to see spikes of memory allocations or drops in free memory.
REM 

alter session set nls_date_format='MM/YYYY';

set lines 400
set pages 999
set trimout on
set trimspool on
set feed on
col bytes heading 'mbytes'
col avg_bytes for 999999 justify r

col n format a30


select '"'||name||'"' n, to_date(to_char(
trunc(begin_interval_time,'mm'),'mm/yyyy'),'mm/yyyy')
begin_interval_time,
round(avg(bytes/1024/1024)) avg_mbytes,
round(max(bytes/1024/1024)) max_mbytes,
round(min(bytes/1024/1024)) min_mbytes
from dba_hist_sgastat a, dba_hist_snapshot b
where pool='shared pool' and a.snap_id=b.snap_id
group by trunc(begin_interval_time,'mm'),name
order by 1,2;