ttitle off
col directory_path for a50
select * from dba_directories 
where directory_name like upper('%&directory_name%')
and directory_path like upper('%&directory_path%')
order by 2
/