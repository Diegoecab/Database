set verify off
col db_link for a20
col host for a20
col owner for a15
col db_link heading "Nombre|DB Link" for a50
col username heading "Usuario" for a20
accept owner prompt 'Ingrese owner:  '
select owner,db_link,username,host from dba_db_links where owner=upper('&OWNER') order by 1;