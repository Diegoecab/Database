 CREATE TABLE &tablename NOLOGGING PARALLEL 4 AS
 SELECT level id, 'nom_'||level nom
 FROM dual
 CONNECT BY level <= 2000000;

ALTER TABLE &tablename add constraint &tablename_pk PRIMARY KEY (ID);

begin
for r in 2000001..5000000 loop
insert into BIGTABLE values (r,'TEST');
end loop;
commit;
end;
/

begin
for r in 2000001..3000001 loop
update BIGTABLE set nom='TEST2' where id=r;
end loop;
commit;
end;
/
