set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
accept Tablespace prompt 'Ingrese Tablespace: '
Break on segment_name on report 
compute sum of mb on report

select OWNER,SEGMENT_TYPE,SEGMENT_NAME,sum(bytes)/1024/1024 MB 
from dba_Segments where 
tablespace_name=upper('&TABLESPACE') 
GROUP BY SEGMENT_TYPE,SEGMENT_NAME,OWNER order by mb,1,2;