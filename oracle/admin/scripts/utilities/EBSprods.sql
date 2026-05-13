-- ------------------------------------------------------------------------------
-- File       : EBSprods.sql
-- Purpose    : Oracle administration helper: EBSprods.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @EBSprods.sql
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
set echo off veri off
accept 1 prompt 'Enter PATCH LEVEL (ej. 11i.FND.G):'

select patch_level, application_name
from apps.fnd_product_installations fpi
, apps.fnd_application_tl fat
where patch_level is not null
and fpi.application_id = fat.application_id
and PATCH_LEVEL like upper('%&&1%')
order by application_name
/
