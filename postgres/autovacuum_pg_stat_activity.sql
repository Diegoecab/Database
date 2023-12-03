select count(*) from pg_stat_activity where query like 'autovacuum:%';

SELECT datname, usename, pid, -- waiting, 
current_timestamp - xact_start
AS xact_runtime, query
FROM pg_stat_activity WHERE upper(query) like '%VACUUM%' ORDER BY xact_start;
