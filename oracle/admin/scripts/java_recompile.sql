alter system set java_jit_enabled = FALSE;
alter system set "_system_trig_enabled"=FALSE;
alter system set JOB_QUEUE_PROCESSES=0;
create or replace java system
/
alter system set java_jit_enabled = true;
alter system set "_system_trig_enabled"=TRUE;
alter system set JOB_QUEUE_PROCESSES=1000;
@?/rdbms/admin/utlrp.sql
