-- ------------------------------------------------------------------------------
-- File       : filestat_tbs.sql
-- Purpose    : Oracle administration helper: filestat tbs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @filestat_tbs.sql
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
REM v$filestat_tbs.sql
set pages 500 lines 110

clear col bre buffer
col tablespace_name format a15 hea 'TABLESPACE'
col file_name format a24 hea 'DATAFILE'
--break on tablespace_name skip
break on tablespace on report 
compute sum of total on report 

select tablespace_name, regexp_replace(file_name,'^.*.\/.*.\/', '') file_name,
sum(phyrds) reads, sum(phywrts) writes, sum(phyrds)+sum(phywrts) total
from dba_data_files, v$filestat
where file_id=file# group by tablespace_name, file_name
order by tablespace_name, file_name;