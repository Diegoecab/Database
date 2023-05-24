explain plan into plan_table for
&query


select * from table(dbms_xplan.display('PLAN_TABLE',NULL, 'OUTLINE'));