-- ------------------------------------------------------------------------------
-- File       : Privilegios.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: Privilegios.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Privilegios.sql
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
Ejemplo

Grants de sistema:

SELECT 'GRANT '||PRIVILEGE||' TO '||GRANTEE||' ;' FROM DBA_SYS_PRIVS WHERE GRANTEE IN ('GEM_ADM','GEM_VTA','GEMINIS')


Grants de usuario:


SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||' ;'  FROM DBA_TAB_PRIVS WHERE GRANTEE IN ('CAJERO','GEMINIS','GEM_VTA','SUPERVISOR')


Grant execute a procedures:



SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||' ;'  FROM DBA_TAB_PRIVS 
WHERE PRIVILEGE='EXECUTE' AND TABLE_NAME IN (SELECT PROCEDURE_NAME FROM DBA_PROCEDURES) AND OWNER !='SYS'