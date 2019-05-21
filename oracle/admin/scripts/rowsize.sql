set linesize 180
select owner, table_name, last_analyzed, avg_row_len, num_rows, round(avg_row_len * &1 /1024/1024,2) avgsize
from dba_tables 
where table_name = upper('&2')
/
