-- ------------------------------------------------------------------------------
-- File       : create_large_table.sql
-- Purpose    : postgres storage helper: create large table.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: create_large_table.sql
-- Parameters : text
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
create table articles (code int primary key, article varchar, name varchar, department varchar);

insert into articles (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(1, 1000000) s(i);


EXPLAIN (analyse, buffers) 
SELECT * 
FROM articles
ORDER BY 1;
