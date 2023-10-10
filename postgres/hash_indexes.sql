--Hash indexes were changed in version 10 and must be rebuilt. To locate invalid hash indexes, run the following SQL for each database that contains hash indexes.

SELECT idx.indrelid::regclass AS table_name, 
   idx.indexrelid::regclass AS index_name 
FROM pg_catalog.pg_index idx
   JOIN pg_catalog.pg_class cls ON cls.oid = idx.indexrelid 
   JOIN pg_catalog.pg_am am ON am.oid = cls.relam 
WHERE am.amname = 'hash' 
AND NOT idx.indisvalid;
