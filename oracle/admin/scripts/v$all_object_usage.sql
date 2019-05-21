--v$all_object_usage
set pagesize 1000
set linesize 200

ttitle 'Monitoring Indexes'

Break on Gb on report 

compute sum of GB on report 


SELECT   p.username,
         table_name,
         index_name,
         (SELECT   ROUND (SUM (bytes) / 1024 / 1024 / 1024)
            FROM   dba_segments s
           WHERE   s.owner = p.username AND s.segment_name = a.index_name and s.segment_type like 'INDEX%')
            Gb,
         used,
         monitoring,
         start_monitoring,
         end_monitoring
  FROM   v$all_object_usage a, dba_users p
 WHERE   a.owner = p.user_id
/

prompt
prompt group by owner
prompt

 select username,sum(gb) from (
 SELECT   p.username,
          table_name,
          index_name,
          (SELECT   ROUND (SUM (bytes) / 1024 / 1024 / 1024)
             FROM   dba_segments s
            WHERE   s.owner = p.username AND s.segment_name = a.index_name and s.segment_type like 'INDEX%')
             Gb,
          used,
          monitoring,
          start_monitoring,
          end_monitoring
   FROM   v$all_object_usage a, dba_users p
  WHERE   a.owner = p.user_id and used='NO'
 ) group by username order by 1
 /
/*
select owner, index_type,count(*) from dba_indexes z where not exists
(
 select 1 from v$all_object_usage a, dba_users p WHERE   a.owner = p.user_id and p.username = z.owner
and table_name = z.table_name and index_name=z.index_name)
and owner not in ('SYS','SYSTEM','XDB','MDSYS','OUTLN','WMSYS','CTXSYS','DBSNMP','TSMSYS','TOAD','DBADMIN')
and index_type <> 'LOB'
group by owner,index_type
order by 1
/

set serveroutput on
begin
for r in (
select owner, index_name from dba_indexes z where not exists
(
 select 1 from v$all_object_usage a, dba_users p WHERE   a.owner = p.user_id and p.username = z.owner
and table_name = z.table_name and index_name=z.index_name)
and owner not in ('SYS','SYSTEM','XDB','MDSYS','OUTLN','WMSYS','CTXSYS','DBSNMP','TSMSYS','TOAD','DBADMIN')
and index_type <> 'LOB'
order by 1,2
)
loop
begin
execute immediate ('ALTER INDEX '||r.owner||'.'||r.index_name||' monitoring usage');
exception when others then 
dbms_output.put_line (r.owner||'.'||r.index_name);
dbms_output.put_line ('Error '||SQLERRM);
end;
end loop;
end;
/

*/
