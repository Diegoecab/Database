--drop_user_cascade.sql

undefine all

--accept OWNER prompt 'OWNER: '

set serveroutput on
begin
for r in (
select owner, object_type,object_name from dba_objects where owner in 
(
'BBBC_DW'
,'CLBC_DW'
,'COL_DW'
,'CRBC_DW'
,'CRCO_DW'
,'ECBC_DW'
,'GTBC_DW'
,'HNBC_DW'
,'HNCO_DW'
,'HTBC_DW'
,'JMBC_DW'
,'NICO_DW'
,'PABC_DW'
,'PEBC_DW'
,'PRY_DW'
,'PYFC_DW'
,'SVBC_DW'
,'TTBC_DW'
,'USFC_DW'
,'VEN_DW'
)
order by 1)
loop
begin
IF r.object_type='TABLE' then
execute immediate('DROP TABLE '||r.owner||'.'||r.object_name||' purge');
elsif r.object_type='VIEW' then
execute immediate('DROP VIEW '||r.owner||'.'||r.object_name);
elsif r.object_type='SYNONYM' then
execute immediate('DROP SYNONYM '||r.owner||'.'||r.object_name);
elsif r.object_type='SEQUENCE' then
execute immediate('DROP SEQUENCE '||r.owner||'.'||r.object_name);
elsif r.object_type='PACKAGE' then
execute immediate('DROP PACKAGE '||r.owner||'.'||r.object_name);
elsif r.object_type='FUNCTION' then
execute immediate('DROP FUNCTION '||r.owner||'.'||r.object_name);
elsif r.object_type='TYPE' then
execute immediate('DROP TYPE '||r.owner||'.'||r.object_name);
elsif r.object_type='PROCEDURE' then
execute immediate('DROP PROCEDURE '||r.owner||'.'||r.object_name);
elsif r.object_type='TRIGGER' then
execute immediate('DROP TRIGGER '||r.owner||'.'||r.object_name);
end if;
exception when others then
execute immediate ('Error al querer borrar '||r.owner||'.'||r.object_type||'.'||r.object_name);
execute immediate (SQLERRM);
end;
end loop;
end;
/