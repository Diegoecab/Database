-- ------------------------------------------------------------------------------
-- File       : link_base_table.sql
-- Purpose    : Oracle administration helper: link$.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @link$.sql
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
set lines 800
col passwordx for a300
col authpwdx for a20
set pages 5000

select
owner#, name, host, userid, password, authusr, authpwd, passwordx--, authpwdx
from sys.link$
where --upper(name) like upper('%&name%')
--and upper(host) like upper('%&host%')
--and 
upper(userid) like upper('%&userid%')
--and upper(password) like upper('%&password%')
--and 
--upper(authusr) like upper('%&authusr%')
/