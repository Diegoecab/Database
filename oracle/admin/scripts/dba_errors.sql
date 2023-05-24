--DCabrera
--dba_errors
col owner for a20
col text for a100
set pages 1000
col object_name for a50
col name for a40
set verify off
set lines 400
--titulo owner
select owner,a.name,a.type,a.sequence,a.line,a.position,a.text from dba_errors a
where owner like upper('%&owner%')
and name like upper('%&name%')
and type like upper('%&type%')
and upper(text) like upper('%&text%')
order by owner,type,a.name,a.line,message_number
/
