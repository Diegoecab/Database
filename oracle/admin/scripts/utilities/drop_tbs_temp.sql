-- ------------------------------------------------------------------------------
-- File       : drop_tbs_temp.sql
-- Purpose    : Oracle administration helper: drop tbs temp (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @drop_tbs_temp (1).sql
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
CREATE TEMPORARY TABLESPACE TEMP2
TEMPFILE '/oradata/orada/sdfsdf.dbf' SIZE 3072M AUTOEXTEND ON NEXT 128M MAXSIZE 4096M;

ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP2;

ALTER DATABASE TEMPFILE ‘+disco/BD/tempfile/datafile’ OFFLINE;

DROP TABLESPACE TEMP INCLUDING CONTENTS AND DATAFILES;