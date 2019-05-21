--dba_object_size.sql
select * from 
DBA_OBJECT_SIZE 
where owner like '%&owner%'
and name like '%name%'
order by 1,2
/