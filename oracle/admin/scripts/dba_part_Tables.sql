--dba_part_Tables.sql
col interval for a50
set lines 400

select owner, table_name, partitioning_type, subpartitioning_type, partition_count, status,interval from dba_part_Tables
where owner like upper('%&owner%')
and table_name like upper('%&table_name%')
and partitioning_type like upper('%&partitioning_type%')
and subpartitioning_type like upper('%&subpartitioning_type%')
and partition_count like upper('%&partition_count%')
and status like upper('%&status%')
/