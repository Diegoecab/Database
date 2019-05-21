set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
ttitle ' Tamaño total de la base de datos'
select round(sum(bytes)/1024/1024/1024,1) GB from dba_Segments;
ttitle off
set feedback on
set verify on