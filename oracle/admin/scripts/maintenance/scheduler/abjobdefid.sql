-- ------------------------------------------------------------------------------
-- File       : abjobdefid.sql
-- Purpose    : oracle/admin maintenance/scheduler helper: abjobdefid.
-- Engine     : oracle/admin
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: abjobdefid.sql
-- Parameters : system_name
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	
REM ======================================================================
REM abjobdefid.sql
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
REM 	Ejecutar con usuario dueño del repositorio: "alter session set current_schema=usuario"
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set verify off
set lines 400
set head off
set feed off

select distinct(JobDefinitionGUID) from OpJobDefinition
where applicationid in (select applicationid from OpApplication where systemid in
(select systemid from OpSystem where upper(NAME) = upper('&system_name')))
/
