set lines 900
col PARAMETER_NAME for a40
col PARAMETER_VALUE for a40
set pages 100
SELECT *
FROM   dba_audit_mgmt_config_params;
