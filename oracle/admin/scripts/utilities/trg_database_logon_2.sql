-- ------------------------------------------------------------------------------
-- File       : trg_database_logon_2.sql
-- Purpose    : Oracle administration helper: trg database logon 2.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trg_database_logon_2.sql
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
CREATE OR REPLACE TRIGGER trg_database_logon
   AFTER LOGON ON DATABASE
BEGIN
   IF SYS_CONTEXT ('USERENV', 'session_user') = 'ORABPEL'
   THEN
      execute immediate ('ALTER SESSION SET SQL_TRACE=TRUE');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
END trg_database_logon;
/