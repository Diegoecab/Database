--dba_hist_snapshot


alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

col begin_interval_time for a25
col end_interval_time for a25
set pages 1000
set lines 300

prompt 'Registros de snapshots AWR'
accept days prompt 'Days: '

select snap_id, dbid, begin_interval_time,end_interval_time,error_count from dba_hist_snapshot 
where begin_interval_time > sysdate - &days
order by snap_id, dbid;

ttitle off