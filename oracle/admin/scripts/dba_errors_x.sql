col owner for a20
col text for a20
set pages 1000
col object_name for a40 heading "Nombre|de|Objeto"
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '
select a.owner,a.type,a.sequence,a.line,a.position,a.text,a.message_number from dba_errors a
where a.name='&OBJ_NAME'
order by owner,type,a.name,message_number
/
