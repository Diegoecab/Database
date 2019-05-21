-- table_conf.sql
-- Andy Barry
-- 17/06/07

set lines 100 pages 999
set verify off
set feedback off

undefine owner
undefine table

accept owner prompt 'Enter owner:'
accept table prompt 'Enter table name:'

prompt
prompt ======= General info ==============================================

col last_analyzed format a15
select to_char(last_analyzed, 'dd/mm/yy hh24:mi') last_analyzed
,      num_rows
from   dba_tables
where  owner = '&&owner'
and    table_name = '&&table'
/

col table_name format a20
select segment_name table_name
,      sum(ceil(bytes / 1024 / 1024)) "SIZE_MB"
from   dba_segments
where  segment_name like '&&table'
and    segment_type in ('TABLE','TABLE PARTITION')
group by segment_name
/

select tablespace_name
from   dba_tables
where  owner = '&&owner'
and    table_name = '&&table'
and    tablespace_name is not null
/

col tablespace_name format a20
col num_rows format 999,999,999
select  p.partition_name
,       p.tablespace_name
,       p.num_rows
,       ceil(s.bytes / 1024 / 1204) mb
from    dba_tab_partitions p
,       dba_segments s
where   p.table_owner = s.owner
and     p.partition_name = s.partition_name
and     p.table_name = s.segment_name
and     p.table_owner = '&owner'
and     p.table_name = '&table'
order by partition_position
/

prompt
prompt ======= Indexes ===================================================

select i.index_name
,      nvl(i.tablespace_name, '(partitioned)') tablespace_name
,      ceil(s.bytes / 1048576) "Size MB"
from   dba_indexes i
,      dba_segments s
where  i.index_name = s.segment_name
and    i.owner = '&&owner'
and    table_name like '&&table'
order by 2, 1
/

select  ti.index_name
,	pi.partition_name
,       pi.tablespace_name
,       pi.status
from    dba_indexes ti
,       dba_ind_partitions pi
where   ti.partitioned = 'YES'
and     ti.table_name = '&&table'
and     pi.index_owner = '&&owner'
and     pi.index_owner = ti.owner
and     pi.index_name = ti.index_name
order by 1, pi.partition_position
/

prompt
prompt ======= Constraints ===============================================

col type format a10
col cons_name format a30
select  decode(constraint_type,
                'C', 'Check',
                'O', 'R/O View',
                'P', 'Primary',
                'R', 'Foreign',
                'U', 'Unique',
                'V', 'Check view') type
,       constraint_name cons_name
,       status
,       last_change
from    dba_constraints
where   owner like '&&owner'
and     table_name like '&&table'
order by 1
/

prompt
prompt ======= Triggers ==================================================

select  trigger_name
,       trigger_type
,       status
from    dba_triggers
where   owner = '&&owner'
and     table_name = '&&table'
order by status, trigger_name
/


undefine owner
undefine table
set verify on feedback on
