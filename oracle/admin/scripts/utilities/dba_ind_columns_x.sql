-- ------------------------------------------------------------------------------
-- File       : dba_ind_columns_x.sql
-- Purpose    : Oracle administration helper: dba ind columns x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_ind_columns_x.sql
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
set pagesize 100
col index_owner for a30
col index_name for a40
col column_name for a30
accept OWNER_TABLA prompt 'Ingrese Owner de la tabla: '
accept NOMBRE_TABLA prompt 'Ingrese Nombre de Tabla: '
SELECT index_owner,index_name,column_name,column_position
FROM dba_ind_columns 
WHERE table_owner=UPPER('&OWNER_TABLA')
AND
table_name=UPPER('&NOMBRE_TABLA')
/
