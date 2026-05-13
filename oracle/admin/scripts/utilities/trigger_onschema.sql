-- ------------------------------------------------------------------------------
-- File       : trigger_onschema.sql
-- Purpose    : Oracle administration helper: trigger onschema.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trigger_onschema.sql
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
CREATE OR REPLACE TRIGGER dbsnmp_tr
   AFTER LOGON ON dbsnmp.schema
BEGIN
if (sys_context('USERENV','PROXY_USER') is null) then
raise_application_error
                       (-20001,
                        'Login not allowed'
                       );
end if;
END dbsnmp_tr;
/



CREATE OR REPLACE TRIGGER trg_logon_bsbc_dw
   AFTER LOGON ON bsbc_dw.schema
BEGIN
     EXECUTE IMMEDIATE ('alter session set  tracefile_identifier =''2015_bsbc_dw''');
	 EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever, level 8''');
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger trg_logon_bsbc_dw'
                       );
END trg_logon_bsbc_dw;
/