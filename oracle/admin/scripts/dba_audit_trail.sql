--dba_audit_trail
set pages 1000
set verify off
set lines 800
set feedback off
set trims on
col os_username for a30
col userhost for a30
col terminal for a30
col obj_name for a30
col new_name for a30
col comment_text for a30
col sql_bind for a30
col session_cpu for a30
col sql_text for a50
col extended_timestamp for a30
col sql_text for a100
select action_name,sql_text,os_username,username,sessionid,sessionid,os_process,owner,obj_name,new_owner, new_name,userhost,terminal,timestamp,logoff_time,decode(returncode,'0','Ok','1005','Null',
'1017','Fallo',returncode) pass_fail from dba_audit_trail 
where timestamp > sysdate -&days
and upper(os_username) like upper('%&os_username%')
and upper(username) like upper('%&username%')
and upper(returncode) like upper('%&returncode%')
and upper(action_name) like upper('%&action_name%')
order by timestamp
/