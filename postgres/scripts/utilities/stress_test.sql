-- ------------------------------------------------------------------------------
-- File       : stress_test.sql
-- Purpose    : postgres utilities helper: stress test.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: stress_test.sql
-- Parameters : Review script body before running.
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
pgbench -i postgres --host hostname
pgbench --host rds-pg-labs.cdus3jhjlk3a.us-east-1.rds.amazonaws.com --username=masteruser --protocol=prepared -P 30 --time=300 --client=200 --jobs=200 postgres
