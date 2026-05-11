-- ------------------------------------------------------------------------------
-- File       : autovacuum_threshold.sql
-- Purpose    : postgres performance/tuning helper: autovacuum threshold.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: autovacuum_threshold.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
/*
To calculate the autovacuum threshold, below formula is used [1],

vacuum threshold = vacuum base threshold + vacuum scale factor * number of live tuples. Use the following values:

Vacuum base threshold – autovacuum_vacuum_threshold
Vacuum scale factor – autovacuum_vacuum_scale_factor
Number of live tuples – The value of n_live_tup from pg_stat_all_tables view
Please note, 'autovacuum_vacuum_scale_factor' specifies a fraction of the table size to add to 'autovacuum_vacuum_threshold' when deciding whether to trigger a VACUUM and 'autovacuum_vacuum_threshold' specifies the minimum number of updated or deleted tuples needed to trigger a VACUUM in any one table. The default is 50 tuples [2]. Hence to check the vacuum threshold, use the above formula by providing the values.

References:
[1] https://aws.amazon.com/blogs/database/understanding-autovacuum-in-amazon-rds-for-postgresql-environments/
[2] https://www.postgresql.org/docs/current/runtime-config-autovacuum.html
*/
