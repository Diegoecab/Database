SELECT VERSION FROM V$TIMEZONE_FILE;

--This select gives all TimeStamp with Time Zone (TSTZ) columns in your database:
select c.owner || '.' || c.table_name || '(' || c.column_name || ') -'|| c.data_type || ' ' col
from dba_tab_cols c, dba_objects o 
where c.data_type like '%WITH TIME ZONE'
and c.owner=o.owner
and c.table_name = o.object_name
and o.object_type = 'TABLE'
order by col;
