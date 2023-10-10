 CREATE TABLE &tablename NOLOGGING PARALLEL 4 AS
 SELECT level id, 'nom_'||level nom
 FROM dual
 CONNECT BY level <= 2000000;

ALTER TABLE &tablename add constraint &tablename_pk PRIMARY KEY (ID);

begin
for r in (2000001..5000000) loop
	execute immediate ('insert into BIGTABLE_7 values ('||r||',''TEST'',''test'')')
end loop;
end;
/
