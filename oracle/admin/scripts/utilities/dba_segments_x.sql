-- ------------------------------------------------------------------------------
-- File       : dba_segments_x.sql
-- Purpose    : Oracle administration helper: dba segments x (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_segments_x (1).sql
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
set linesize 200
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '

select owner,segment_type,tablespace_name,
blocks,extents,buffer_pool,sum(bytes)/1024/1024 MB 
from 
dba_Segments 
where 
segment_name=upper('&OBJ_NAME') 
group by owner,segment_type,tablespace_name,blocks,extents,buffer_pool;