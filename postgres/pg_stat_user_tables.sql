SELECT
schemaname,
relname AS TableName
,n_live_tup AS LiveTuples
,n_dead_tup AS DeadTuples
,last_autovacuum AS Autovacuum
,last_autoanalyze AS Autoanalyze
,autovacuum_count
,vacuum_count
FROM pg_stat_user_tables;

