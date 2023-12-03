--Before looking into how to remove bloat, let’s first discuss how you can identify bloated tables in a PostgreSQL database. The view pg_stat_user_tables in PostgreSQL provides statistic information about accesses (number of rows inserted, deleted, and updated, and estimated number of dead tuples) to a particular table. You can use the following SQL query to check the number of dead tuples and when the last autovacuum or vacuum ran on the tables:

SELECT relname AS TableName, n_live_tup AS LiveTuples, n_dead_tup AS DeadTuples, n_tup_del, n_tup_upd, last_autovacuum AS Autovacuum, last_vacuum AS ManualVacuum, now() FROM pg_stat_user_tables;

--The simplest way of reusing the storage space occupied by dead tuples is the PostgreSQL VACUUM operation.
--You can run two variants of VACUUM to get rid of dead tuples in PostgreSQL: standard VACUUM and VACUUM FULL.

--VACUUM FULL <Table Name> – Performs the VACUUM FULL operation on a particular table.
--VACUUM FULL – Runs VACUUM FULL on all the tables within a database. It is not recommend for a user to run Vacuum Full without providing table name, as it can compact system catalogs.
--In production databases, you don’t want to use the VACUUM FULL operation because it blocks other activities in the database. Another alternative when you want the storage reclaimed rather than just be available for reuse is using the pg_repack extension.
--It lets you remove bloat from tables as well as from indexes. You can choose to run pg_repack in a time of less load on the database.


--
--The following SQL query examines each table in the XML schema and identifies dead rows (tuples) that waste disk space:
SELECT schemaname || '.' || relname as tuplename,
    n_dead_tup,
    (n_dead_tup::float / n_live_tup::float) * 100 as pfrag
FROM pg_stat_user_tables
WHERE schemaname = 'xml' and n_dead_tup > 0 and n_live_tup > 0 order by pfrag desc;
