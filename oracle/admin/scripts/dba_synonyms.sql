--dba_synonyms.sql
set verify off
col db_link for a40
undefine all
set lines 400

select owner,synonym_name,table_owner,table_name,db_link 
from dba_synonyms 
where owner like upper('%&owner%')
and synonym_name like upper('%&synonym_name%')
and table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and table_name like upper('%&table_name%')
order by 1,2,3
/