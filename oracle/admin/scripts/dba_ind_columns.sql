--dba_ind_columns

set pages 100
set lines 200
col index_owner for a30 truncate
col index_name for a40 truncate
col column_name for a30 truncate
col table_name for a30 truncate
col table_owner for a30 truncate

select table_owner,table_name,index_owner,index_name,column_name,column_position
from dba_ind_columns 
where table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and index_name like upper('%&index_name%')
and column_name like upper('%&column_name%')
order by 1,2,3,4,6
/
