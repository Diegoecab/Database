-- ------------------------------------------------------------------------------
-- File       : test_insensitive.sql
-- Purpose    : Oracle administration helper: test insensitive.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @test_insensitive.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
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



