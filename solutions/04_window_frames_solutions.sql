/*
Display employee name, salary,
and a running total of salary across ALL employees,
ordered by salary ascending.
*/

select emp_name, salary, sum(salary) over(order by salary) as total_salary
from employees;


/* For each employee, display:
emp_name
dept_id
salary
running total of salary within their department,
ordered from smallest salary to largest inside each department
*/

select emp_name, dept_id, salary, sum(salary) over(partition by dept_id order by salary asc) as detailed_salary
from employees;

/* Question (Aggregate Window – COUNT, single concept)
For each employee, show:
emp_name
dept_id
salary
the number of employees in that employee’s department
*/

select emp_name, dept_id, salary, count(emp_id) over(partition by dept_id) as total_employees
from employees;


/*
Display each employee’s name, department, salary,
and the highest salary in their department using a window function.
*/
select emp_name, dept_id, salary, max(salary) over(partition by dept_id) as highest_salary
from employees;

/*
Display emp_name, dept_id, salary
and the lowest salary in their department using a window function.
*/

select emp_name, dept_id, salary, min(salary) over(partition by dept_id) as lowest_salary
from employees;

/*
Q4 (Evaluation — Aggregate Window + Comparison Logic)

Show emp_name, salary, dept_id
for employees whose salary
is greater than the average salary of their department,
using window functions (not subqueries for avg).
*/
use practice_sql;

select emp_name, salary, dept_id, avg(salary) over(partition by dept_id)  as average_salary
from employees;


select * 
from (
select emp_name, salary, dept_id, avg(salary) over(partition by dept_id)  as average_salary
from employees) as t
where t.salary < t.average_salary  ;

/*
Show emp_name, dept_id, salary
where salary < dept_max_salary
using window functions (not subqueries)
*/

select *
from (
select emp_name, dept_id, salary, max(salary) over(partition by dept_id) as highest_salary
from employees) as sub
where sub.salary < sub.highest_salary;

/*
Show employees whose salary is above the average salary of their department
using window functions only (no subqueries, no WHERE on window directly — use two-layer logic)
*/

select emp_name
from (select emp_name,salary, avg(salary) over(partition by dept_id) as average_salary
	from employees) as a
where a.salary > a.average_salary;


/*
Show employees whose salary
is between
the minimum and maximum salary
of their department,
using window functions — no GROUP BY, no subqueries.
*/
select *
from 
(select emp_name, salary, dept_id, min(salary) over(partition by dept_id)  as min_salary,
max(salary) over(partition by dept_id) as max_salary 
from employees) as a
where a.salary > a.min_salary and  a.salary < a.max_salary;

/* 
Using window functions, show each employee’s
salary, dept_id,
department min salary,
department average salary,
and keep only those employees whose salary is greater than the department average salary.
*/

select *
from (
select
	emp_name,
	salary, 
	dept_id, 
    min(salary) over (partition by dept_id) as min_salary,
	avg(salary) over (partition by dept_id) as avg_salary
from employees) as a
where a.salary > a.avg_salary;

/* Show employees whose salary is LESS THAN the MINIMUM salary of ANOTHER department (Finance) */

select *
from (
select e.emp_name, e.dept_id , e.salary, d.dept_name, MIN(CASE WHEN dept_name = 'Finance' THEN salary END)
OVER () as finance_min_salary
		from employees e
        join departments d
        on e.dept_id = d.dept_id 
) as b
where b.salary < b.finance_min_salary ;

/* For each employee, compute:
department average salary
global minimum salary
global maximum salary
Then show only employees whose salary is:
✔ greater than their department average
AND
✔ between global_min and global_max (which will always be true except for learning)
*/

select *
from (select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dept_avg, min(salary) over() as global_min,
max(salary) over() as global_max
from employees ) as b
where b.salary > b.dept_avg and (b.salary between b.global_min and b.global_max)
;

/*
For each employee, show:
emp_name
salary
dept_id
the difference between their salary and the department minimum salary
*/

select *
from (select emp_name, salary, dept_id, (salary- min(salary) over(partition by dept_id)) as difference
from employees) as b;

/* For each employee, show:
emp_name
salary
running_total_salary
Running total should accumulate salaries in ascending order of salary.
*/
select emp_name, salary, sum(salary) over(order by salary asc) as running_total_salary
from employees;


/*
For each employee, show:
emp_name
salary
running_min_salary
Running minimum should use salary ORDER BY salary ASC.
*/
select emp_name, salary, min(salary) over(order by salary asc) as running_min_salary
from employees;


/* For each employee, display:
emp_name
salary
running_max_salary
*/
select emp_name, salary, max(salary) over (order by salary asc) as running_max_salary
from employees;

/* List employees with:
emp_name
salary
running_avg_salary (average salary so far)
Based on ascending salary order.
*/
select emp_name, salary, avg(salary) over (order by salary asc) as running_avg_salary
from employees;

/* For each employee, show
emp_name
salary
running_total_salary
using this window frame:
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/
select emp_name, salary, sum(salary) over(order by salary rows between unbounded preceding and current row) as running_total_salary
from employees;

/* For each employee, calculate the 3-row moving sum of salary,
ordered by salary ascending.
*/

select emp_name, salary, sum(salary) over(order by salary asc rows between 2 preceding and current row) as moving_sum
from employees;

/* Calculate the 3-row moving average of salary
in ascending salary order.
*/
select emp_name, salary, avg(salary) over(order by salary asc rows between 2 preceding and current row) as moving_avg
from employees;

/* Show:
emp_name
salary
sum_current_row
*/
select emp_name, salary, sum(salary) over(order by salary asc rows between current row and current row) as sum_current_row
from employees;

/* For each employee, compute:
emp_name
salary
forward_sum_salary
*/
select emp_name, salary, sum(salary) over(order by salary asc rows between current row and 2 following) as forward_sum_salary
from employees;

/*
For each employee, compute the 3-row centered moving average
(previous row, current row, next row)
ordered by salary ascending
*/
select emp_name, salary, avg(salary) over(order by salary asc rows between 1 preceding and 1 following) as centered_moving 
from employees;

/* (1 PRECEDING to 1 FOLLOWING)
compute the centered moving MINIMUM salary
ordered by salary ascending.
*/
select emp_name, salary, min(salary) over(order by salary asc rows between 1 preceding and 1 following) as mini_salary
from employees;

/* Compute the centered moving MAXIMUM salary.
Output columns:
emp_name
salary
centered_max_salary
Ordered by salary ASC.
*/
select emp_name, salary, max(salary) over(order by salary asc rows between 1 preceding and 1 following) as centered_max_salary
from employees;

