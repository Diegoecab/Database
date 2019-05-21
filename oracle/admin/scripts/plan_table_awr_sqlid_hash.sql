--plan_table_awr_sqlid_hash
accept SQLID prompt 'Ingrese SQL_ID:  '
accept PLAN_HASH prompt 'Ingrese SQL_HASH_VALUE:  '
SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('&SQLID','&PLAN_HASH',null,'ADVANCED'));

--SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('atfwcg8anrykp'));