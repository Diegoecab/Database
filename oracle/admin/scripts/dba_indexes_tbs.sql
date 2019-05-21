REM
set verify off
set linesize 200
col owner for a20
col index_type for a10
col degree for 9
accept TBS prompt 'Ingrese nombre de tablespace: '
select owner,index_name,index_type,table_name,uniqueness,compression,degree from dba_indexes where tablespace_name=upper('&TBS') order by 1,3,4,5;