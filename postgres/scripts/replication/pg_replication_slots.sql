-- ------------------------------------------------------------------------------
-- File       : pg_replication_slots.sql
-- Purpose    : postgres replication helper: pg replication slots.
-- Engine     : postgres
-- Category   : replication
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_replication_slots.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--used for cross region read replicas, run at primary
select * from pg_replication_slots;
select * from pg_catalog.pg_replication_slots;
--
--If you want to check the Replication Slot Lag, you can look for the CloudWatch Metric or run the following:(TransactionLogsDiskUsage)
SELECT slot_name, pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(),restart_lsn)) AS replicationSlotLag,
active FROM pg_replication_slots ;
