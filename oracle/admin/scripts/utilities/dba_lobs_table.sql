-- ------------------------------------------------------------------------------
-- File       : dba_lobs_table.sql
-- Purpose    : Oracle administration helper: dba lobs table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_lobs_table.sql
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
col tablespace_name for a20
col column_name for a20
set linesize 180
accept TABLE_NAME prompt 'Ingrese nombre de tabla: '
select a.owner,column_name,a.segment_name,index_name,b.tablespace_name,bytes/1024/1024 MB from dba_lobs a
inner join dba_segments b on b.segment_name=a.segment_name
 where table_name='&TABLE_NAME'
/
