--
Prompt
Prompt How To Calculate The Required Network Bandwidth Transfer Of Redo In Data Guard Environments (Doc ID 736755.1)
Prompt
--DBA_HIST_SYSMETRIC_HISTORY ( This view contains snapshots of V$SYSMETRIC_HISTORY.)
col inst_id for 99
set lines 400
Break on inst_id on report

compute avg max sum of avg_mbps max_mbps max_redo_per_sec avg_redo_per_sec on report

prompt required avg_mbps last 30 days
select inst_id, round((((avg(redo_per_sec))/ 0.75) * 8)/1000000) avg_mbps, round((((max(redo_per_sec))/ 0.75) * 8)/1000000) max_mbps  from (
select instance_number inst_id,-- to_char(begin_time,'DD-MON-YY HH24:MI:SS') begin_time, to_char(end_time,'DD-MON-YY HH24:MI:SS') end_time, 
value  redo_per_sec
from dba_hist_sysmetric_history a
where metric_name = 'Redo Generated Per Sec'
and begin_time > sysdate-1
) group by inst_id;

prompt required avg_mbps last 1 days by day:hour
select to_char(begin_time,'YYYY-MM-DD HH24'), avg(VALUE), max(VALUE) from DBA_HIST_SYSMETRIC_HISTORY where metric_name = 'Redo Generated Per Sec' 
and begin_time > trunc(sysdate-1)
group by to_char(begin_time,'YYYY-MM-DD HH24')
order by 2;

/*

set colsep ";"
set headsep off
set pagesize 0
set trimspool on
spool redo_per_sec.csv
select to_char(begin_time,'YYYY-MM-DD;HH24'), avg(VALUE), max(VALUE) from DBA_HIST_SYSMETRIC_HISTORY where metric_name = 'Redo Generated Per Sec' 
and begin_time > sysdate-30
group by to_char(begin_time,'YYYY-MM-DD;HH24')
order by 2;
spool off
*/