# postgres performance/tuning

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `apg_plan_mgmt.enable.sql` | postgres performance/tuning helper: apg plan mgmt.enable. | `CHANGES` | `-` |
| `au.apg_plan_mgmt.dba_plans.sql` | postgres performance/tuning helper: au.apg plan mgmt.dba plans. | `READ_ONLY` | `-` |
| `autovacuum_eligible_tables.sql` | postgres performance/tuning helper: autovacuum eligible tables. | `READ_ONLY` | `float` |
| `autovacuum_kill.sql` | postgres performance/tuning helper: autovacuum kill. | `DESTRUCTIVE` | `-` |
| `autovacuum_per_table_settings.sql` | postgres performance/tuning helper: autovacuum per table settings. | `CHANGES` | `MI, SS, float8` |
| `autovacuum_progress.sql` | postgres performance/tuning helper: autovacuum progress. | `READ_ONLY` | `-` |
| `autovacuum_queries.sql` | postgres performance/tuning helper: autovacuum queries. | `READ_ONLY` | `-` |
| `autovacuum_settings.sql` | postgres performance/tuning helper: autovacuum settings. | `DESTRUCTIVE` | `-` |
| `autovacuum_test.sql` | postgres performance/tuning helper: autovacuum test. | `CHANGES` | `boolean` |
| `autovacuum_threshold.sql` | postgres performance/tuning helper: autovacuum threshold. | `CHANGES` | `-` |
| `autovacuum_timeout.sql` | postgres performance/tuning helper: autovacuum timeout. | `CHANGES` | `-` |
| `autovacuum_when_it_started.sql` | postgres performance/tuning helper: autovacuum when it started. | `READ_ONLY` | `-` |
| `db_performance.sql` | postgres performance/tuning helper: db performance. | `READ_ONLY` | `-` |
| `detect_bloat.sql` | postgres performance/tuning helper: detect bloat. | `DESTRUCTIVE` | `float` |
| `hash_indexes.sql` | postgres performance/tuning helper: hash indexes. | `READ_ONLY` | `regclass` |
| `index_size.sql` | postgres performance/tuning helper: index size. | `READ_ONLY` | `-` |
| `pg_repack.sql` | postgres performance/tuning helper: pg repack. | `CHANGES` | `-` |
| `pg_stat_all_indexes.sql` | postgres performance/tuning helper: pg stat all indexes. | `READ_ONLY` | `-` |
| `pg_stat_progress_create_index.sql` | postgres performance/tuning helper: pg stat progress create index. | `CHANGES` | `-` |
| `pg_stat_replication.sql` | postgres performance/tuning helper: pg stat replication. | `READ_ONLY` | `-` |
| `pg_stat_statements.sql` | postgres performance/tuning helper: pg stat statements. | `READ_ONLY` | `-` |
| `pg_stat_user_indexes.sql` | postgres performance/tuning helper: pg stat user indexes. | `READ_ONLY` | `-` |
| `pg_stat_user_tables.sql` | postgres performance/tuning helper: pg stat user tables. | `READ_ONLY` | `-` |
| `pg_stats.sql` | postgres performance/tuning helper: pg stats. | `READ_ONLY` | `-` |
| `reindex.sql` | postgres performance/tuning helper: reindex. | `CHANGES` | `-` |
| `tup_modifications_pg_stat_user_tables.sql` | postgres performance/tuning helper: tup modifications pg stat user tables. | `READ_ONLY` | `-` |
| `vacuum_eligible_tables.sql` | postgres performance/tuning helper: vacuum eligible tables. | `CHANGES` | `float` |
| `vacuum_last_vacuumed_tables.sql` | postgres performance/tuning helper: vacuum last vacuumed tables. | `CHANGES` | `-` |
| `vacuum_running_jobs.sql` | postgres performance/tuning helper: vacuum running jobs. | `CHANGES` | `-` |
| `vacuum_table.sql` | postgres performance/tuning helper: vacuum table. | `CHANGES` | `-` |
