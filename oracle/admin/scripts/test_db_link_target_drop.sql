REM    Test db links. Script a ejecutar en una base "destino" para eliminar objetos creados durante la prueba
REM ======================================================================
REM test_db_link_target_drop.sql        Version 1.1    07 Julio 2011
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
set feedback on
set heading off

PROMPT
PROMPT Eliminando dblink "PRUEBA_DBLINK"
PROMPT

DROP DATABASE LINK PRUEBA_DBLINK;

PROMPT