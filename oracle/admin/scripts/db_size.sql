select 'SEG', round(sum(bytes/1024/1024/1024),1) GB from dba_segments
union all
select 'DAT', round(sum(bytes/1024/1024/1024),1) GB from dba_data_files
union all
select 'TMP', round(sum(bytes/1024/1024/1024),1) GB from dba_temp_files
/