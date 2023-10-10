SHOW SERVER_ENCODING;
SELECT datname ,pg_encoding_to_char(encoding) FROM pg_database;
