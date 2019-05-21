set pages 1000
set verify off
set lines 400
set feedback off
set trims on
col owner for a20
col text for a150
col object_name for a40

select text from dba_source
where owner like upper('%&owner%')
and name like  upper('%&obj_name%')
and upper(text) like upper('%&text%')
order by owner,name,type,line;