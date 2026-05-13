-- ------------------------------------------------------------------------------
-- File       : spfile.sql
-- Purpose    : Oracle administration helper: spfile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @spfile.sql
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
col test format a40
/*indica si algùn paràmetro està seteado en el spfile*/
select decode(count(*), 1, 'SI', 'NO' ) SPFILE
from v$spparameter
where rownum=1 and isspecified='TRUE'
/
prompt
col value format a 60
select value from v$parameter where name = 'spfile'
/