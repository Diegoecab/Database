select inst_id, component, parameter, initial_size/1024/1024 "INITIAL", final_size/1024/1024 "FINAL", status,
to_char(end_time ,'mm/dd/yyyy hh24:mi:ss') changed
from gv$sga_resize_ops
order by 1, 7
/

select component, current_size/1024/1024 "CURRENT_SIZE", min_size/1024/1024 "MIN_SIZE",
  user_specified_size/1024/1024 "USER_SPECIFIED_SIZE", last_oper_type "TYPE"
  from v$sga_dynamic_components;