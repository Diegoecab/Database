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
ACCEPT binsert_time DATE FORMAT 'dd-mon-yy' DEFAULT '01-NOV-14'-
PROMPT 'Insert time format dd-mon-yy (from):  '
ACCEPT einsert_time DATE FORMAT 'dd-mon-yy' DEFAULT '01-DEC-14'-
PROMPT 'Insert time format dd-mon-yy (end):  '
ACCEPT spool_name CHAR FORMAT 'A50' DEFAULT 'c:\temp\ps_mon_checklist_det_history.txt'-
PROMPT 'Enter file name [c:\temp\ps_mon_checklist_det_history.txt]:  '

spool &spool_name
select 
*
from ps_mon_checklist_det_history where insert_time between '&binsert_time' and '&einsert_time'
and user_name <> 'ADMIN'
order by 1;
spool off
