set linesize 140
set pagesize 40
explain plan for 
select * from customers_obe where CUST_CREDIT_LIMIT=1500;

select plan_table_output plan from table(dbms_xplan.display('plan_table',null,'serial'));