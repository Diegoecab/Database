-- ------------------------------------------------------------------------------
-- File       : dba_views_x.sql
-- Purpose    : Oracle administration helper: dba views x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_views_x.sql
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
prompt Query de Vista
set verify off
set long 10000
accept OWNER prompt 'Ingrese Owner de vista: '
accept VISTA prompt 'Ingrese Nombre de vista: '
select TEXT from dba_views where owner=upper('&OWNER') and view_name=upper('&VISTA');