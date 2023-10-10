--dba_sql_profiles
set linesize 180
col sql_text for a50
col description for a5
col category for a7
col name for a40
set long 2000
col signature for 999999999999999999999999
accept days prompt 'Enter value for days: '

select name, created, signature from dba_sql_profiles where 
(created > trunc(sysdate - &days) or last_modified > trunc(sysdate - &days));