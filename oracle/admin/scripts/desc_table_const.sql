REM	Script para obtener tablas padres e hijas de una table en particular
REM ======================================================================
REM desc_table_const.sql		Version 1.1	1 mayo 2011
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
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

set pages 1000
set lines 132
set trims on
set verify off
set feedback off

accept TOWNER prompt 'Owner: '
accept TTABLE prompt 'Tabla: '
prompt

ttitle 'lista de tablas a las que hace referencia la tabla "&towner"."&ttable"'


/* Este script me da una lista de tablas a las que hace referencia una tabla en particular*/
SELECT DISTINCT B.OWNER,B.TABLE_NAME FROM ALL_CONSTRAINTS A ,ALL_CONSTRAINTS B 
WHERE A.TABLE_NAME = upper ('&TABLE') and b.OWNER = upper ('&OWNER') AND A.CONSTRAINT_TYPE ='R'
AND A.R_CONSTRAINT_NAME=B.CONSTRAINT_NAME
/

/* Este script busca las tablas hijas de una tabla en particular*/
ttitle 'tablas hijas de la tabla "&towner"."&ttable"'

SELECT OWNER,TABLE_NAME, CONSTRAINT_NAME
  FROM ALL_CONSTRAINTS
 WHERE CONSTRAINT_TYPE = 'R'
   AND R_CONSTRAINT_NAME IN (
                  SELECT CONSTRAINT_NAME
                    FROM ALL_CONSTRAINTS
                   WHERE TABLE_NAME = upper ('&TABLA')
			and owner= upper ('&OWNER')
                         AND CONSTRAINT_TYPE = 'P')
/

ttitle off