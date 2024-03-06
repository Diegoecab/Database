create table customer1( id int, name varchar, emailid varchar, projectname varchar, contactnumber bigint);

insert into customer1 values(1,'Tom','tom@customer1.com','Customer1.migration',328909432);
insert into customer1 values(2,'Harry','harry@customer1.com','Customer1.etl',2328909432);
insert into customer1 values(3,'Jeff','jeff@customer1.com','Customer1.infra',328909432);

create server my_fdw_target Foreign Data Wrapper postgres_fdw OPTIONS (DBNAME 'postgres', HOST 'dbtestencod.cluster-cdus3jhjlk3a.us-east-1.rds.amazonaws.com', SSLMODE 'require');
CREATE USER MAPPING FOR postgres SERVER my_fdw_target OPTIONS (user 'postgres', password 'postgres');


create foreign table customer1_fdw( id int, name varchar,
emailid varchar, projectname varchar, contactnumber bigint) server
my_fdw_target OPTIONS( TABLE_NAME 'customer1');


select * from customer1_fdw;


CREATE OR REPLACE FUNCTION myfnc() RETURNS INTEGER AS
$$
DECLARE
	ret_id INTEGER;
BEGIN
    INSERT INTO customer1_fdw values(3,'Jeff','jeff@customer1.com','Customer1.infra',328909432);
	select count(*) into ret_id from customer1;
	RETURN ret_id;
END
$$
  LANGUAGE 'plpgsql';
  
exec myfnc


DO $$
declare ret_id integer;
BEGIN
select myfnc() INTO ret_id;   
RAISE NOTICE 'ret_id = %', ret_id;
END$$;



CREATE OR REPLACE FUNCTION myfnc() RETURNS INTEGER AS
$$
DECLARE
	ret_id INTEGER;
BEGIN
    INSERT INTO customer1 values(3,'Jeff','jeff@customer1.com','Customer1.infra',328909432);
	select count(*) into ret_id from customer1_fdw;
	RETURN ret_id;
END
$$
  LANGUAGE 'plpgsql';




\timing

insert into customer1 (
    id, name, emailid, projectname, contactnumber
)
select
    (i),
    random()::text,
    random()::text,
	random()::text,
    (i)
from generate_series(1, 1000000) s(i);
