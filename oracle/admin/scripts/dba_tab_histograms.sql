--dba_tab_histograms
col column_name for a30
col endpoint_actual_value for a50
set feed off
set head on

select * from dba_tab_histograms
where owner like upper ('%&owner%')
and table_name like upper ('%&table_name%')
and column_name like upper ('%&column_name%')
order by 1,2,3,5
/