show temp_tablespaces;

SELECT spcname,pg_tablespace_location(oid) FROM pg_tablespace;
