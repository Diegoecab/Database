 CREATE TABLE &tablename NOLOGGING PARALLEL 4 AS
 SELECT level id, 'nom_'||level nom
 FROM dual
 CONNECT BY level <= 1000000;

ALTER TABLE &tablename add constraint &tablename_pk PRIMARY KEY (ID);
