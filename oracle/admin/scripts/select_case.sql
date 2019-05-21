REM	Ejemplos de select case
REM ======================================================================
REM select_case.sql		Version 1.1	11 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
SELECT last_name, commission_pct,
  (CASE commission_pct 
    WHEN 0.1 THEN 'Low' 
    WHEN 0.15 THEN 'Average'
    WHEN 0.2 THEN 'High' 
    ELSE 'N/A' 
  END ) Commission
FROM employees ORDER BY last_name; 


SELECT last_name, job_id, salary,
  (CASE
    WHEN job_id LIKE 'SA_MAN' AND salary < 12000 THEN '10%'
    WHEN job_id LIKE 'SA_MAN' AND salary >= 12000 THEN '15%'
    WHEN job_id LIKE 'IT_PROG' AND salary < 9000 THEN '8%'
    WHEN job_id LIKE 'IT_PROG' AND salary >= 9000 THEN '12%'
    ELSE 'NOT APPLICABLE'
  END ) Raise
FROM employees;
