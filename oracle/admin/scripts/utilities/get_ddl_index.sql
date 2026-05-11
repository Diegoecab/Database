-- ------------------------------------------------------------------------------
-- File       : get_ddl_index.sql
-- Purpose    : Oracle administration helper: get ddl index.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_ddl_index.sql
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
set heading off;
set echo off;
set verify off;
Set pages 999;
set feedback off
set long 90000;
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept OWNER prompt 'Ingrese Owner: '
select 'set timing on' from dual;
select 'prompt Creando indice '||owner||'.'||index_name||' ...'
||dbms_metadata.get_ddl('INDEX',index_name,'&OWNER') from dba_indexes
where owner=upper('&OWNER');
set feedback on