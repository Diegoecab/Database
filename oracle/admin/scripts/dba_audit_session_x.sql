set pages 1000
set verify off
set lines 400
set feedback off
set trims on
col os_username for a20
col username for a20
col userhost for a20
col terminal for a20
col obj_name for a20
col new_name for a20
col comment_text for a50
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
col pass_fail for a5

select action_name,os_username,username,sessionid,userhost,timestamp,logoff_time,decode(returncode,'0','Ok','1005','Null',
'1017','Fallo',returncode) pass_fail from dba_audit_session
where username like upper('%&usuario%') and timestamp > sysdate - &days
order by timestamp
/