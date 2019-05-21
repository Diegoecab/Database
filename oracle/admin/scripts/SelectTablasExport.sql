select decode( rownum, 1, 'tables=(', ',' ), table_name
  from user_tables
union all
select ')', null
  from dual ;
