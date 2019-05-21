set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
--accept OWNER prompt 'Ingrese Owner de objeto: '
accept TABLE prompt 'Ingrese Nombre de tabla: '

select owner,index_name,tablespace_name,degree from dba_indexes where table_name=upper('&TABLE') order by 1,2;