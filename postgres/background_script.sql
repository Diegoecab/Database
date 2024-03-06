SET lock_timeout=7200000;
--Find lock on a specific table.
SELECT
    pid,
    state,
    usename,
    query,
    usename,
    query,
    query_start,
    age(now(), query_start) AS "age"
FROM
    pg_stat_activity
WHERE
    pid IN (
        SELECT
            pid
        FROM
            pg_locks l
            JOIN pg_class t ON l.relation = t.oid
                AND t.relkind = 'r'
        WHERE
            t.relname = 'entitlement_modification'
            AND pid <> pg_backend_pid());
