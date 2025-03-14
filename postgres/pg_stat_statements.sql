\d pg_stat_statements
SELECT
  (total_exec_time / 1000 / 60) as total_min,
  mean_exec_time as avg_ms,
  calls,
  rows,
  substr(query,1,50) query
FROM pg_stat_statements
ORDER BY 1 DESC
LIMIT 500;

