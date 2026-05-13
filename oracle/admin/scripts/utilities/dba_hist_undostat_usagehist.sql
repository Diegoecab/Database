--dba_hist_undostat_usagehist
REM   
REM ======================================================================
REM dba_hist_undostat_usagehist.sql        Version 1.1   Agosto 2019
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM 
REM Dependencias:
REM
REM
REM Notas:
REM
REM
REM Precauciones:
REM
REM ======================================================================
REM

prompt ======================================================================
prompt
prompt SSOLDERRCNT: Longest running queries which could have caused ORA-01555
prompt MAXQUERYSQLID: SQL identifier of the longest running SQL statement in the period
prompt 
prompt ======================================================================
alter session set nls_date_format='DD-MM-YY HH24:MI:SS';

set pages 300
set lines 1000
select * from(
select INSTANCE_NUMBER, TO_CHAR(begin_time, 'DD-MON-YY HH24:MI') begin_Time, 
round(((UNEXPIREDBLKS)*8192)/1024/1024/1024)UNEXPIREDBLKS_GB, 
round(((EXPIREDBLKS)*8192)/1024/1024/1024)EXPIREDBLKS_GB,
round(((ACTIVEBLKS)*8192)/1024/1024/1024) ACTIVEBLKS_GB,
nospaceerrcnt,
SSOLDERRCNT, --Longest running queries which could have caused ORA-01555
MAXQUERYSQLID,--SQL identifier of the longest running SQL statement in the period
MAXQUERYLEN,/*Identifies the length of the longest query (in seconds) executed in the instance during the period. 
You can use this statistic to estimate the proper setting of the UNDO_RETENTION initialization parameter. 
The length of a query is measured from the cursor open time to the last fetch/execute time of the cursor. 
Only the length of those cursors that have been fetched/executed during the period are reflected in the view.*/
(select sql_text from dba_hist_sqltext where sql_id = MAXQUERYSQLID) sql_text,
round(((ACTIVEBLKS+UNEXPIREDBLKS+expiredblks)*8192)/1024/1024/1024) total_usage,
tuned_undoretention
from dba_hist_undostat where begin_time > sysdate-(nvl('&sysdate',1))
--group by INSTANCE_NUMBER, TO_CHAR (begin_time, 'DD-MON-RR HH24'), nospaceerrcnt
order by to_date(begin_time)
) 
where 
total_usage > nvl('&total_usage',0)
and
nospaceerrcnt > nvl('&nospaceerrcnt',-1)
/

prompt ======================================================================
prompt
Prompt group by Day
prompt
prompt ======================================================================

set pages 300
set lines 1000
select * from(
select INSTANCE_NUMBER, TO_CHAR(begin_time, 'DD-MON-YY') begin_Time, 
max(round(((ACTIVEBLKS+UNEXPIREDBLKS)*8192)/1024/1024/1024)) total_usage,
max(round(((ACTIVEBLKS+UNEXPIREDBLKS+expiredblks)*8192)/1024/1024/1024)) total_usage_plus_expired,
sum(nospaceerrcnt) nospaceerrcnt,
sum(SSOLDERRCNT) SSOLDERRCNT,
tuned_undoretention
from dba_hist_undostat where begin_time > sysdate-(nvl('&sysdate',1))
group by INSTANCE_NUMBER, TO_CHAR (begin_time, 'DD-MON-YY')
order by to_date(begin_Time)
) 
/


prompt ======================================================================
prompt
Prompt group by Hour:MIn
prompt
prompt ======================================================================

set pages 300
set lines 1000
select * from(
select INSTANCE_NUMBER, TO_CHAR(begin_time, 'DD-MON-YY HH24:MI') begin_Time, 
max(round(((ACTIVEBLKS+UNEXPIREDBLKS)*8192)/1024/1024/1024)) total_usage,
max(round(((ACTIVEBLKS+UNEXPIREDBLKS+expiredblks)*8192)/1024/1024/1024)) total_usage_plus_expired,
sum(nospaceerrcnt) nospaceerrcnt,
sum(SSOLDERRCNT) SSOLDERRCNT,
MAX(MAXQUERYLEN),
tuned_undoretention
from dba_hist_undostat where begin_time > sysdate-(nvl('&sysdate',1))
and (SSOLDERRCNT > nvl('&SSOLDERRCNT',-1)
or nospaceerrcnt > nvl('&nospaceerrcnt',-1))
group by INSTANCE_NUMBER, TO_CHAR (begin_time, 'DD-MON-YY HH24:MI'), tuned_undoretention
order by to_date(begin_Time)
)
/