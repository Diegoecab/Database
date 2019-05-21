--plan_table_awr_sqlid
accept SQLID prompt 'Ingrese SQL_ID:  '
SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('&SQLID',null,null,'ADVANCED'));