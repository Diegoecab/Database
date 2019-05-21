REM    Test db links. Script a ejecutar en una base destino
REM ======================================================================
REM test_db_link_exec.sql        Version 1.1    07 Julio 2011
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
SET verify off
SET feedback off
SET serveroutput on
SET heading off

ALTER SESSION SET nls_date_format='ddmmyyyy-hh24miss';
DEFINE sep = '_';
DEFINE ext = '.log';
DEFINE spoolv = '&_date&sep&_user&sep&_connect_identifier&ext';

SPOOL &spoolv

ALTER SESSION SET nls_date_format='dd/mm/yyyy hh24:mi:ss';



PROMPT
SELECT SYSDATE
  FROM DUAL;

PROMPT
PROMPT Instancia actual
PROMPT


DECLARE
   var   NUMBER;
BEGIN
   FOR i IN (SELECT instance_name, host_name, VERSION
               FROM v$instance)
   LOOP
      BEGIN
         DBMS_OUTPUT.put_line ('Conectado a ');
         DBMS_OUTPUT.put_line ('***************************************');
         DBMS_OUTPUT.put_line ('Instancia:       ' || i.instance_name);
         DBMS_OUTPUT.put_line ('Servidor:        ' || i.host_name);
         DBMS_OUTPUT.put_line ('***************************************');
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('Error de conexión ' || SQLERRM);
      END;
   END LOOP;
END;
/


PROMPT
PROMPT Test de conexion a base remota
PROMPT


DECLARE
   var   NUMBER;
BEGIN
   FOR i IN (SELECT instance_name, host_name, VERSION
               FROM v$instance@prueba_dblink)
   LOOP
      BEGIN
         DBMS_OUTPUT.put_line ('Conectado a ');
         DBMS_OUTPUT.put_line ('***************************************');
         DBMS_OUTPUT.put_line ('Instancia:       ' || i.instance_name);
         DBMS_OUTPUT.put_line ('Servidor:        ' || i.host_name);
         DBMS_OUTPUT.put_line ('***************************************');
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('Error de conexión ' || SQLERRM);
      END;
   END LOOP;
END;
/


PROMPT
PROMPT ===================================================================================================

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
ACCEPT IDENT prompt 'Ingrese identificador para el trace de sesión: '


ALTER SESSION SET tracefile_identifier='&IDENT';
ALTER SESSION SET timed_statistics = TRUE;
ALTER SESSION SET statistics_level=ALL;
ALTER SESSION SET max_dump_file_size = UNLIMITED;
ALTER SESSION SET EVENTS '10046 trace name context forever,level 12';

SET TIMING ON
SET AUTOTRACE ON
SET SERVEROUTPUT ON

PROMPT
PROMPT Ejecutando consultas por dblink
PROMPT

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
   END LOOP;
END;
/

PROMPT
SET autotrace off
SET timing off
ALTER SESSION SET EVENTS '10046 trace name context off';

PROMPT
PROMPT Estadisticas de sesion
PROMPT
SET heading on
@v$sesstat_dblink
SET feedback off
SET heading off
PROMPT
PROMPT Prueba terminada
PROMPT
PROMPT ===================================================================================================
PROMPT
PROMPT Log de ejecucion:        &spoolv
PROMPT
PROMPT ===================================================================================================
PROMPT

BEGIN
   FOR r IN (SELECT    u_dump.VALUE
                    || '/'
                    || lower(INSTANCE.VALUE)
                    || '_ora_'
                    || v$process.spid
                    || NVL2 (v$process.traceid, '_' || v$process.traceid,
                             NULL)
                    || '.trc' tracefile
               FROM v$parameter u_dump CROSS JOIN v$parameter INSTANCE
                    CROSS JOIN v$process
                    JOIN v$session ON v$process.addr = v$session.paddr
              WHERE u_dump.NAME = 'user_dump_dest'
                AND INSTANCE.NAME = 'instance_name'
                AND v$session.audsid = SYS_CONTEXT ('userenv', 'sessionid'))
   LOOP
      DBMS_OUTPUT.put_line ('Archivo trace:           ' || r.tracefile);
   END LOOP;
END;
/

PROMPT
PROMPT ===================================================================================================
SPOOL off