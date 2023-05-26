set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col os_username for a10
col usuario for a25
col userhost for a20
col terminal for a10
col obj_name for a20
col new_name for a20
col comment_text for a20
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
select username usuario,to_char(trunc(timestamp),'DD/MM/YYYY') fecha, count(*) conexiones from dba_audit_session
where timestamp > sysdate-5
and ACTION_NAME='LOGON'
group by username,trunc(timestamp)
order by trunc(timestamp),3
/