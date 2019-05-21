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