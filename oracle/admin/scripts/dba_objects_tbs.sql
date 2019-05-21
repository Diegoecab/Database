set pages 1000
set lines 132
set trims on
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
accept TBS prompt 'Ingrese Tablespace: '
ttitle 'Objetos por usuario en el tablespace &TBS'
select object_type,object_name,created,status from 
dba_objects where tablespace_name=upper('&TBS');