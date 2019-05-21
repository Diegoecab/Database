set verify off
accept usuario prompt 'Ingrese usuario:  '
col owner for a10
col grantee for a20
col grantor for a10
col privilege for a20
set linesize 130
select owner,table_name,grantor,privilege,grantable,hierarchy from dba_tab_privs where GRANTEE=upper('&USUARIO') order by 1,2,3;