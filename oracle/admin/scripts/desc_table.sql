--desc_table.sql
set pagesize 10000
col index_owner for a25
col column_name for a40
col index_name for a40
col data_type for a20


set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col column_name for a20

set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col column_name for a20


set verify off
set lines 300
set feedback off
set trims on
col owner for a20
col r_owner for a20
col column_name for a20

accept TOWNER prompt 'Owner: '
accept TTABLE prompt 'Table: '
prompt
prompt ****************************************************************************************************************
prompt
prompt "&towner"."&ttable"
prompt

prompt
prompt Columns
prompt

select column_id, column_name, data_type, data_length, data_precision from dba_tab_columns
where owner=upper('&TOWNER')
and table_name=upper('&TTABLE')
order by column_id
/

prompt
prompt Indexes
prompt

select index_owner,index_name,column_name,column_position from dba_ind_columns 
where table_owner=upper('&TOWNER') 
and table_name=upper('&TTABLE')
order by column_position
/

prompt
prompt Constraints
prompt
select 
a.constraint_name, b.owner r_owner, b.table_name r_table_name,
a.r_constraint_name, 
a.status, b.status r_status
from dba_constraints a join dba_constraints b
on b.constraint_name=a.r_constraint_name
and b.owner=a.r_owner
where a.owner= upper ('&TOWNER') and
a.table_name=upper('&TTABLE')
order by 1,2
/


prompt
prompt Constraints Columns
prompt

select constraint_name,column_name,position from dba_cons_columns where owner=UPPER('&TOWNER') and table_name=upper('&TTABLE') order by 1,2;

prompt
prompt Referentail Constraints
prompt

select owner,table_name,constraint_name,constraint_type,
r_constraint_name,status 
from dba_constraints where r_owner= UPPER('&TOWNER')
and r_constraint_name in (select constraint_name
from dba_constraints where table_name = upper('&TTABLE')
and owner = UPPER('&TOWNER') 
)
order by 1,2;

prompt
prompt ****************************************************************************************************************
prompt