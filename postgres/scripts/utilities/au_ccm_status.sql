-- ------------------------------------------------------------------------------
-- File       : au_ccm_status.sql
-- Purpose    : postgres utilities helper: au ccm status.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: au_ccm_status.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Cluster Cache Management Status
SELECT buffers_sent_last_minute*8/60 AS warm_rate_kbps, 
   100*(1.0-buffers_sent_last_scan/buffers_found_last_scan) AS warm_percent 
   FROM aurora_ccm_status();