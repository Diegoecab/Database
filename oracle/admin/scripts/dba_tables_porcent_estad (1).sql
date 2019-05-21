SELECT owner,table_name, num_rows, sample_size, TRUNC(sample_size*100/DECODE(num_rows,0,1,num_rows),2) porciento
FROM dba_tables order by 1,4;