select backend_type, state_change from pg_stat_activity where backend_type = 'autovacuum worker';
