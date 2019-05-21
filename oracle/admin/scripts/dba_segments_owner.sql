set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col segment_type heading "Segment|Type" for a20
col segment_name heading "Segment|Name" for a40
col tablespace_name heading "Tablespace|Name" for a20

accept OWNER prompt 'Ingrese Owner: '
ttitle ' Tamaño total de esquema &OWNER'

Break on segment_name on report 
compute sum of mb on report 

select segment_type,segment_name,tablespace_name,bytes/1024/1024 MB from dba_Segments where owner=upper('&OWNER') order by 4,1,2,3;

clear break
ttitle off