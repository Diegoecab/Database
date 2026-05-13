-- ------------------------------------------------------------------------------
-- File       : lob_columns.sql
-- Purpose    : postgres storage helper: lob columns.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: lob_columns.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
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
