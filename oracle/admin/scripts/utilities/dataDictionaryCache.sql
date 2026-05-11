-- ------------------------------------------------------------------------------
-- File       : dataDictionaryCache.sql
-- Purpose    : Oracle administration helper: dataDictionaryCache.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dataDictionaryCache.sql
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
gets = # numero de solicitudes para el objeto 
getmisses = # numero de solicitudes para el objeto que fueron rechazadas Objetivo reducir el valor de rcradio a un valor inferior a 1

tarea: ajustar el valor del parametro SHARED_POOL_SIZE en el init.ora, incrementandolo en pequeñas cantidades.

SELECT SUM(GETS) HITS, SUM(GETMISSES) LIBMISS, SUM(GETMISSES)/SUM(GETS) RCRATIO FROM V$ROWCACHE ;
