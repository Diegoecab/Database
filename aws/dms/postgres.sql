--Verify tables
SELECT current_database();
SELECT                    
    table_schema || '.' || table_name
FROM
    information_schema.tables
WHERE
    table_type = 'BASE TABLE'
AND
    table_schema NOT IN ('pg_catalog', 'information_schema');

--Character set
SHOW SERVER_ENCODING;
SELECT datname ,pg_encoding_to_char(encoding) FROM pg_database;
--PG Settings
select name, setting, unit from pg_settings where name like '%repl%';
