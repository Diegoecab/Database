--plan_table_object
--Plan de ejecucion de cualquier sql que se encuentre en memoria que haga referencia a un objeto en particular
accept OBJECT prompt 'Ingrese OBJETO:  '
SELECT t.*
FROM v$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t WHERE sql_text LIKE upper('%&OBJECT%');