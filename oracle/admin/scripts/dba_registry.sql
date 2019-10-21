col comp_name for a40
col comp_id for a10
set lines 900
select comp_id, comp_name, version, status from dba_registry;