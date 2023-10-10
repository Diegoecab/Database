SELECT to_char(s.load_timestamp,'yyyy/mm/dd hh24:mi:ss') ts, 
 decode(v.violation_level,18,'Insecure/Invalid state',20,'Warning',25,'Critical',125,'Agent Unreachable',325,'Metric Error','Unknown') alert_level, 
 t.target_type, t.target_name, v.message--,v.ACTION_MESSAGE
FROM sysman.mgmt_severity s, sysman.mgmt_targets t, sysman.mgmt_annotation a, sysman.mgmt_notification_log l, sysman.mgmt_violations v
WHERE s.target_guid = t.target_guid
and s.target_guid = v.target_guid and s.load_timestamp = v.load_timestamp
AND s.severity_guid = a.source_obj_guid (+)
AND s.severity_guid = l.source_obj_guid (+)
--AND substr(l.message,1,11) = 'E-mail sent'
and v.violation_level in (18,20,25,125,325)
and s.load_timestamp > sysdate-10
and s.message not like '%heartbeat-event%'
and s.message not like '%User SYS logged%'
and t.target_name <> 'EMREPCTA'
ORDER BY 1
/

set lines 400

col message for a60 truncate
col target_name for a40 truncate
col target_type for a20 truncate
col alert_level for a10 truncate
col HOST_NAME for a15 truncate

SELECT --to_char(s.load_timestamp,'yyyy/mm/dd') alert_date, 
min(s.load_timestamp),
max(s.load_timestamp),
t.target_type, t.target_name, 
 decode(v.violation_level,18,'Insecure/Invalid state',20,'Warning',25,'Critical',125,'Agent Unreachable',325,'Metric Error','Unknown') alert_level, 
 --s.message,
 substr( s.message,1,60) message,host_name,
 count(1) total
FROM sysman.mgmt_severity s, sysman.mgmt_targets t, sysman.mgmt_annotation a, sysman.mgmt_notification_log l, sysman.mgmt_violations v
WHERE s.target_guid = t.target_guid
and s.target_guid = v.target_guid and s.load_timestamp = v.load_timestamp
AND s.severity_guid = a.source_obj_guid (+)
AND s.severity_guid = l.source_obj_guid (+)
and s.message not like '%heartbeat-event%'
and s.message not like '%User SYS logged%'
and s.load_timestamp > sysdate-30
and v.violation_level in (18,20,25,125,325)
and v.violation_level = 25
 and t.target_name <> 'EMREPCTA'
group by --to_char(s.load_timestamp,'yyyy/mm/dd'), 
t.target_type, t.target_name, 
 decode(v.violation_level,18,'Insecure/Invalid state',20,'Warning',25,'Critical',125,'Agent Unreachable',325,'Metric Error','Unknown'),
--s.message,
 substr( s.message,1,60),host_name
ORDER BY  count(1) -- max(s.load_timestamp)
/


--group by Target type


SELECT --to_char(s.load_timestamp,'yyyy/mm/dd') alert_date, 
min(s.load_timestamp),
max(s.load_timestamp),
t.target_type, t.target_name, 
 decode(v.violation_level,18,'Insecure/Invalid state',20,'Warning',25,'Critical',125,'Agent Unreachable',325,'Metric Error','Unknown') alert_level, 
 --s.message,
-- substr( s.message,1,60) message,
 count(1) total
FROM sysman.mgmt_severity s, sysman.mgmt_targets t, sysman.mgmt_annotation a, sysman.mgmt_notification_log l, sysman.mgmt_violations v
WHERE s.target_guid = t.target_guid
and s.target_guid = v.target_guid and s.load_timestamp = v.load_timestamp
AND s.severity_guid = a.source_obj_guid (+)
AND s.severity_guid = l.source_obj_guid (+)
and s.message not like '%heartbeat-event%'
and s.message not like '%User SYS logged%'
and s.load_timestamp > sysdate-30
and v.violation_level in (18,20,25,125,325)
and v.violation_level = 25
 and t.target_name <> 'EMREPCTA'
group by --to_char(s.load_timestamp,'yyyy/mm/dd'), 
t.target_type, t.target_name, 
 decode(v.violation_level,18,'Insecure/Invalid state',20,'Warning',25,'Critical',125,'Agent Unreachable',325,'Metric Error','Unknown')--,
--s.message,
 --substr( s.message,1,60)
ORDER BY count(1) -- max(s.load_timestamp)
/


