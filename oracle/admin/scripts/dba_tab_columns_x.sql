--dba_tab_columns_x
set pages 1000
set verify off
set lines 300
set feedback off
set trims on
col owner for a20
col column_name for a25
col data_type for a20
col table_name for a30
undefine all

select owner,table_name,column_name,data_type,data_length,nullable,column_id from dba_tab_columns 
where 
owner like UPPER('%&owner%') 
and table_name like upper('%&table_name%') 
and column_name like upper('%&column_name%') 
order by column_id;