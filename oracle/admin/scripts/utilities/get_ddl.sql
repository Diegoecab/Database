-- ------------------------------------------------------------------------------
-- File       : get_ddl.sql
-- Purpose    : Oracle administration helper: get ddl (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_ddl (1).sql
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
Set pages 999;
set feedback off
set long 90000;
accept OWNER prompt 'Ingrese Owner: '
accept TYPE prompt 'Ingrese tipo Objeto: '
accept NAME prompt 'Ingrese Nombre de objeto: '
select dbms_metadata.get_ddl('&TYPE','&NAME','&OWNER') from dual;
set feedback on