-- ------------------------------------------------------------------------------
-- File       : sqlarea_user_io_w_time.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: sqlarea user io w time.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sqlarea_user_io_w_time.sql
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
--v$sqlarea_user_io_w_time
COL sql_text for a40
COL module for a20
SET pagesize 10000
select *
from
(select
     sql_text,
     sql_id,
     round(elapsed_time/1000000,2) elapsed_time_segundos,
     cpu_time,
     user_io_wait_time
  from
     sys.v_$sqlarea
  order by 5 desc)
where rownum < 6;