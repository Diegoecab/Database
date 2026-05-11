-- ------------------------------------------------------------------------------
-- File       : ps_mon_chklist_det_history_guser.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: ps mon chklist det history guser.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @ps_mon_chklist_det_history_guser.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--ps_mon_chklist_det_history_guser.sql
/*
Todos los movimientos en un rango de fecha determinado,  excluyendo el user ADMIN
agrupado por usuario
*/
set lines 1000
set pages 10000
set head on
set feed on
alter session set current_schema=DBADMIN;
ACCEPT btime DATE FORMAT 'dd-mon-yy' DEFAULT '01-NOV-14'-
PROMPT 'Enter date for "Book date (from):  '
ACCEPT etime DATE FORMAT 'dd-mon-yy' DEFAULT '01-DEC-14'-
PROMPT 'Enter date for "Book date (end):  '
ACCEPT spool_name CHAR FORMAT 'A50' DEFAULT 'c:\temp\ps_mon_chklist_det_history_guser.txt'-
PROMPT 'Enter file name [c:\temp\ps_mon_chklist_det_history_guser.txt]:  '

spool &spool_name
select to_char(insert_time,'dd-mon-yy hh24'), user_name, full_name, count(*)
from 
(select * from ps_mon_checklist_det_history where insert_time between '&btime' and '&etime' and user_name <> 'ADMIN' order by insert_time)
group by user_name,  full_name, to_char(insert_time,'dd-mon-yy hh24')
order by to_char(insert_time,'dd-mon-yy hh24')
/

spool off