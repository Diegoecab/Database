REM    Test db links. Script a ejecutar en una base "fuente" desde donde se tomaran datos
REM ======================================================================
REM test_db_link_source_create.sql        Version 1.1    07 Julio 2011
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM
REM Notas:
REM     Ejecutar con usuario dba
REM
REM Precauciones:
REM
REM ======================================================================
REM
SET feedback off
SET verify off

PROMPT
--Tablespaces
@tbs

PROMPT
ACCEPT TBSDATA prompt 'Tablespace para las tablas: '
ACCEPT TBSINDX prompt 'Tablespace para los indices: '

PROMPT
PROMPT Creando tabla de prueba "PRUEBA_DBLINK" con 1000000 registros
PROMPT

SET timing on
CREATE TABLE prueba_dblink NOLOGGING TABLESPACE &tbsdata AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 1000000;

PROMPT

PROMPT Creando indice para la tabla "PRUEBA_DBLINK", columna ID

CREATE INDEX prb_indx ON prueba_dblink (ID) NOLOGGING TABLESPACE &tbsindx;
PROMPT

set timing off

-- Trigger para ejecutar trace de sesion tambien en base fuente
PROMPT
PROMPT Creando trigger de base de datos para ejecutar trace
PROMPT

CREATE OR REPLACE TRIGGER trg_database_logon
   AFTER LOGON ON DATABASE
BEGIN
   IF SYS_CONTEXT ('USERENV', 'session_user') = 'SYSTEM'
   THEN
      EXECUTE IMMEDIATE ('alter session set tracefile_identifier=dblink_source'
                        );

      EXECUTE IMMEDIATE ('alter session set timed_statistics = true');

      EXECUTE IMMEDIATE ('alter session set statistics_level=all');

      EXECUTE IMMEDIATE ('alter session set max_dump_file_size = unlimited');

      EXECUTE IMMEDIATE ('alter session set events ''10046 trace name context forever,level 12'''
                        );
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
           (-20003,
            'Error al ejecutar trace de sesion en trigger trg_database_logon'
           );
END trg_database_logon;
/

PROMPT
PROMPT Valor actual de db_keep_cache_size
PROMPT

COL name heading 'Parametro' for a50
COL display_value heading 'Valor' for a50
SELECT NAME, display_value
  FROM v$parameter
 WHERE NAME = 'db_keep_cache_size';

PROMPT
PROMPT Se necesitan al menos 80M en keep memory para los objetos creados
PROMPT

ACCEPT CKEEP prompt 'Si desea modificar el valor del parametro ingrese el valor, o ENTER para NO modificar: '

PROMPT

DECLARE
   var   VARCHAR2(1000);
BEGIN
   var := '&CKEEP';

   IF var IS NOT NULL
   THEN
      BEGIN
         EXECUTE IMMEDIATE ('ALTER SYSTEM SET DB_KEEP_CACHE_SIZE= ' || var ||'M ');

         DBMS_OUTPUT.put_line ('Parametro modificado');
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('Error al modificar parametro:' || SQLERRM);
      END;
   END IF;
END;
/

PROMPT
PROMPT Valor de db_keep_cache_size
PROMPT
COL name heading 'Parametro' for a50
COL display_value heading 'Valor' for a50
SELECT NAME, display_value
  FROM v$parameter
 WHERE NAME = 'db_keep_cache_size';

 DEFINE EFLUSH = 'N';

PROMPT
ACCEPT EFLUSH prompt 'Desea ejecutar FLUSH del buffer cache y shared_pool? Y/N [Y]: '
PROMPT

DECLARE
   var   VARCHAR2 (1);
BEGIN
   var := '&EFLUSH';

   IF (var = 'Y' OR var = 'y')
   THEN
      BEGIN
         EXECUTE IMMEDIATE ('ALTER SYSTEM FLUSH BUFFER_CACHE');

         EXECUTE IMMEDIATE ('ALTER SYSTEM FLUSH SHARED_POOL');

         DBMS_OUTPUT.put_line ('Se ejecuto flush de memoria');
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('Error el flush de memoria:' || SQLERRM);
      END;
   END IF;
END;
/

PROMPT

PROMPT 
PROMPT Levantando TABLA PRUEBA_DBLINK y su indice a memoria
PROMPT

ALTER TABLE PRUEBA_DBLINK STORAGE (BUFFER_POOL keep);
ALTER INDEX PRB_INDX STORAGE (BUFFER_POOL keep);

PROMPT
PROMPT Cantidad de registros en la tabla creada:
PROMPT
set autotrace on
select /*+ FULL (PRUEBA_DBLINK) */ count(*) from PRUEBA_DBLINK ;
set autotrace off
PROMPT
PROMPT Ejecutando consultas random por ID
PROMPT
SET TIMING ON
SET SERVEROUTPUT ON

DECLARE
   vardb   NUMBER;
   nid     NUMBER;
BEGIN
   FOR i IN 1 .. 100000
   LOOP
      nid := ROUND (DBMS_RANDOM.VALUE (1, 999999));

--dbms_output.put_line (nid);
      SELECT ID
        INTO vardb
        FROM prueba_dblink
       WHERE ID = nid;
   END LOOP;
END;
/

PROMPT 
PROMPT Blocks in buffer
SET timing off
@blocks_inbuffer_keep
PROMPT
PROMPT La siguiente consulta no debe realizar ninguna lectura fisica
PROMPT
SET autotrace on
SELECT /*+ FULL (PRUEBA_DBLINK) */
       COUNT (*)
  FROM prueba_dblink;
SET autotrace off
PROMPT