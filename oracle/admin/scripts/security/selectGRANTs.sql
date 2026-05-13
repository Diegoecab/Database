-- ------------------------------------------------------------------------------
-- File       : selectGRANTs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: selectGRANTs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @selectGRANTs.sql
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
/*Select de grants dados a un objeto en particular*/
SELECT   /*+ RULE */
         PRIVILEGE, GRANTEE, GRANTABLE, GRANTOR, COLUMN_NAME
    FROM SYS.DBA_COL_PRIVS
   WHERE TABLE_NAME = :TNAME AND OWNER = :LOWNER
ORDER BY GRANTEE