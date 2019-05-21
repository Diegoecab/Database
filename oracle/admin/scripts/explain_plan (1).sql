set pages 1000
set verify off
set lines 132
set feedback off
set trims on

accept SQL prompt 'Ingrese SQL: '

explain plan for &SQL

select 
  substr (lpad(' ', level-1) || operation || ' (' || options || ')',1,30 ) "Operation", 
  object_name                                                              "Object"
from 
  plan_table 
start with id = 0 
connect by prior id=parent_id;