set verify off 
set feedback off 
set echo off 
set heading off 
set pagesize 0 
set linesize 120 
set trimspool on
set pause off 
set wrap on 
col sort0 noprint 
col sort1 noprint 
col sort2 noprint 
break on sort1 

column c_tabname noprint new_value tabname 
column c_owner   noprint new_value owner

select upper('&&1') c_tabname, upper('&&2') c_owner from dual
/
select 'prompt ' from dual
/
select 'prompt lockeando las tablas ...' from dual
/
select 'LOCK TABLE ' ||owner||'.'||table_name||' IN EXCLUSIVE  MODE ;' 
from dba_tables
  where table_name = '&tabname'
  and owner = '&owner'
/
select 'prompt ' from dual
/
select 'prompt moviendo las tablas ...' from dual
/
select table_name sort1, 0 sort2, 'ALTER TABLE ' ||ut.owner||'.'||table_name||' MOVE TABLESPACE '
from dba_tables ut
  where ut.table_name = '&tabname'
  and ut.owner = '&owner'
/

select 'prompt ' from dual
/
select 'prompt creando Indices ...' from dual
/
select distinct ui.table_name sort0, ui.index_name sort1, 
                0     sort2, 
       'ALTER INDEX '||ui.owner||'.'||ui.index_name||' REBUILD TABLESPACE '
from dba_indexes     ui 
where ui.table_name = '&tabname'
and ui.owner= '&owner'
/






