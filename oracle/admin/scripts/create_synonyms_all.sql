--create_synonyms_all.sql
--Usage. @create_synonyms_all <owner> <grantee>
--
whenever sqlerror exit sql.sqlcode

define owner='&1';
define grantee='&2';

prompt Working with owner &owner and grantee &grantee
alter session set current_schema=&grantee;

set serveroutput on
begin
for r in 
(
select owner,object_name from dba_objects where owner = upper('&owner') and object_type in ('TABLE','VIEW','PACKAGE','PROCEDURE')
)
loop
begin
	dbms_output.put_line ('create synonym '||r.object_name||' for '||r.owner||'.'||r.object_name);
	execute immediate ('create synonym '||r.object_name||' for '||r.owner||'.'||r.object_name);
exception when others then
	dbms_output.put_line ('Error on '||r.owner||'.'||r.object_name);
	dbms_output.put_line (sqlerrm);
end;
end loop;
end;
/