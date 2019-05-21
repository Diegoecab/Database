--dba_fga_audit_trail
col sql_text for a30
col object_name for a25
col policy_name for a25
select DB_USER, timestamp, SQL_TEXT from dba_fga_audit_trail;

--select DB_USER, timestamp, SQL_TEXT, object_name,policy_name from dba_fga_audit_trail where object_schema='RRHH_DW'