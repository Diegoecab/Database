-- ------------------------------------------------------------------------------
-- File       : compile.sql
-- Purpose    : Oracle administration helper: compile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @compile.sql
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
set pagesize 0
select  'alter ' || decode(object_type, 'PACKAGE BODY', 'package', object_type) ||
       ' ' ||  object_name|| ' compile' ||  decode(object_type, 'PACKAGE BODY', ' body;', ';')
from   dba_objects
where  status <> 'VALID' and object_name like '&1%'

/