Analytic Example

The following example calculates, for each employee in the employees table, the moving count of employees earning salaries in the range 50 less than through 150 greater than the employee's salary.

SELECT last_name, salary,
   COUNT(*) OVER (ORDER BY salary RANGE BETWEEN 50 PRECEDING
      AND 150 FOLLOWING) AS mov_count FROM employees;

LAST_NAME                     SALARY  MOV_COUNT
------------------------- ---------- ----------
Olson                           2100          3
Markle                          2200          2
Philtanker                      2200          2
Landry                          2400          8
Gee                             2400          8
Colmenares                      2500         10
Patel                           2500         10