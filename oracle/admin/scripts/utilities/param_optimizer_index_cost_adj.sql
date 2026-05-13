-- ------------------------------------------------------------------------------
-- File       : param_optimizer_index_cost_adj.sql
-- Purpose    : oracle/admin utilities helper: param optimizer index cost adj.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: param_optimizer_index_cost_adj.sql
-- Parameters : Review script body before running.
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM Detalles de parametro optimizer_index_cost_adj
REM ======================================================================
REM param_optimizer_index_cost_adj.sql		Version 1.1	29 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM

optimizer_index_cost_adj

Con ayuda de este parámetro podemos hacer que las decisiones de acceso del optimizador hacia los datos favorezcan el uso de índices antes que del uso de Full table scan.

Este parámetro permite agregar un factor de ponderación al enfoque basado en costes cuando se realiza la evaluación de los índices 