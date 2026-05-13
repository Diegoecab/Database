-- ------------------------------------------------------------------------------
-- File       : dba_constraints_x.sql
-- Purpose    : Oracle administration helper: dba constraints x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_constraints_x.sql
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
col column_name for a20
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '

select constraint_name,constraint_type,r_owner,r_constraint_name,status from dba_constraints where owner=UPPER('&OWNER') and table_name=upper('&TABLA') order by 1,2;

select constraint_name,column_name,position from dba_cons_columns where owner=UPPER('&OWNER') and table_name=upper('&TABLA') order by 1,2;