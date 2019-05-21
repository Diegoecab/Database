create tablespace dbas_marron datafile size 1000m autoextend on next 100M maxsize 10000M;
alter user dba_dc22057	 quota unlimited on dbas_marron;
CREATE TABLE test (id number, name varchar2(1000))  tablespace dbas_marron;

set timing on
insert into test select level id, 'nom_'||level nombre
FROM dual
CONNECT BY level <= 300000;

begin
for r in 1..2000 loop
insert into test select level id, 'nom_'||level nombre
FROM dual
CONNECT BY level <= 500000;
end loop;
end;
/