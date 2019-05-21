col tablespace_name for a20
col column_name for a20
set linesize 180
accept SEGMENT_NAME prompt 'Ingrese nombre de LOB: '
select a.owner,a.table_name, column_name,a.segment_name,index_name,b.tablespace_name,bytes/1024/1024 MB from dba_lobs a
inner join dba_segments b on b.segment_name=a.segment_name
 where a.segment_name='&SEGMENT_NAME'
/
