PURGE RECYCLEBIN;
PURGE DBA_RECYCLEBIN;

create tablespace sysaux_temp datafile size 100M autoextend on next 100M maxsize 30G;

begin
for r in
(select distinct owner from dba_segments where tablespace_name='SYSAUX' and owner <> 'SYS')
loop
execute immediate 'alter user '||r.owner||' quota unlimited on sysaux_temp';
end loop;
end;
/


begin
for r in (select owner,segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='TABLE')
loop
begin
execute immediate ('alter table '||r.owner||'."'||r.segment_name||'" shrink space cascade');
exception when others THEN
null;
end;
begin
execute immediate ('alter table '||r.owner||'."'||r.segment_name||'" move tablespace sysaux');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('alter table '||r.owner||'.'||r.segment_name||' move tablespace sysaux');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/

begin
for r in (select table_owner,table_name,partition_name from dba_tab_partitions where tablespace_name='SYSAUX')
loop
begin
execute immediate ('alter table '||r.table_owner||'."'||r.table_name||'" move partition '||r.partition_name||' tablespace sysaux');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('alter table '||r.table_owner||'."'||r.table_name||'" move partition '||r.partition_name||' tablespace sysaux');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/


begin
for r in (select owner,segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='INDEX')
loop
begin
execute immediate ('alter index '||r.owner||'.'||r.segment_name||' rebuild tablespace sysaux');
exception when others then
null;
end;
end loop;
end;
/



begin
for r in (select index_owner,index_name,partition_name from dba_ind_partitions where tablespace_name='SYSAUX')
loop
begin
execute immediate ('alter index '||r.index_owner||'."'||r.index_name||'" rebuild partition '||r.partition_name||' tablespace sysaux');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('alter index '||r.index_owner||'."'||r.index_name||'" rebuild partition '||r.partition_name||' tablespace sysaux');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/


set serveroutput on
begin
for r in (
select owner, table_name, column_name, segment_name, tablespace_name from dba_lobs a
where
upper(tablespace_name) like upper('SYSAUX')
and table_name not like 'AQ$_%'
and table_name not like '%QUETAB%'
and exists (select 1 from dba_tables b where b.owner=a.owner and b.table_name=a.table_name)
and exists (select 1 from dba_segments c where c.owner=a.owner and c.segment_name=a.segment_name  and c.segment_type='LOBSEGMENT')
order by 1,2,3
)
loop
begin
--execute immediate ('alter table '||r.owner||'.'||r.table_name||' enable row movement');
execute immediate ('alter table '||r.owner||'.'||r.table_name||' move lob ('||r.column_name||') store as '||r.segment_name||' (tablespace sysaux)');
--dbms_output.put_line ('alter table '||r.owner||'.'||r.table_name||' move lob ('||r.column_name||') store as '||r.segment_name||' (tablespace '||r.tablespace_name||');');
exception when others then 
dbms_output.put_line ('alter table '||r.owner||'.'||r.table_name||' move lob ('||r.column_name||') store as '||r.segment_name||' (tablespace '||r.tablespace_name||')');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/




begin
for r in (select owner,index_name from dba_indexes where tablespace_name='SYSAUX' and status <> 'VALID')
loop
begin
execute immediate ('alter index '||r.owner||'.'||r.index_name||' rebuild tablespace sysaux');
exception when others then
null;
end;
end loop;
end;
/





begin
for r in (select index_owner,index_name, partition_name from dba_ind_partitions where tablespace_name='SYSAUX' and status <> 'VALID')
loop
begin
execute immediate ('alter index '||r.index_owner||'.'||r.index_name||' rebuild partition '||r.partition_name||' tablespace sysaux');
exception when others then
null;
end;
end loop;
end;
/



@decrease_data_files
