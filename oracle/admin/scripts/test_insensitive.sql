--c:\temp\test_insensitive.sql
drop table test purge;
set autotrace off


set timing on
set serveroutput on

create table test (string varchar2(100));

insert into test (string) values ('Pepe');

insert into test (string) values ('PEPE');

insert into test (string) values ('pepe');

commit;

set autotrace on

select * from test where string='pepe';
select * from test where string like '%pepe%';

create index string_idx on test (string);

alter system flush buffer_cache;

select * from test where string = 'pepe';
select * from test where string like '%pepe%';

alter session set NLS_SORT=BINARY_CI;
alter session set NLS_COMP=LINGUISTIC;

alter system flush buffer_cache;


select * from test where string='pepe';
select * from test where string like '%pepe%';


prompt inserto 300000 filas

begin
for r in 1 .. 100000 loop
insert into test (string) values ('pepe');
insert into test (string) values ('Pepe');
insert into test (string) values ('PEPE');
end loop;
end;
/

commit;

set autotrace traceonly;

prompt performance
prompt select count(*) from test where string='pepe';

select count(*) from test where string='pepe';

prompt select count(*) from test where string like '%pepe%';

select count(*) from test where string like '%pepe%';


create index string_idx2 on test (nlssort( string, 'NLS_SORT=BINARY_CI' ));

prompt performance with nls_sort=binary_ci index

alter system flush buffer_cache;

prompt select count(*) from test where string='pepe';

select count(*) from test where string='pepe';

prompt select count(*) from test where string like '%pepe%';

select count(*) from test where string like '%pepe%';



