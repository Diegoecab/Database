--dba_part_key_columns
col column_name for a20
set lines 300
set pages 1000
set verify off
undefine all

select a.*,b.data_type from 
dba_part_key_columns a, dba_tab_columns b
where b.owner=a.owner and b.table_name=a.name and b.column_name=a.column_name 
and a.owner like upper('%&owner%')
and a.name like upper('%&name%')
and a.object_type like upper('%&object_type%')
and a.column_name like upper('%&column_name%')
and b.data_type like upper('%&data_type%')
order by 1,2
/