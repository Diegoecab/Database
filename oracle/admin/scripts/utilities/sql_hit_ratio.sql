-- ------------------------------------------------------------------------------
-- File       : sql_hit_ratio.sql
-- Purpose    : oracle/admin utilities helper: sql hit ratio.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sql_hit_ratio.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	SQL Cache Hit Ratio
REM ======================================================================
REM sql_hit_ratio.sql		Version 1.1	26 Marzo 2010
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

select 	sum(PINS) Pins,
	sum(RELOADS) Reloads,
	round((sum(PINS) - sum(RELOADS)) / sum(PINS) * 100,2) Hit_Ratio
from 	v$librarycache;