col account_status for a20
col username for a20
col password for a20
col account_status for a16
col default_tablespace for a20
col profile for a25
set linesize 180
set pagesize 1000
set verify off
undefine all

select user_id,username,password,account_status,lock_date,expiry_date,default_tablespace,created,profile from dba_users
where username like upper('%&username%')
 order by 1;
PROMPT
PROMPT Para ver la password en oracle 11g, consultar sys.user$
PROMPT select  password from sys.user$ where name=''
PROMPT