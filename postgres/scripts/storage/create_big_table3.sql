-- ------------------------------------------------------------------------------
-- File       : create_big_table3.sql
-- Purpose    : postgres storage helper: create big table3.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: create_big_table3.sql
-- Parameters : text
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
drop table articles2;
create table articles2 (code int primary key, article varchar, name varchar, department varchar);

set work_mem=3145728;

insert into articles2 (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(1, 100000000) s(i);

insert into articles2 (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(100000001, 1000000000) s(i);

insert into articles2 (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(1000000001, 10000000000) s(i);


EXPLAIN 
SELECT * 
FROM articles2
ORDER BY 1;
