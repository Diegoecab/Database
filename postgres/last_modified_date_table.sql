--https://michaelellerbeck.com/2022/09/16/get-last-modified-date-of-table-in-postgresql/
--Turn on track_commit_timestamp in postgresql.conf and restart the DB cluster.
SELECT pg_xact_commit_timestamp(t.xmin) AS modified_ts
FROM   my_table t
ORDER  BY modified_ts DESC NULLS LAST
LIMIT  1;
