-- ------------------------------------------------------------------------------
-- File       : commit_status.sql
-- Purpose    : Oracle administration helper: commit status.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @commit_status.sql
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
SELECT SYSDATE FROM DUAL;

select value,sid from v$sesstat
where sid in (select sid
from v$session where username = upper('&1'))
and statistic# in (select statistic#
from v$statname where name like '%user%commit%')
/

select used_ublk, used_urec 
from v$transaction where ADDR in ( select taddr from v$session where username = upper('&1'))
/

--@active_session_waits (o waits)

@session_undo (o undo)
@iduser datastage

-- select count(*) from schema.table;