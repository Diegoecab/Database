set pages 1000
set lines 132
set trims on
set verify off
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
accept OWNER prompt 'Ingrese Esquema: '
ttitle 'Objetos del esquema &OWNER'
select object_type,object_name,created,status from 
dba_objects where owner=upper('&OWNER');