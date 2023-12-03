SELECT state, wait_event, wait_event_type, COUNT(*)
FROM pg_stat_activity
GROUP BY 1, 2, 3
ORDER BY COUNT(*)
;
