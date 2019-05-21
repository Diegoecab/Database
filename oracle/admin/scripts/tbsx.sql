
@tbs

column c1 heading "Tablespace" format a20;
column c2 heading "File name";
column c3 heading "Size (MB)";
col c2 format  A50
col c3 format  9999999999999999

select   tablespace_name c1,
         substr(file_name,1,50) c2,
         round((bytes)/1048576,2) c3,
         AUTOEXTENSIBLE
from     sys.dba_data_files 
union all 
select   tablespace_name c1,
         substr(file_name,1,50) c2,
         round((bytes)/1048576,2) c3,
         AUTOEXTENSIBLE
from     sys.dba_temp_files
order by 1,2;

