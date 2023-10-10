--You can run the following query to list all connections in idle in transaction state and to order them by duration:


SELECT now() - state_change as idle_in_transaction_duration, now() - xact_start as xact_duration,* 
FROM  pg_stat_activity 
WHERE state  = 'idle in transaction'
AND   xact_start is not null
ORDER BY 1 DESC;
