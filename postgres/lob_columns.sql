select t.table_schema as schema_name,
t.table_name,
count(*) as columns
from information_schema.columns c
inner join INFORMATION_SCHEMA.tables t
on c.TABLE_SCHEMA = t.TABLE_SCHEMA
and c.TABLE_NAME = t.TABLE_NAME
where t.TABLE_TYPE = 'BASE TABLE'
and ((c.data_type in ('VARCHAR', 'NVARCHAR') and c.character_maximum_length = -1)
or data_type in ('TEXT', 'NTEXT', 'IMAGE', 'VARBINARY', 'XML', 'FILESTREAM'))
group by t.table_schema,
t.table_name
order by t.table_schema,
t.table_name;
