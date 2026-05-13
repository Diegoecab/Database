-- ------------------------------------------------------------------------------
-- File       : sqlarea.sql
-- Purpose    : Oracle administration helper: sqlarea.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sqlarea.sql
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
--v$sqlarea
set lines 600
col sql_text for a100
col module for a20
set pagesize 10000

select *
from
(select substr(sql_text,1,100),
        sql_id,
		rows_processed,
        elapsed_time,
        cpu_time,
        user_io_wait_time
from    sys.v_$sqlarea
order by 6 desc)
where rownum < 10;