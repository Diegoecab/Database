-- ------------------------------------------------------------------------------
-- File       : cache_flush(liberar_memoria).sql
-- Purpose    : Oracle administration helper: cache flush(liberar memoria).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cache_flush(liberar_memoria).sql
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
/* FLUSH BUFFER DE BASE DE DATOS  */

ALTER SYSTEM FLUSH BUFFER_CACHE;

/* SHARED POOL */

ALTER SYSTEM FLUSH SHARED_POOL;