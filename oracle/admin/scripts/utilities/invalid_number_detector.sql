-- ------------------------------------------------------------------------------
-- File       : invalid_number_detector.sql
-- Purpose    : Oracle administration helper: invalid number detector.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @invalid_number_detector.sql
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
set serveroutput on
DECLARE
  v_char_err SMSCHANNEL.TBL_OUTBOX.identification%type;
  v_to_num NUMBER;
BEGIN
  FOR i IN
  (SELECT identification FROM SMSCHANNEL.TBL_OUTBOX
  )
  LOOP
    v_char_err:=i.identification;
    v_to_num  :=i.identification;    
  END LOOP;
EXCEPTION
WHEN OTHERS THEN
  dbms_output.put_line (v_char_err);                                          
  dbms_output.put_line (SUBSTR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE(),1,4000)); 
END;
/