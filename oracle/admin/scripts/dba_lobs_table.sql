col tablespace_name for a20
col column_name for a20
set linesize 180
accept TABLE_NAME prompt 'Ingrese nombre de tabla: '
select a.owner,column_name,a.segment_name,index_name,b.tablespace_name,bytes/1024/1024 MB from dba_lobs a
inner join dba_segments b on b.segment_name=a.segment_name
 where table_name='&TABLE_NAME'
/
