--Active sessions
select pid as process_id,
       usename as username,
       datname as database_name,
       client_addr as client_address,
       application_name,
       backend_start,
       state,
       state_change,
       wait_event,
       wait_event_type,
       left(query, 100)
     --  query
from pg_stat_activity where state='active' order by state_change;


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


-- Top wait events
SELECT state, wait_event, wait_event_type, COUNT(*)
FROM pg_stat_activity
GROUP BY 1, 2, 3
ORDER BY COUNT(*)
;
