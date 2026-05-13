-- ------------------------------------------------------------------------------
-- File       : PGA_OrdenamientosenDisco.sql
-- Purpose    : Oracle administration helper: PGA OrdenamientosenDisco.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @PGA_OrdenamientosenDisco.sql
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
Select d.value as disco,
m.value as memoria,
(d.value/m.value) * 100 as razon
from v$sysstat d, v$sysstat m
where d.name = 'sorts (disk)'
and m.name = 'sorts (memory)';

Si el resultado de la razón sobrepasa el 5% puede pensarse aumentar el valor para los parámetros SORT_AREA_SIZE o PGA_AGREGATE_TARGET.