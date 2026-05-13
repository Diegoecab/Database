-- ------------------------------------------------------------------------------
-- File       : trigger_database_x_ip_trace.sql
-- Purpose    : Oracle RAC or cluster administration helper: trigger database x ip trace.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trigger_database_x_ip_trace.sql
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
CREATE OR REPLACE TRIGGER trg_trace_seven
   AFTER LOGON ON DATABASE
BEGIN
   IF SYS_CONTEXT ('USERENV', 'IP_ADDRESS') = '10.80.60.39'
   THEN
	EXECUTE IMMEDIATE ('alter session set tracefile_identifier=SEVEN_NEW');

      EXECUTE IMMEDIATE ('alter session set timed_statistics = true');

      EXECUTE IMMEDIATE ('alter session set statistics_level=all');

      EXECUTE IMMEDIATE ('alter session set max_dump_file_size = unlimited');

      EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever,level 12''');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger'
                       );
END trg_trace_seven;
/



CREATE OR REPLACE TRIGGER trg_trace_bsbc_dw
   AFTER LOGON ON schema.BSBC_DW
BEGIN
	EXECUTE IMMEDIATE ('alter session set tracefile_identifier=BSBC_DW');

      EXECUTE IMMEDIATE ('alter session set timed_statistics = true');

      EXECUTE IMMEDIATE ('alter session set statistics_level=all');

      EXECUTE IMMEDIATE ('alter session set max_dump_file_size = unlimited');

      EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever,level 12''');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger'
                       );
END trg_trace_seven;
/


CREATE OR REPLACE TRIGGER trg_trace_DBA_DC22057
   AFTER LOGON ON DBA_DC22057.schema
BEGIN
	EXECUTE IMMEDIATE ('alter session set tracefile_identifier=BSBC_DW');

      EXECUTE IMMEDIATE ('alter session set timed_statistics = true');

      EXECUTE IMMEDIATE ('alter session set statistics_level=all');

      EXECUTE IMMEDIATE ('alter session set max_dump_file_size = unlimited');

      EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever,level 12''');
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error al ejecutar trigger :'||sqlerrm
                       );
END trg_trace_DBA_DC22057;
/