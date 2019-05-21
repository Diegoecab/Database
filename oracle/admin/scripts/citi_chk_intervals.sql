--citi_chk_intervals.sql
prompt  tables that exist in dbadmin.dbs_tab_part but not (or interval is different) in dba_part_tables
select ownname, tabname, interval from dbadmin.dbs_tab_part a where interval is not null and not exists (
select 1 from dba_part_tables b where b.owner=a.ownname
and b.table_name=a.tabname and b.interval = a.interval)
/

prompt  tables that exist in dba_part_tables but not (or interval is different) in dbadmin.dbs_tab_part
select owner, table_name, interval from dba_part_tables b where interval is not null and not exists (
select 1 from  dbadmin.dbs_tab_part a where b.owner=a.ownname
and b.table_name=a.tabname and b.interval = a.interval)
/