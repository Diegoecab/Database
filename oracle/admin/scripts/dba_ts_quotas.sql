--dba_ts_quotas.sql

select * from dba_ts_quotas
where tablespace_name like upper('%&tablespace_name%')
and username like upper('%&username%')
/