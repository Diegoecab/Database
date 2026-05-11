-- ------------------------------------------------------------------------------
-- File       : dba_db_links_x.sql
-- Purpose    : Oracle administration helper: dba db links x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_db_links_x.sql
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
set verify off
col db_link for a20
col host for a20
col owner for a15
col db_link heading "Nombre|DB Link" for a50
col username heading "Usuario" for a20
accept owner prompt 'Ingrese owner:  '
select owner,db_link,username,host from dba_db_links where owner=upper('&OWNER') order by 1;