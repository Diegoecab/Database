-- ------------------------------------------------------------------------------
-- File       : library_miss_ratio.sql
-- Purpose    : oracle/admin utilities helper: library miss ratio.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: library_miss_ratio.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	Library Cache Miss Ratio
REM ======================================================================
REM library_miss_ratio.sql		Version 1.1	26 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

select 	sum(PINS) Executions,
	sum(RELOADS) cache_misses,
	sum(RELOADS) / sum(PINS) miss_ratio
from 	v$librarycache;