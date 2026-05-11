-- ------------------------------------------------------------------------------
-- File       : unified_audit_policies_examples.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: unified audit policies examples.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @unified_audit_policies_examples.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
Below is a sample policy that you can use to audit DMLs for users with the DBA role:

--1_ Creating the policy to audit DMLs:
CREATE AUDIT POLICY DMLS_DBA ACTIONS DELETE, UPDATE, INSERT;
--2_ Enabling Unified Audit policy to a specific role [1]:
AUDIT POLICY DMLS_DBA BY USERS WITH GRANTED ROLES DBA;

With this policy, every DML operation performed by a user with the DBA role will be audited. You can verify the audit records by executing the following SQL query on the unified audit trail view:

select unified_audit_policies,event_timestamp, dbusername, action_name,
object_schema, object_name,role, target_user, sql_text
from unified_audit_trail where unified_audit_policies='DMLS_DBA';


