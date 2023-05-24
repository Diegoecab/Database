
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

spool /home/oracle/scripts/move_online_schema_RIO265.log

Prompt Invalid objects

set pages 1000
set lines 200
set trims on
set verify off
col owner for a20
col object_name for a40
col sql for a80
break on owner on report
compute sum of tot on report

SELECT   owner, object_type, count(*) tot
   FROM   dba_objects
   WHERE   status <> 'VALID'
   group by owner,object_type
ORDER BY   1
/



set verify off
set lines 400
set pages 1000
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999


Prompt Invalid Indexes

set verify off
set lines 400
set pages 1000
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999
undefine all

select a.owner,a.index_name,a.index_type,a.table_name,a.uniqueness,a.tablespace_name,a.status
from dba_indexes a, dba_tables b
where b.owner = a.owner
and b.table_name = a.table_name
and a.status not in ('VALID','N/A')
order by 1,2,4
/

Prompt executing move online on schema &1


set serveroutput on
declare
ddate  date;
 begin
 for r in (select owner,table_name from dba_tables where owner='&1' and table_name not like 'BIN%') loop
  begin
 select sysdate into ddate from dual;
 dbms_output.put_line (ddate ||' -> alter table '||r.owner||'.'||r.table_name||' move online');
 execute immediate ('alter table '||r.owner||'.'||r.table_name||' move online');
  exception when others then
 dbms_output.put_line ('Error: '||SQLCODE ||' -> '||SUBSTR(SQLERRM, 1, 200));

 end;
 end loop;
 exception when others then
 dbms_output.put_line ('Error: '||SQLCODE ||' -> '||SUBSTR(SQLERRM, 1, 200));
 end;
/

Prompt executing move online on schema &1


set serveroutput on
declare
ddate  date;
 begin
 for r in (select table_owner,table_name,partition_name from dba_tab_partitions where table_owner='&1' and table_name not like 'BIN%') loop
  begin
 select sysdate into ddate from dual;
 dbms_output.put_line (ddate ||' -> alter table '||r.table_owner||'.'||r.table_name||' move partition '||r.partition_name||' online update indexes');
 execute immediate ('alter table '||r.table_owner||'.'||r.table_name||' move partition '||r.partition_name||' online update indexes');
  exception when others then
 dbms_output.put_line ('Error: '||SQLCODE ||' -> '||SUBSTR(SQLERRM, 1, 200));

 end;
 end loop;
 exception when others then
 dbms_output.put_line ('Error: '||SQLCODE ||' -> '||SUBSTR(SQLERRM, 1, 200));
 end;
/



set serveroutput on
begin
for r in (select segment_name from dba_segments where segment_type='INDEX PARTITION' and tablespace_name='FIDEL_DATA') loop
dbms_output.put_line ('alter index FIDEL."'||r.segment_name||'" rebuild online;');
end loop;
end;
/

Prompt Invalid objects

set pages 1000
set lines 200
set trims on
set verify off
col owner for a20
col object_name for a40
col sql for a80
break on owner on report
compute sum of tot on report

SELECT   owner, object_type, count(*) tot
   FROM   dba_objects
   WHERE   status <> 'VALID'
   group by owner,object_type
ORDER BY   1
/



set verify off
set lines 400
set pages 1000
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999


Prompt Invalid Indexes

set verify off
set lines 400
set pages 1000
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999
undefine all

select a.owner,a.index_name,a.index_type,a.table_name,a.uniqueness,a.tablespace_name,a.status
from dba_indexes a, dba_tables b
where b.owner = a.owner
and b.table_name = a.table_name
and a.status not in ('VALID','N/A')
order by 1,2,4
/

spool off
exit;