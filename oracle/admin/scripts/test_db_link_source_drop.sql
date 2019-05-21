REM    Test db links. Script a ejecutar en una base "fuente" desde donde se tomaran datos. Elimina objetos de prueba
REM ======================================================================
REM test_db_link_source_drop.sql        Version 1.1    07 Julio 2011
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
set verify off

PROMPT
PROMPT Eliminando tabla prueba_dblink
PROMPT
DROP TABLE prueba_dblink PURGE;
PROMPT

PROMPT
PROMPT Eliminando trigger trg_database_logon
PROMPT
DROP TRIGGER trg_database_logon;
PROMPT

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
