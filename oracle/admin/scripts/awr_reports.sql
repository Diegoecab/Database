--awr_reports.sql
set lines 300
set pages 1000

accept days prompt 'Days: '

SELECT dbid, snap_id, begin_interval_time, end_interval_time from dba_hist_snapshot
where begin_interval_time > sysdate - &days
order by begin_interval_time;


--11881

--SELECT output FROM TABLE (dbms_workload_repository.awr_report_text(1747444437, 1, 11881, 12063))