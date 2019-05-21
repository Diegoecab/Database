--grant_all_readonly.sql

set serveroutput on
begin
for r in 
(
select owner,object_name from dba_objects where owner = upper('%&owner%') and object_type in ('TABLE','VIEW','MATERIALIZED VIEW')
)
loop
begin
execute immediate ('grant select on '||r.owner||'.'||r.object_name||' to &grantee');
exception when others then
dbms_output.put_line ('Error on '||r.owner||'.'||r.object_name);
dbms_output.put_line (sqlerrm);
end;
end loop;
end;
/