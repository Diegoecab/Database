-- ------------------------------------------------------------------------------
-- File       : shared_pool_ora4031_errors.sql
-- Purpose    : Oracle administration helper: shared pool ora4031 errors.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @shared_pool_ora4031_errors.sql
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
PROMPT Ejecutar con SYS as sysdba
select 
kghlushrpool, 
kghlurcr, 
kghlutrn, 
kghlufsh, 
kghluops, 
kghlunfu, 
kghlunfs 
from 
sys.x$kghlu 
where 
inst_id = userenv('Instance') 
/
