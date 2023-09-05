-- Tables Size Using pg_relation_size
select pg_size_pretty(pg_relation_size('pgbench_accounts'));

-- How to Get the Total Size of a Table Including Indexes/Additional Objects?
SELECT pg_size_pretty (pg_total_relation_size ('bike_details'));

