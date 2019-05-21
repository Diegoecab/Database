set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
--accept OWNER prompt 'Ingrese Nombre de owner: '
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '
accept LINEA1 prompt 'Linea desde: '
accept LINEA2 prompt 'Linea hasta: '

select TEXT from dba_source where name= upper('&OBJ_NAME') and 
line between &LINEA1 and &LINEA2
order by line;
--select * from dba_source where owner='&OWNER' and name='&OBJ_NAME';


--sucursales empresa horario recurso fecha especifica por JIRA