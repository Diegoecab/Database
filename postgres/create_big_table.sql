drop table articles3;
create table articles3 (code int primary key, article varchar, name varchar, department varchar);

set work_mem=3145728;

insert into articles3 (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(1, 100000000) s(i);

insert into articles3 (
    code, article, name, department
)
select
    (i),
    random()::text,
    random()::text,
    left((random()::text), 4)
from generate_series(100000001, 1000000000) s(i);

insert into articles3 (
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
FROM articles3
ORDER BY 1;
