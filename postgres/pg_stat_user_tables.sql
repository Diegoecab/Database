SELECT
relname AS TableName
,n_live_tup AS LiveTuples
,n_dead_tup AS DeadTuples
,last_autovacuum AS Autovacuum
,last_autoanalyze AS Autoanalyze
FROM pg_stat_user_tables;