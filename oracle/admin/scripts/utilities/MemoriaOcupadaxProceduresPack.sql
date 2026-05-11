-- ------------------------------------------------------------------------------
-- File       : MemoriaOcupadaxProceduresPack.sql
-- Purpose    : Oracle administration helper: MemoriaOcupadaxProceduresPack.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @MemoriaOcupadaxProceduresPack.sql
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
Este script permite determinar cuánta memoria está siendo usada por los objetos de tipo funcion, procedimiento, y paquete. El resultado de la ejecución de este script se debe entender en Bytes.

SELECT SUM(sharable_mem)as cantidad_memoria
FROM V$DB_OBJECT_CACHE
WHERE type in ('FUNCTION', 'PROCEDURE', 'PACKAGE', 'PACKAGE BODY')

