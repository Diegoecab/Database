--En base fuente

CREATE TABLE PRUEBA_DBLINK NOLOGGING TABLESPACE DATA AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 1000000;

CREATE INDEX PRB_INDX ON PRUEBA_DBLINK (ID) NOLOGGING TABLESPACE DATA;

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;


--llevar db_keep_cache_size al menos a 80 M:

--alter system set db_keep_cache_size=80M;

ALTER TABLE PRUEBA_DBLINK STORAGE (BUFFER_POOL keep);
ALTER INDEX PRB_INDX STORAGE (BUFFER_POOL keep);

set autotrace on
select /*+ FULL (PRUEBA_DBLINK) */ count(*) from PRUEBA_DBLINK ;
set autotrace off

SET TIMING ON
SET AUTOTRACE ON
SET SERVEROUTPUT ON

DECLARE
varDB	NUMBER;
nid	NUMBER;
BEGIN
FOR I in 1 .. 100000
LOOP
nid:=round(dbms_random.value(1, 999999));
--dbms_output.put_line (nid);
SELECT ID into VARDB from PRUEBA_DBLINK WHERE ID=nid;
END LOOP;
END;
/
set autotrace off
set timing off
@blocks_inbuffer_keep
set autotrace on
select /*+ FULL (PRUEBA_DBLINK) */ count(*) from PRUEBA_DBLINK ;
set autotrace off

--Peso de tabla: 34 Mb. Indice: 18Mb

**************************************************************************************

--En base destino

CREATE DATABASE LINK PRUEBA_DBLINK connect to system identified by systemp2a using '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP) (HOST=oradbp2a.garba.com.ar)(PORT=1703))) (CONNECT_DATA=(SERVICE_NAME=GARTROP.garba.com.ar)))';

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

alter session set tracefile_identifier=select_dblink_a_intdwde;
alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set events '10046 trace name context forever,level 12';

SET TIMING ON
SET AUTOTRACE ON
SET SERVEROUTPUT ON

DECLARE
   vardb    NUMBER;
   vardb2   NUMBER;
   disval   NUMBER;
   nid      NUMBER;
BEGIN
   --disval := 1; --En 1 para tomar en cuenta el primer select
   FOR i IN 1 .. 100000
   LOOP
      nid := ROUND (DBMS_RANDOM.VALUE (1, 999999));
	  
      SELECT ID
        INTO vardb
        FROM prueba_dblink@prueba_dblink
       WHERE ID = nid;
/*
      IF i > 1
      THEN
         IF vardb2 <> vardb
         THEN
            disval := disval + 1;
         END IF;
      END IF;

      vardb2 := vardb;
   END LOOP;
   
   DBMS_OUTPUT.put_line ('Cantidad de selects distintos (respecto a la anterior consulta: ' || disval);
*/
END;
/

set autotrace off
set timing off
alter session set events '10046 trace name context off';
DROP DATABASE LINK PRUEBA_DBLINK;


--Contra INTDWDE (belgrano):
--Desde:
--GARTRDE	(belgrano):	Transcurrido: 00:00:30.64
--GARTROP2A	(pacheco): 	Transcurrido: 00:02:47.12

--Contra GARDWOP (belgrano):
--Desde:
--GARTRDE	(belgrano):	Transcurrido: 00:00:30.04
--GARTROP2A	(pacheco): 	Transcurrido: 00:03:12.39

--Contra GARTROP2A (pacheco):
--GARDWOP	(belgrano):	Transcurrido: 00:03:02.97
--GARDWP	(pacheco):	Transcurrido: 00:00:42.48





