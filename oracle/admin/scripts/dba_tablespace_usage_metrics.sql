--dba_tablespace_usage_metrics.SQL
SELECT t.tablespace_name, t.contents, ROUND(m.used_percent, 2) as pct_used, ROUND((m.tablespace_size - m.used_space)*t.block_size/1024/1024, 3) mb_free, bigfile
FROM dba_tablespace_usage_metrics m,
dba_tablespaces t,
v$parameter p
WHERE p.name='statistics_level' and p.value!='BASIC'
AND t.tablespace_name = m.tablespace_name(+);