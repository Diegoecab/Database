
There are multiple useful hints, that are changing Oracle execution plan for some SQL statement and reduces  the cost. One of them is NO_UNNEST hint.

First of all, let’s discuss briefly what UNNEST hint does.

UNNEST hint “Instructs the optimizer to unnest and merge the body of the subquery into the body of the query block that contains it, allowing the optimizer to consider them together when evaluating access paths and joins.”

For example, if we have the query with inline view like that:

select *
from   hr.employees outer
where  outer.salary > (
              select avg(inner.salary)
              from   hr.employees inner
              where  inner.department_id = outer.department_id
       );
What UNNEST hint actually does, is the following:

select *
from   hr.employees outer,
       (
              select department_id, avg(salary) avg_sal
              from   hr.employees
              group by department_id
       )      inner
Where
       outer.department_id = inner.department_id
and    outer.salary > inner.avg_sal;


e.g.

select
 /*+ qb_name(main) unnest(@subq) */
 outer.*
from
 emp outer
where outer.sal > (
 select
 /*+ qb_name(subq) unnest */
 avg(inner.sal)
 from emp inner
 where
 inner.dept_no = outer.dept_no
 )
; 