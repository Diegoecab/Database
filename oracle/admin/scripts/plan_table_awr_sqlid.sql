--plan_table_awr_sqlid


prompt ******************************************************************************************************************
prompt
prompt Execution Plans in AWR:
prompt
prompt ******************************************************************************************************************


SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('&1',null,null,'ADVANCED'));
