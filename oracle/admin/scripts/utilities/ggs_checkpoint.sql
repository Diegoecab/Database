-- ------------------------------------------------------------------------------
-- File       : ggs_checkpoint.sql
-- Purpose    : Oracle administration helper: ggs checkpoint.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @ggs_checkpoint.sql
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
set lines 20000
col CURRENT_DIR for a100
col LOG_CMPLT_XIDS for a100
col LOG_BSN for a100
col LOG_CSN for a100
col LOG_XID for a100
col LOG_CMPLT_CSN for a100
col LOG_CMPLT_XIDS  for a100     
select * from OGG_USER.GGS_CHECKPOINT;