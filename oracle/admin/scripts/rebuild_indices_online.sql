set serveroutput on
set timing on
declare
parallel_degree number := 8;
begin
for r in (select owner, index_name, degree from dba_indexes where status not in ('VALID','N/A','USABLE'))
loop
dbms_output.put_line('ALTER INDEX '||r.owner||'.'||r.index_name||' REBUILD ONLINE parallel '||parallel_degree);
dbms_output.put_line('ALTER INDEX '||r.owner||'.'||r.index_name||' parallel (degree '||r.degree||')');
end loop;
for r in (select index_owner, index_name, partition_name from dba_ind_partitions where status not in ('VALID','N/A','USABLE'))
loop
dbms_output.put_line('ALTER INDEX '||r.index_owner||'.'||r.index_name||' REBUILD ONLINE partition '||r.partition_name);
end loop;
end;
/

