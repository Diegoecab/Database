set pages 1000
set verify off
set lines 900
set feedback off
set trims on
col owner for a20
col index_name for a30



select owner,index_name,tablespace_name,degree from dba_indexes where owner like upper('%&owner%') and upper(table_name) like (upper('%&TABLE%')) order by 1,2;