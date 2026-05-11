-- ------------------------------------------------------------------------------
-- File       : grid_notification_rules.sql
-- Purpose    : Oracle administration helper: grid notification rules.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @grid_notification_rules.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--grid_notification_rules.sql

set lines 400
set verify off

clear col
undefine all

col rule_name for a80
col target_name for a30
col owner for a30
col metric_column for a30

select rule_name,owner
from sysman.mgmt_notify_rules
where upper(rule_name) like upper('%&rule_name%')
and owner like upper('%&owner%')
order by 1,2
/

undefine all

accept rule_name prompt Enter value for rule_name: 

select rule_name,owner,target_type,target_name,metric_name,metric_column,want_clears,want_warnings,want_critical_alerts,want_target_up,want_target_down from 
sysman.mgmt_notify_rule_configs 
where upper(rule_name) like upper('%&rule_name%')
and owner like upper('%&owner%')
and upper(target_type) like upper('%&target_type%')
and upper(target_name) like upper('%&target_name%')
and upper(metric_name) like upper('%&metric_name%')
and upper(metric_column) like upper('%&metric_column%')
order by 1,2
/

undefine all
clear col