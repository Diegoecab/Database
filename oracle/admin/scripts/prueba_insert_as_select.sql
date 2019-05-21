--prueba_insert_as_select.sql

accept TBS prompt 'Ingrese tablespace para las tablas: '

host del c:\prueba_insert_as_select.log
DROP TABLE PRB1 PURGE;
DROP TABLE PRB2 PURGE;
DROP TABLE PRB3 PURGE;
spool c:\prueba_insert_as_select.log

prompt PRUEBA 1. Insert INTO SELECT

prompt Creo tablas de prueba. 
prompt tabla PRB1 con 30000000 de registros
CREATE TABLE PRB1 TABLESPACE &TBS AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 30000000;
prompt tabla PRB2 con 15000000 de registros
CREATE TABLE PRB2 TABLESPACE &TBS AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 15000000;
prompt tabla PRB3 vacia
CREATE TABLE PRB3 (ID  NUMBER(10),
                com  VARCHAR2(12),
                fecha  DATE) TABLESPACE &TBS;

SET timing on

prompt INSERT 1. insertando en tabla PRB3

set autotrace on statistics
INSERT INTO PRB3
   SELECT ID, com, fecha
     FROM PRB1
   UNION ALL
   SELECT ID, com, fecha
     FROM PRB2;
COMMIT ;

set autotrace off
prompt REGISTROS EN PRB3
select count(*) from PRB3;

prompt TAM PRB3
select sum(bytes)/1024/1024 MB
from
dba_Segments
where
upper(segment_name)=upper('PRB3');



prompt DROP TABLES
DROP TABLE PRB1 PURGE; 
DROP TABLE PRB2 PURGE; 
DROP TABLE PRB3 PURGE; 

spool off