col table_owner for a30
col table_name for a30
col partition_name for a30
col subpartition_name for a30
set heading on
set feedback on
set pagesize 90
set lines 400

select table_owner,table_name,inserts,updates,deletes,timestamp,truncated from 
sys.dba_tab_modifications 
where table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
order by 1,2
/

PROMPT
PROMPT Para actualizar datos tablas de un esquema, ejecutar estadisticas con opcion "GATHER STALE"
prompt Refresh tab modifications view: exec dbms_stats.flush_database_monitoring_info;
PROMPT