set linesize 180
col account_status forma a16
select username, account_status, profile,created, expiry_date 
from dba_users 
where username like UPPER('&1')
order by 1
/
