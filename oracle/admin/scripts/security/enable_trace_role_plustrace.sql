-- ------------------------------------------------------------------------------
-- File       : enable_trace_role_plustrace.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: enable trace role plustrace.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @enable_trace_role_plustrace.sql
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
CONNECT / AS SYSDBA
SET DEFINE OFF;
CREATE ROLE PLUSTRACE NOT IDENTIFIED;

GRANT SELECT ON  SYS.V_$MYSTAT TO PLUSTRACE;
GRANT SELECT ON  SYS.V_$SESSTAT TO PLUSTRACE;
GRANT SELECT ON  SYS.V_$STATNAME TO PLUSTRACE;

GRANT PLUSTRACE TO AHS_SOP;

CONNECT AHS_SOP/AHS_SOP

@?/rdbms/admin/utlxplan.sql
