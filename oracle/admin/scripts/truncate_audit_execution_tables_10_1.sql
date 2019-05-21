REM sqlplus <RT_OWNER>/<RT_PASSWORD>@<RT_CONNECT> @truncate_audit_execution_tables_10_1.sql
REM for OWB 10.1
REM to truncate wb_rt_audit_executions and dependent audit tables in the runtime repository

set echo off
set verify off

rem 'truncate_audit_execution_tables : begin'

alter table wb_rt_feedback disable constraint fk_rtfb_rta;
truncate table wb_rt_feedback;
rem 'wb_rt_feedback truncated'

alter table wb_rt_error_sources disable constraint fk_rts_rta;
truncate table wb_rt_error_sources;
rem 'wb_rt_error_sources truncated'

alter table wb_rt_error_rows disable constraint fk_rtr_rte;
truncate table wb_rt_error_rows;
rem 'wb_rt_error_rows truncated'

alter table wb_rt_errors disable constraint fk_rter_rta;
truncate table wb_rt_errors;
rem 'wb_rt_errors truncated'

alter table wb_rt_audit_detail disable constraint fk_rtd_rta;
truncate table wb_rt_audit_detail;
rem 'wb_rt_audit_detail truncated'

alter table wb_rt_audit_amounts disable constraint fk_rtam_rta;
truncate table wb_rt_audit_amounts;
rem 'wb_rt_audit_amounts truncated'

alter table wb_rt_operator disable constraint fk_rto_rta;
truncate table wb_rt_operator;
rem 'wb_rt_operator truncated'

alter table wb_rt_audit disable constraint fk_rta_rte;
truncate table wb_rt_audit;
rem 'wb_rt_audit truncated'

alter table wb_rt_audit_parameters disable constraint ap_fk_ae;
truncate table wb_rt_audit_parameters;
rem 'wb_rt_audit_parameters truncated'

alter table wb_rt_audit_messages disable constraint am_fk_ae;
delete from wb_rt_audit_messages where audit_execution_id is not null;
rem 'wb_rt_audit_messages deleted'
rem 'wb_rt_audit_message_lines cascade deleted'
rem 'wb_rt_audit_message_parameters cascade deleted'

alter table wb_rt_audit_files disable constraint af_fk_ae;
delete from wb_rt_audit_files where audit_execution_id is not null;
rem 'wb_rt_audit_files deleted'

truncate table wb_rt_audit_executions;
rem 'wb_rt_audit_executions truncated'

alter table wb_rt_feedback enable constraint fk_rtfb_rta;
alter table wb_rt_error_sources enable constraint fk_rts_rta;
alter table wb_rt_error_rows enable constraint fk_rtr_rte;
alter table wb_rt_errors enable constraint fk_rter_rta;
alter table wb_rt_audit_detail enable constraint fk_rtd_rta;
alter table wb_rt_audit_amounts enable constraint fk_rtam_rta;
alter table wb_rt_operator enable constraint fk_rto_rta;
alter table wb_rt_audit enable constraint fk_rta_rte;
alter table wb_rt_audit_parameters enable constraint ap_fk_ae;
alter table wb_rt_audit_messages enable constraint am_fk_ae;
alter table wb_rt_audit_files enable constraint af_fk_ae;

rem 'truncate_audit_execution_tables : end'

commit;

