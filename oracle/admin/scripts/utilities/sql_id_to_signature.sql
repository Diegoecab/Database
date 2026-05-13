-- ------------------------------------------------------------------------------
-- File       : sql_id_to_signature.sql
-- Purpose    : Oracle administration helper: sql id to signature.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_id_to_signature.sql
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
--sql_id_to_signature.sql
SET SERVEROUTPUT ON
DECLARE
 SQL_TEXT   CLOB;
 SIG       NUMBER;
BEGIN
 SELECT SQL_TEXT
 INTO SQL_TEXT
 FROM DBA_HIST_SQLTEXT
 WHERE SQL_ID = '&sql_id';
 SIG := DBMS_SQLTUNE.SQLTEXT_TO_SIGNATURE (SQLTEXT, FALSE);
 DBMS_OUTPUT.PUT_LINE ('SIGNATURE=' || SIG);
END;
/