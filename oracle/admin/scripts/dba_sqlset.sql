--dba_sqlset.sql

set lines 300

col description for a30

select * from DBA_SQLSET order by created
/