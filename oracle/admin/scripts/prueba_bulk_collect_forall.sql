--prueba_bulk_collect_forall.sql
--Utlizar un LIMIT adecuado para cada fetch, utilizar uno extremadamente grande puede generar problemas de memoria sobre el server. 
host del c:\prueba_bulk_collect_forall.log
DROP TABLE PRUEBA1 PURGE;
DROP TABLE PRUEBA2 PURGE;
DROP TABLE PRUEBA3 PURGE;
spool c:\prueba_bulk_collect_forall.log

prompt PRUEBA 1. Insert INTO SELECT

prompt Creo tablas de prueba. 
prompt tabla PRUEBA1 con 20000000 de registros
CREATE TABLE prueba1 TABLESPACE DATA AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 20000000;
prompt tabla PRUEBA2 con 15000000 de registros
CREATE TABLE prueba2 TABLESPACE DATA AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 15000000;
prompt tabla PRUEBA3 vacia
CREATE TABLE prueba3 (ID  NUMBER(10),
                com  VARCHAR2(12),
                fecha  DATE) TABLESPACE DATA;

SET timing on

prompt FLUSH SHARED_POOL y BUFFER_CACHE
alter system flush buffer_cache;
alter system flush shared_pool;

prompt INSERT 1. insertando en tabla prueba3

INSERT INTO prueba3
   SELECT ID, com, fecha
     FROM prueba1
   UNION ALL
   SELECT ID, com, fecha
     FROM prueba2;
COMMIT ;

prompt REGISTROS EN PRUEBA3
select count(*) from prueba3;

prompt TAM PRUEBA3
select sum(bytes)/1024/1024 MB
from
dba_Segments
where
upper(segment_name)=upper('PRUEBA3');



prompt TRUNCATE TABLE PRUEBA3
TRUNCATE TABLE PRUEBA3;

prompt FLUSH SHARED_POOL y BUFFER_CACHE
alter system flush buffer_cache;
alter system flush shared_pool;

prompt PRUEBA 2. BULK COLLECT + FORALL

DECLARE
   TYPE tty_rowid IS TABLE OF UROWID
      INDEX BY BINARY_INTEGER;

   TYPE tty_id IS TABLE OF prueba3.id%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tty_com IS TABLE OF prueba3.com%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tty_fecha IS TABLE OF prueba3.fecha%TYPE
      INDEX BY BINARY_INTEGER;

   tab_rowid   tty_rowid;
   tab_id      tty_id;
   tab_com     tty_com;
   tab_fecha   tty_fecha;
   i           NUMBER    := 0;

   CURSOR cur_prueba
   IS
      SELECT rowid,ID, com, fecha
        FROM prueba1
		union all
      SELECT rowid,ID, com, fecha
        FROM prueba2;
BEGIN
   OPEN cur_prueba;

   LOOP
      FETCH cur_prueba
      BULK COLLECT INTO tab_rowid, tab_id, tab_com, tab_fecha LIMIT 100;

      EXIT WHEN tab_rowid.COUNT = 0;
      FORALL i IN 1 .. tab_rowid.COUNT
         INSERT INTO prueba3
              VALUES (tab_id (i), tab_com (i), tab_fecha (i));
      COMMIT;
   END LOOP;

   CLOSE cur_prueba;
  
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
END;
/

prompt REGISTROS EN PRUEBA3
select count(*) from prueba3;

prompt TAM PRUEBA3
select sum(bytes)/1024/1024 MB
from
dba_Segments
where
upper(segment_name)=upper('PRUEBA3');

spool off