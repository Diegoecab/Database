-- ------------------------------------------------------------------------------
-- File       : bind_variables_sqlplus_sql.sql
-- Purpose    : Oracle administration helper: bind variables sqlplus sql(1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @bind_variables_sqlplus_sql(1).sql
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

VARIABLE P_FTTH NUMBER;
VARIABLE P_SATELITAL NUMBER;
VARIABLE P_OTROS_MODEMS varchar2(4000);

begin
 :P_FTTH:=256;
 :P_SATELITAL:=276;
 :P_OTROS_MODEMS:='33,242,259';
end;
/