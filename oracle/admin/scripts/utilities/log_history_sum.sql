-- ------------------------------------------------------------------------------
-- File       : log_history_sum.sql
-- Purpose    : Oracle administration helper: log history sum.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @log_history_sum.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
Break on Date on report 
compute sum of Megs_Tran on report 
set pagesize 100
ttitle "Transacciones por dia en MB Semana anterior"
SELECT  to_char(first_time, 'dd-mm-yyyy') "Date",
        count(*) * (Select
       distinct bytes / 1024 / 1024
from sys.v_$log) "Megs_Tran"    
FROM    V$log_history
where first_time < trunc(sysdate - 7)
and first_time > trunc(sysdate - 14)
group by to_char(first_time, 'dd-mm-yyyy')
order by 1
/

Break on Date on report 
compute sum of Megs_Tran on report 
set pagesize 100
ttitle "Transacciones por dia en MB"
SELECT  to_char(first_time, 'dd-mm-yyyy') "Date",
        count(*) * (Select
       distinct bytes / 1024 / 1024
from sys.v_$log) "Megs_Tran"    
FROM    V$log_history
where first_time > trunc(sysdate - 7)
group by to_char(first_time, 'dd-mm-yyyy')
order by 1
/