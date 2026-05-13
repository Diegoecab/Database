-- ------------------------------------------------------------------------------
-- File       : lock_mode_p1.sql
-- Purpose    : Oracle administration helper: lock mode p1.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @lock_mode_p1.sql
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
set lines 500
var p1 number;
exec :p1:=1414332422;

select CHR (BITAND (:p1, -16777216) / 16777215)
|| CHR (BITAND (:p1, 16711680) / 65535)
“Name”,
(BITAND (:p1, 65535))”Mode”
from dual;
