-- ------------------------------------------------------------------------------
-- File       : pg_repack.sql
-- Purpose    : postgres performance/tuning helper: pg repack.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_repack.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
create extension pg_repack;
pg_repack -h aupg138-instance-1.cdus3jhjlk3a.us-east-1.rds.amazonaws.com -U postgres -k postgres
