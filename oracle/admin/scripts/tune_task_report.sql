set serveroutput on
set long 1000000000
col reco for a190
set lines 195
set pages 400

--define taskname='&task'

select DBMS_SQLTUNE.report_TUNING_TASK( '&taskname' ) as reco
from dual
/
