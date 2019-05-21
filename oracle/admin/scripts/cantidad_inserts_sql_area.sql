/*  Select muestra la cantidad de inserts en una tabla y dicha cantidad x minutos */

select substr(sql_text,instr(sql_text,'INTO "'),30) tabla,
       rows_processed      registros_procesados,
       round((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutos,
       trunc(rows_processed/((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60)) registros_x_minutos
from   sys.v_$sqlarea
where  sql_text like 'INSERT %INTO "%'
  and  command_type = 2
  and  open_versions > 0;





select rows_processed 
from v$sqlarea
where sql_text like 'INSERT %INTO "%'
and command_type = 2
and open_versions > 0;