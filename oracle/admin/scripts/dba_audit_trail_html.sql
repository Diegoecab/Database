set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col os_username for a20
col userhost for a20
col terminal for a10
col obj_name for a20
col new_name for a20
col comment_text for a20
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON
select * from dba_audit_trail order by timestamp
/
select * from dba_audit_session
/

SET MARKUP HTML OFF