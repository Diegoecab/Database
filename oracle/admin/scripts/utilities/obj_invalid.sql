-- ------------------------------------------------------------------------------
-- File       : obj_invalid.sql
-- Purpose    : oracle/admin utilities helper: obj invalid.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: obj_invalid.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	Script para listar los objetos invalidos en la base de datos
REM ======================================================================
REM obj_invalid.sql		Version 1.1	10 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
col object_name for a30
col object_type for a10
col TEXT for a100
set linesize 200
select a.owner,object_type,object_name,b.line, b.text from dba_objects a join dba_errors b on b.owner=a.owner
and b.name=a.object_name
and status <>'VALID' group by a.owner,object_type,object_name,b.line,b.text
order by 1,2,3,4;