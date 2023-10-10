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
            t.relname = 'table_name'
            AND pid <> pg_backend_pid());

--Find blocked sessions.
SELECT
    concat(client_addr, ':', client_port) AS origin_of_the_statement,
    datname AS database_name,
    usename AS database_user,
    pid,
    usename,
    pg_blocking_pids (pid) AS blocked_by_pid,
    concat(wait_event_type, ':', wait_event) wait_event,
    query AS blocked_statement
FROM
    pg_stat_activity
WHERE
    CARDINALITY(pg_blocking_pids (pid)) > 0
    AND pid <> pg_backend_pid();

SELECT
    activity.pid  AS victim_pid,
    activity.usename,
    activity.query AS victim_query,
    blocking.pid  AS blocker_id,
    blocking.query AS blocker_query
FROM
    pg_stat_activity AS activity
    JOIN pg_stat_activity AS blocking ON blocking.pid  = ANY (pg_blocking_pids (activity.pid ));
