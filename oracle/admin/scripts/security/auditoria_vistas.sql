-- ------------------------------------------------------------------------------
-- File       : auditoria_vistas.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: auditoria vistas.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @auditoria_vistas.sql
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
select * from dba_audit_trail where username = 'GARBARRHH_LINK' order by timestamp desc;


select * from dba_obj_audit_opts

select * from DBA_STMT_AUDIT_OPTS

select * from DBA_PRIV_AUDIT_OPTS