-- ------------------------------------------------------------------------------
-- File       : lob_size.sql
-- Purpose    : postgres storage helper: lob size.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: lob_size.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
Select max((octet_length(native_message))/(1024)) as "size in KB" from clinical_message; 

Select max((octet_length(<COL_NAME>))/(1024)) as “size in KB” from <TABLE_NAME>; 
