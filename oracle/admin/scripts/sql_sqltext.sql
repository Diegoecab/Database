--v$sql_sqltext.sql
set verify off
set long 100000
set lines 90
set pages 10000
set serveroutput on
col sql_fulltext for a20000 word_wrap
set feed off
set head off


--select sql_fulltext from gv$sql where sql_id='&1';
select sql_text from dba_hist_sqltext where sql_id='&1';

select sql_fulltext from v$sql where sql_id='&1';

set head on
set feed on