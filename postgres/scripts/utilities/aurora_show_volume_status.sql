-- ------------------------------------------------------------------------------
-- File       : aurora_show_volume_status.sql
-- Purpose    : postgres utilities helper: aurora show volume status.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: aurora_show_volume_status.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
\! echo 
\! echo Disks — The total number of logical blocks of data for the DB cluster volume.
\! echo Nodes — The total number of storage nodes for the DB cluster volume.
\! echo ""
SELECT * FROM aurora_show_volume_status();
