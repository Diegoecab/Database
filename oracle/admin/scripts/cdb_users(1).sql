--cdb_users
prompt All Users within CDB
set lines 900
col external_name for a30
col FAULT_COLLATION for a20
col username for a40
col password for a20
set pages 100
select USERNAME                ,USER_ID, PASSWORD             ,ACCOUNT_STATUS  , LOCK_DATE,EXPIRY_DATE,DEFAULT_TABLESPACE  from cdb_users;