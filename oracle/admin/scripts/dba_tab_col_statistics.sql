--dba_tab_col_statistics
set lines 400

clear col
col owner for a30
col column_name for a30
col data_type for a30
col table_name for a30
col low_value for a30
col high_value for a30

select a.*, b.data_type  from
dba_tab_col_statistics a, dba_tab_columns b
where a.owner like upper ('%&owner%')
and a.table_name like upper ('%&table_name%')
and a.column_name like upper ('%&column_name%')
and b.owner = a.owner and b.table_name = a.table_name and b.column_name = a.column_name and
b.data_type like upper ('%&data_type%')
order by 1,2
/
