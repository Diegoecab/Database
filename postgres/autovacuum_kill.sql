select pg_terminate_backend(pid) from pg_stat_activity where query = 'autovacuum: VACUUM rkms.transaction (to prevent wraparound)' and pid <> pg_backend_pid();
\watch 1
