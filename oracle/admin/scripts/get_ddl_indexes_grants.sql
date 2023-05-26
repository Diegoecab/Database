col ddl for a9000
set lines 900
set long 90000



ACCEPT owner
ACCEPT table_name

BEGIN
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SEGMENT_ATTRIBUTES', false);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'STORAGE', false);
END;
/

  
select 'Rem Creando indice '||owner||'.'||index_name||' ...'
||dbms_metadata.get_ddl('INDEX',index_name,'&&owner') as ddl from dba_indexes
where owner=upper('&&owner') and upper(table_name)=upper('&&table_name')
/


select 'GRANT '||privilege||' on '||owner||'.'||table_name||' to '|| grantee||';' from dba_tab_privs where owner='&OWNER' and upper(table_name)='&TABLE_NAME' and grantable='NO';
select 'GRANT '||privilege||' on '||owner||'.'||table_name||' to '|| grantee||' with grant option;' from dba_tab_privs where owner='&OWNER' and upper(table_name)='&TABLE_NAME' and grantable='YES';