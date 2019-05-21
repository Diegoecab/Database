--DBA_MVIEW_LOGS
set lines 200
select log_owner,master,log_Table,log_trigger,rowids,primary_key,object_id,filter_columns,sequence,include_new_values
from DBA_MVIEW_LOGS
/