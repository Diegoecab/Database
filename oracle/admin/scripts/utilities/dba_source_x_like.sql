-- ------------------------------------------------------------------------------
-- File       : dba_source_x_like.sql
-- Purpose    : Oracle administration helper: dba source x like.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_source_x_like.sql
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
col object_name for a40 heading "Nombre de Objeto"
--accept OWNER prompt 'Ingrese Nombre de owner: '
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '
accept LIKE prompt 'Like: '

select LINE,TEXT from dba_source where name= upper('&OBJ_NAME') and 
text like '%&LIKE%'
order by line;
--select * from dba_source where owner='&OWNER' and name='&OBJ_NAME';


--sucursales empresa horario recurso fecha especifica por JIRA