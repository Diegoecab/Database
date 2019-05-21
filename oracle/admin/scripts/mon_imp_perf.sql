col table_name for a30
col rows_processed for 999
select
   substr(sql_text,instr(sql_text,'into "'),30) table_name,
   rows_processed, round((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutes,
   trunc(rows_processed/((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60)) rows_per_minute
from  
   sys.v_$sqlarea
where 
   sql_text like 'insert %into "%' and command_type = 2 and open_versions > 0; 