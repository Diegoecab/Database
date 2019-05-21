REM	Script para ver esquemas instalados en la base de datos
REM ======================================================================
REM obj_esquemas.sql		Version 1.1	28 Abril 2010
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
col owner for a20
set pagesize 200
select distinct owner,count(*) objetos from dba_objects where owner not in ('SYSTEM','SYS','ORDSYS','SCOTT',
'CTXSYS','ORDPLUGINS','OUTLN','DBSNMP','DMSYS','PUBLIC','XDB','OLAPSYS',
'MDSYS','WMSYS','EXFSYS','TSMSYS','SYSMAN','ORACLE_OCM') group by owner
order by 1;