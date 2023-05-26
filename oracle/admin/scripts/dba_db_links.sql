set linesize 180
set verify off
set head on
set pages 500
col db_link for a40
col host for a50
col username for a40
col owner for a30
select owner,db_link,username,host from dba_db_links
where owner like upper('%&owner%')
and db_link like upper('%&db_link%')
and username like upper('%&username%')
and host like upper('%&host%')
order by 1;