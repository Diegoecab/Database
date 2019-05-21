set verify off
col db_link for a30
accept owner prompt 'Ingrese owner:  '
select synonym_name,table_owner,table_name,db_link from dba_synonyms where owner=upper('&OWNER');