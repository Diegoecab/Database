--dba_synonyms.sql
set verify off
col db_link for a40
undefine all
set lines 400
col synonym_name for a30 truncate
col table_owner for a20 truncate
col owner for a20 truncate
col table_name for a30 truncate
col db_link for a30 truncate

select owner,synonym_name,table_owner,table_name,db_link 
from dba_synonyms 
where owner like upper('%&owner%')
and synonym_name like upper('%&synonym_name%')
and table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and table_name like upper('%&table_name%')
order by 1,2,3
/