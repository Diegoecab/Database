--ps_mon_checklist_det_history.sql
/*Todos los movimientos en un rango de fecha determinado, excluyendo el user ADMIN*/
set lines 1000
set pages 10000
set head off
set feed off
set verify off
col description for a30
col sla for a25
col country_name for a30
col eta for a25
col process_name for a80
col type_name for a20
col servername for a10
col comments for a30
col description for a40
col sla for a25
col country_name for a30
col eta for a25
col process_name for a60
col servername for a10
col warn_etd for a20
col crit_etd for a20
col warn_eta for a20
col crit_eta for a20
col warn_sla for a20
col crit_sla for a20
col etd for a12
col app_name for a20
alter session set current_schema=DBADMIN;
ACCEPT bbookdate DATE FORMAT 'dd-mon-yy' DEFAULT '01-NOV-14'-
PROMPT 'Enter date for "Book date (from):  '
ACCEPT ebookdate DATE FORMAT 'dd-mon-yy' DEFAULT '01-DEC-14'-
PROMPT 'Enter date for "Book date (end):  '
ACCEPT spool_name CHAR FORMAT 'A50' DEFAULT 'c:\temp\ps_mon_chklist_history.txt'-
PROMPT 'Enter file name [c:\temp\ps_mon_chklist_history.txt]:  '

spool &spool_name
select 
CHK_ID,P_DET_ID
 ,BOOK_DATE
 ,DATE_TYPE
 ,COUNTRY_CODE
 ,COUNTRY_N_DISPLAY
 ,PROCESS_NAME
 ,APP_NAME
 --,TYPE_NAME
 ,BEGIN_TIME
 ,END_TIME
 ,SLA
 ,ETA
 ,ALERT_ID
 ,WARN_ETA
 ,WARN_ETA_F
 ,CRIT_ETA
 ,CRIT_ETA_F
 ,WARN_SLA
 ,WARN_SLA_F
 ,CRIT_SLA
 ,CRIT_SLA_F
 ,ETD
 ,WARN_ETD
 ,WARN_ETD_F
 ,CRIT_ETD
 ,CRIT_ETD_F
 ,USER_NAME
 --,COMMENTS
 ,STATUS_NAME
from ps_mon_checklist_det_history where book_date between '&bbookdate' and '&ebookdate'
and user_name <> 'ADMIN'
order by 1;
spool off

