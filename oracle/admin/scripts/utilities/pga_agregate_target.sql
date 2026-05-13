-- ------------------------------------------------------------------------------
-- File       : pga_agregate_target.sql
-- Purpose    : Oracle administration helper: pga agregate target.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pga_agregate_target.sql
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
/* El total de área de trabajo no puede ser superior a 200 megabytes de 
RAM debido a la configuración predeterminada de _pga_max_size. (200mb) (parametro oculto)*/

/* Ningún tipo de RAM puede utilizar más de un 5% de pga_aggregate_target o _pga_max_size, el que sea menor. 
Esto significa que la tarea no puede utilizar más de 200 megabytes (tamaño _pga_max_size) para ordenar o se suma hash. 
El algoritmo reduce aún más a este (200 / 2) */

/* Estas restricciones se hicieron para asegurar que ningún gran tipo arge sorts o hash joins se une a la zona RAM PGA*/
/* hay algunos secretos para optimizar la PGA*/
