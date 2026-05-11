-- ------------------------------------------------------------------------------
-- File       : dba_objects_owner.sql
-- Purpose    : Oracle administration helper: dba objects owner.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_objects_owner.sql
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
set lines 132
set trims on
set verify off
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
accept OWNER prompt 'Ingrese Esquema: '
ttitle 'Objetos del esquema &OWNER'
select object_type,object_name,created,status from 
dba_objects where owner=upper('&OWNER');