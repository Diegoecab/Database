-- ------------------------------------------------------------------------------
-- File       : dba_constraints_r.sql
-- Purpose    : Oracle administration helper: dba constraints r.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_constraints_r.sql
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
--dba_constraints_r
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col r_owner for a20
col column_name for a20
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '
ttitle 'Constraints que hacen referencia a la tabla &OWNER - &TABLA'
select owner,table_name,constraint_name,constraint_type,
r_constraint_name,status 
from dba_constraints where r_owner= UPPER('&OWNER')
and r_constraint_name in (select constraint_name
from dba_constraints where table_name = upper('&TABLA')
and owner = UPPER('&OWNER') 
)
order by 1,2;
ttitle off