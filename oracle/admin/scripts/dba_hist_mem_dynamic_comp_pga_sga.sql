--dba_hist_mem_dynamic_comp_pga_sga.sql

--alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

set lines 400
set pages 999
set trimout on
set trimspool on
set feed on
col bytes heading 'mbytes'
col component for a15

col n format a30


select to_char(begin_interval_time,'DD-MON-YY HH24:MI:SS') begin_interval_time, 
component, current_Size/1024/1024, min_size/1024/1024, max_size/1024/1024
from dba_hist_mem_dynamic_comp a, dba_hist_snapshot b
where component in ('SGA Target' ,'PGA Target') 
and a.snap_id=b.snap_id and 
begin_interval_time between TRUNC(sysdate) and sysdate
order by begin_interval_time,component;
