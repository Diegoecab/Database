set lines 900
col AUDIT_CONDITION for a30
col POLICY_NAME for a30
col AUDIT_OPTION for a50
col OBJECT_NAME for a30
col OBJECT_SCHEMA for a30
set pages 1000
 select distinct
  policy_name,
  object_schema,
  object_name,
  audit_condition,
  audit_option,
 AUDIT_OPTION_TYPE
  from
  audit_unified_policies where policy_name in (select POLICY_NAME FROM audit_unified_enabled_policies)
 order by policy_name,object_schema;
