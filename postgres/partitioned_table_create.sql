CREATE TABLE city (
  id int4 NOT NULL PRIMARY KEY,
  name varchar(30) NOT NULL,
  state varchar(20),
  population int4
)
PARTITION BY RANGE (id);


CREATE TABLE city_id1 PARTITION OF city
FOR VALUES FROM (MINVALUE) TO (10);

CREATE TABLE city_id2 PARTITION OF city
FOR VALUES FROM (10) TO (20);

CREATE TABLE city_id3 PARTITION OF city
FOR VALUES FROM (20) TO (30);

CREATE TABLE city_id4 PARTITION OF city
FOR VALUES FROM (30) TO (MAXVALUE);



insert into city (id, name) values (1,'Buenos Aires');
insert into city (id, name) values (15,'New York');
insert into city (id, name) values (25,'Sao Paulo');



insert into city (id, name) values (11,'Caracas');





