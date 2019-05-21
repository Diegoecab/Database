prompt 
prompt Las vistas se pueden generar con espacios o con campos cortados
prompt

accept spoolname   prompt "Enter spool: "
accept owner       prompt "Enter owner: "
accept viewname    prompt "Enter view name: "


SET HEAD OFF VERIFY OFF
set long 100000
set longc 100000
set linesize 1000
set trimS on
set tab off
spool &spoolname
select 'create view '||owner||'.'||view_name||' as ',text,';'  vtext
from   dba_views 
where  owner like upper('&owner')
and    view_name like upper('&viewname')
ORDER BY VIEW_NAME
/ 
spool off 