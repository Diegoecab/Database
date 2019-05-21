--dba_part_key_columns_x
col column_name for a20
select * from 
DBA_PART_KEY_COLUMNS where owner='&OWNER' and name='&NAME'
order by 1,2;