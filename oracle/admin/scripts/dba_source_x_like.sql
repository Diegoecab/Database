set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
--accept OWNER prompt 'Ingrese Nombre de owner: '
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '
accept LIKE prompt 'Like: '

select LINE,TEXT from dba_source where name= upper('&OBJ_NAME') and 
text like '%&LIKE%'
order by line;
--select * from dba_source where owner='&OWNER' and name='&OBJ_NAME';


--sucursales empresa horario recurso fecha especifica por JIRA