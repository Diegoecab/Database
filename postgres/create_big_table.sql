create table articles3 (code int primary key, article varchar, name varchar, department varchar);

insert into articles3 (
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
