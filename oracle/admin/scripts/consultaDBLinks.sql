set feedback off
set heading off
set linesize 500
set pagesize 15000
spool dblinks.log
select db_link||'*'||owner||'*'||''||'*'||username||'*'||created from dba_db_links;
select host||'*' from dba_db_links;
select db_link||'*'||owner||'*'||host||'*'||host||'*'||username||'*'||to_date(created,'DD/MM/YYYY') from dba_db_links;
spool off