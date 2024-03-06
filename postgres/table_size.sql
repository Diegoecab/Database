-- Tables Size Using pg_relation_size
select pg_size_pretty(pg_relation_size('pgbench_accounts'));

-- How to Get the Total Size of a Table Including Indexes/Additional Objects?
SELECT pg_size_pretty (pg_total_relation_size ('bike_details'));
--list all the tables of a PostgreSQL database and order them by size
 select
  table_name,
  pg_size_pretty(pg_total_relation_size(quote_ident(table_name))),
  pg_relation_size(quote_ident(table_name))
from information_schema.tables
where table_schema = 'public'
order by 3 desc;
--if you have multiple schemas, you might want to use:
select table_schema, table_name, pg_relation_size('"'||table_schema||'"."'||table_name||'"')
from information_schema.tables
order by 3;


---
select
  pg_relation_size(20306, 'main') as main,
  pg_relation_size(20306, 'fsm') as fsm,
  pg_relation_size(20306, 'vm') as vm,
  pg_relation_size(20306, 'init') as init,
  pg_table_size(20306),
  pg_indexes_size(20306) as indexes,
  pg_total_relation_size(20306) as total;

--From that, you can tell pg_table_size is the sum of all the return values of pg_relation_size. And pg_total_relation_size is the sum of pg_table_size and pg_indexes_size.


