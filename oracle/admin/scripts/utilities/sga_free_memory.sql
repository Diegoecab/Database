-- ------------------------------------------------------------------------------
-- File       : sga_free_memory.sql
-- Purpose    : Oracle administration helper: sga free memory.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sga_free_memory.sql
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
--sga_free_memory

select POOL, round(bytes/1024/1024,0) FREE_MB
from v$sgastat
where name like '%free memory%';

PROMPT Para ver la memoria libre en toda la SGA:
PROMPT SELECT KSMCHCLS CLASS, COUNT(KSMCHCLS) NUM, SUM(KSMCHSIZ) SIZ, 
PROMPT To_char( ((SUM(KSMCHSIZ)/COUNT(KSMCHCLS)/1024)),'999,999.00')||'k' "AVG SIZE" 
PROMPT FROM X$KSMSP GROUP BY KSMCHCLS;
