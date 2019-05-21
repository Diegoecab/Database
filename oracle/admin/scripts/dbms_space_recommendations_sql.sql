--@dbms_space_recommendations_sql.sql
prompt
set serveroutput on
set feedback off
set linesize 180
begin
for r in (select  round(allocated_space/1024/1024) allocated_space,round(reclaimable_space/1024/1024) reclaimable_space,--c1,
tablespace_name,segment_owner, segment_name, segment_type
 from
table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE'))
order by 2,4,5)
loop
dbms_output.put_line ('--');
if r.segment_type='TABLE' then
dbms_output.put_line ('PROMPT Tabla '||r.segment_owner||'.'||r.segment_name);
dbms_output.put_line ('ALTER TABLE '||r.segment_owner||'.'||r.segment_name||' enable row movement;');
dbms_output.put_line ('ALTER TABLE '||r.segment_owner||'.'||r.segment_name||' shrink space;');
end if;
if r.segment_type='INDEX' then
dbms_output.put_line ('PROMPT Indice '||r.segment_owner||'.'||r.segment_name);
dbms_output.put_line ('ALTER INDEX '||r.segment_owner||'.'||r.segment_name||' shrink space;');
end if;
end loop;
end;
/
prompt
set feedback on