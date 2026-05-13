-- ------------------------------------------------------------------------------
-- File       : dba_source_x.sql
-- Purpose    : Oracle administration helper: dba source x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_source_x.sql
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
set lines 400
set feedback off
set trims on
col owner for a20
col text for a150
col object_name for a40

select text from dba_source where 
owner like upper('%&owner%') 
and name like  upper('%&obj_name%')
order by owner,name,type,line;