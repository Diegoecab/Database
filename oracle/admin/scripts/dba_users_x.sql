set verify off
accept usuario prompt 'Ingrese usuario:  '
col account_status for a20
col username for a15
col password for a20
col account_status for a16
col default_tablespace for a20
col profile for a15
set linesize 150
select username,password,account_status,lock_date,expiry_date,default_tablespace,created,profile from dba_users where username=upper('&usuario');
PROMPT
PROMPT Para ver la password en oracle 11g, consultar sys.user$
PROMPT