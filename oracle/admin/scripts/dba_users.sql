col account_status for a20
col username for a20
col password for a20
col account_status for a16
col default_tablespace for a20
col profile for a25
col initial_rsrc_consumer_group for a30 truncate
set linesize 180
set pagesize 1000
set verify off
undefine all

select user_id,username,password,account_status,lock_date,expiry_date,default_tablespace,created,profile,initial_rsrc_consumer_group,TEMPORARY_TABLESPACE--,LOCAL_TEMP_TABLESPACE
from dba_users
where username like upper('%&username%')
 order by 1;
PROMPT
PROMPT Para ver la password en oracle 11g, consultar sys.user$
PROMPT select  password from sys.user$ where name='DDC'
PROMPT

PROMPT Desde 19c en adelante:
PROMPT set long 600
PROMPT set lines 800

PROMPT  with t as ( select (dbms_metadata.get_ddl('USER',username)) ddl from dba_users  where account_status='EXPIRED' ) 
PROMPT select replace(substr(ddl,1,instr(ddl,'DEFAULT')-1),'CREATE','ALTER')||';' from t;
PROMPT