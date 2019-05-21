SELECT table_name,
       index_name,
       used,
       start_monitoring,
       end_monitoring
FROM   v$object_usage;