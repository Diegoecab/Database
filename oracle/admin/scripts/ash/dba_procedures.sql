col owner for a40 truncate
col object_name for a40 truncate
col procedure_name for a40 truncate
select owner, object_id, subprogram_id, object_name, procedure_name from dba_procedures where object_name like upper('%&object_name%') and PROCEDURE_NAME like upper('%&procedure_name%') and object_id like '%&object_id%' and subprogram_id like '%&subprogram_id%';