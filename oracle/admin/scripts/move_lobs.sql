

alter table sys.WRH$_SQLTEXT move lob (SQL_TEXT) store as SYS_LOB0005101868C00004$$ (tablespace sysaux_temp);


SELECT 'alter table ' || TABLE_OWNER || '.' || TABLE_NAME || ' move partition ' || partition_name 
|| ' tablespace sludata lob (' || COLUMN_NAME || ') store as '||LOB_PARTITION_NAME||'# (tablespace sludata);'
FROM DBA_LOB_PARTITIONS
/


SELECT 'alter table ' || TABLE_OWNER || '.' || TABLE_NAME || ' move tablespace sludata lob (' || COLUMN_NAME || ') store as '||LOB_NAME||'# (tablespace sludata);'
FROM DBA_LOBS
/


alter table slu.tenvio_mail MODIFY DEFAULT ATTRIBUTES TABLESPACE sludata;





begin
for r in (select owner,segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='TABLE')
loop
begin
execute immediate ('alter table '||r.owner||'."'||r.segment_name||'" shrink space cascade');
exception when others THEN
null;
end;
begin
execute immediate ('alter table '||r.owner||'."'||r.segment_name||'" move tablespace sysaux_temp');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('alter table '||r.owner||'.'||r.segment_name||' move tablespace sysaux_temp');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/


begin
for r in (select owner,segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='TABLE')
loop
begin
execute immediate ('alter table '||r.owner||'."'||r.segment_name||'"  DEALLOCATE UNUSED ');
exception when others THEN
DBMS_OUTPUT.PUT_LINE('alter table '||r.owner||'."'||r.segment_name||'"  DEALLOCATE UNUSED ');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end;
/


begin
for r in (select owner,segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='INDEX')
loop
begin
execute immediate ('alter index '||r.owner||'.'||r.segment_name||' rebuild tablespace sysaux_temp');
exception when others then
null;
end;
end loop;
end;
/


begin
for r in (
SELECT owner, iot_name FROM dba_tables WHERE table_name in (
select segment_name from dba_segments where tablespace_name='SYSAUX')
and iot_name is not null)
loop
begin
execute immediate ('ALTER TABLE '||r.owner||'."'||r.iot_name||'" ENABLE ROW MOVEMENT');
exception when others THEN
null;
end;
begin
execute immediate ('ALTER TABLE '||r.owner||'."'||r.iot_name||'" OVERFLOW SHRINK SPACE cascade');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('ALTER TABLE '||r.owner||'.'||r.iot_name||' OVERFLOW SHRINK SPACE cascade');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end
;


begin
for r in (
SELECT owner, iot_name FROM dba_tables WHERE table_name in (
select segment_name from dba_segments where tablespace_name='SYSAUX' and segment_type='TABLE')
and iot_name is not null)
loop
begin
execute immediate ('ALTER TABLE '||r.owner||'.'||r.iot_name||' ENABLE ROW MOVEMENT');
exception when others THEN
null;
end;
begin
execute immediate ('ALTER TABLE '||r.owner||'.'||r.iot_name||'  SHRINK SPACE cascade');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('ALTER TABLE '||r.owner||'.'||r.iot_name||' OVERFLOW SHRINK SPACE');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end
;


ALTER TABLE CHNF$_GROUP_FILTER_IOT SHRINK SPACE cascade

begin
for r in (
select a.owner,column_name,table_name,a.segment_name,index_name,b.tablespace_name,bytes/1024/1024 MB from dba_lobs a
inner join dba_segments b on b.segment_name=a.segment_name
where b.tablespace_name='SYSAUX'
)
loop
begin
execute immediate ('ALTER TABLE '||r.owner||'."'||r.table_name||'" ENABLE ROW MOVEMENT');
exception when others THEN
null;
end;
begin
execute immediate ('ALTER TABLE '||r.owner||'."'||r.table_name||'" modify lob('||r.column_name||') (shrink space cascade)');
exception when others THEN
DBMS_OUTPUT.PUT_LINE ('ALTER TABLE '||r.owner||'."'||r.table_name||'" modify lob('||r.column_name||') (shrink space cascade)');
DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
end loop;
end
;





begin
for r in (select owner,index_name from dba_indexes where tablespace_name='SYSAUX' and status <> 'VALID')
loop
begin
execute immediate ('alter index '||r.owner||'.'||r.index_name||' rebuild tablespace sysaux_temp');
exception when others then
null;
end;
end loop;
end;
/