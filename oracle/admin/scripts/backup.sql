column file_name format a50
col tablespace_name format a15
set lines 132

select
	t.name tablespace_name,
	f.name file_name,
	b.status
from
	v$backup b,
	v$datafile f,
	v$tablespace t
where 	b.file# = f.file# and
	f.ts# = t.ts#
/
