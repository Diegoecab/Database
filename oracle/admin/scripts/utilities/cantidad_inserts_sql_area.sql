-- ------------------------------------------------------------------------------
-- File       : cantidad_inserts_sql_area.sql
-- Purpose    : Oracle administration helper: cantidad inserts sql area.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cantidad_inserts_sql_area.sql
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
/*  Select muestra la cantidad de inserts en una tabla y dicha cantidad x minutos */

select substr(sql_text,instr(sql_text,'INTO "'),30) tabla,
       rows_processed      registros_procesados,
       round((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutos,
       trunc(rows_processed/((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60)) registros_x_minutos
from   sys.v_$sqlarea
where  sql_text like 'INSERT %INTO "%'
  and  command_type = 2
  and  open_versions > 0;





select rows_processed 
from v$sqlarea
where sql_text like 'INSERT %INTO "%'
and command_type = 2
and open_versions > 0;