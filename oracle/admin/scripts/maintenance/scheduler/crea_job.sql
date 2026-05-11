-- ------------------------------------------------------------------------------
-- File       : crea_job.sql
-- Purpose    : Oracle database maintenance helper: crea job.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @crea_job.sql
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
/* JOB Ejemplo...*/

SET SERVEROUTPUT ON
DECLARE
  X NUMBER;
  JobNumber VARCHAR2(100);
BEGIN
  SYS.DBMS_JOB.SUBMIT
    (
      job        => X
     ,what       => 'execute immediate ''alter system flush buffer_cache'';'
     ,next_date  => to_date('15/06/2010 23:50:00','dd/mm/yyyy hh24:mi:ss')
     ,interval   => 'SYSDATE+1'
     ,no_parse   => FALSE
    );
JobNumber := to_char(X);
sys.dbms_output.put_line('Job creado nro.: ' ||JobNumber);
END;
/
commit;