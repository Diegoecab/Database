REM    Test db links. Script a ejecutar en una base "destino" desde donde se accedera por dblink a otra base
REM ======================================================================
REM test_db_link_target_create.sql        Version 1.1    07 Julio 2011
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
SET serveroutput on
SET heading off
SET feedback off
SELECT SYSDATE FROM DUAL;
PROMPT
ACCEPT BASE prompt 'Base a la que se conectara el dblink (se puede ingresar descripcion): '
PROMPT
ACCEPT PASSW prompt 'Contraseña usuario SYSTEM: '

PROMPT
PROMPT Creando dblink "PRUEBA_DBLINK"
PROMPT

DECLARE
vPASSW VARCHAR2(100);
vBASE VARCHAR2(100);
BEGIN
vPASSW := '&PASSW' ;
vBASE := '&BASE' ;
execute immediate ('CREATE DATABASE LINK PRUEBA_DBLINK connect to system identified by '||vPASSW||' using '''||vBASE||'''');
dbms_output.put_line ('Dblink Creado');
EXCEPTION WHEN OTHERS THEN
dbms_output.put_line ('Error al crear dblink '||SQLERRM);
END;
/

PROMPT 
PROMPT Test de conexión
PROMPT
DECLARE
var number;
BEGIN
FOR I in (select instance_name,host_name,version from v$instance@PRUEBA_DBLINK)
LOOP
BEGIN
dbms_output.put_line ('Conectado a ');
dbms_output.put_line ('***************************************');
dbms_output.put_line ('Instancia: 	        '||i.instance_name);
dbms_output.put_line ('Servidor:		'||i.host_name);
dbms_output.put_line ('***************************************');
EXCEPTION WHEN OTHERS THEN
dbms_output.put_line ('Error de conexión '||SQLERRM);
END;
END LOOP;
END;
/

PROMPT
SELECT SYSDATE FROM DUAL;
PROMPT
SET heading on
SET feedback on