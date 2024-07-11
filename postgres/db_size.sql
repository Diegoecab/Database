SELECT pg_size_pretty( pg_database_size('testdb2'));
SELECT pg_size_pretty(pg_database_size(pg_database.datname)) AS size_in_mb,
pg_database.datname as database_name
FROM pg_database ORDER BY pg_database_size(pg_database.datname) DESC;
