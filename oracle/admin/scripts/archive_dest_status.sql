--v$archive_dest_status.sql
set lines 400
col dest_name for a30
col destination for a30
select * from
v$archive_dest_status
order by 1
/