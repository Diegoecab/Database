-- ------------------------------------------------------------------------------
-- File       : dba_segments_tbs.sql
-- Purpose    : Oracle administration helper: dba segments tbs (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_segments_tbs (1).sql
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
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
accept Tablespace prompt 'Ingrese Tablespace: '
Break on segment_name on report 
compute sum of mb on report

select OWNER,SEGMENT_TYPE,SEGMENT_NAME,sum(bytes)/1024/1024 MB 
from dba_Segments where 
tablespace_name=upper('&TABLESPACE') 
GROUP BY SEGMENT_TYPE,SEGMENT_NAME,OWNER order by 3,1,2;