--plan_table_sqlid
accept SQLID prompt 'Ingrese SQL_ID:  '
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&SQLID',0,'ADVANCED'));