-- ------------------------------------------------------------------------------
-- File       : mon_imp_perf.sql
-- Purpose    : Oracle administration helper: mon imp perf.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @mon_imp_perf.sql
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
col table_name for a30
col rows_processed for 999
select
   substr(sql_text,instr(sql_text,'into "'),30) table_name,
   rows_processed, round((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutes,
   trunc(rows_processed/((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60)) rows_per_minute
from  
   sys.v_$sqlarea
where 
   sql_text like 'insert %into "%' and command_type = 2 and open_versions > 0; 