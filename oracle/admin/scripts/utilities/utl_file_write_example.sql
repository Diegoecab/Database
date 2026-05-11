-- ------------------------------------------------------------------------------
-- File       : utl_file_write_example.sql
-- Purpose    : Oracle administration helper: utl file write example.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @utl_file_write_example.sql
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
SET SERVEROUTPUT ON
DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN

	fileHandler := UTL_FILE.FOPEN('CDP_LOG', 'test_file2.txt', 'W');
		for z in 1 .. 1000 loop
		  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
		end loop;
  UTL_FILE.FCLOSE(fileHandler);


EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;
/

