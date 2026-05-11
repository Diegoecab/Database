-- ------------------------------------------------------------------------------
-- File       : reintentos_escritura_redo.sql
-- Purpose    : Oracle administration helper: reintentos escritura redo.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @reintentos_escritura_redo.sql
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
SELECT retries.value/entries.value||' %' AS  Indicador_de_Reintentos 
FROM v$sysstat retries, v$sysstat entries 
WHERE retries.name = 'redo buffer allocation retries' 
AND entries.name = 'redo entries';

/* Muestra Cuanto tiempo tuvo que esperar un usuario para almacenar una entrada en el Buffer Redo Log, 
debido a que el proceso LGWR no ha terminado aún de escribir el contenido del Buffer en el disco. (los Archivos Redo Log)*/
SELECT username usuario, seconds_in_wait tiempo_de_espeta, state estado
FROM v$session_wait, v$session
WHERE v$session_wait.sid = v$session.sid
AND event LIKE '%log buffer space%';