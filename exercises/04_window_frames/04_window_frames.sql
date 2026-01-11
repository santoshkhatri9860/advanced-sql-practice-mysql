/*
Display employee name, salary,
and a running total of salary across ALL employees,
ordered by salary ascending.
*/

/* For each employee, display:
emp_name
dept_id
salary
running total of salary within their department,
ordered from smallest salary to largest inside each department
*/

/* Question (Aggregate Window – COUNT, single concept)
For each employee, show:
emp_name
dept_id
salary
the number of employees in that employee’s department
*/

/*
Display each employee’s name, department, salary,
and the highest salary in their department using a window function.
*/

/*
Display emp_name, dept_id, salary
and the lowest salary in their department using a window function.
*/

/*
Q4 (Evaluation — Aggregate Window + Comparison Logic)

Show emp_name, salary, dept_id
for employees whose salary
is greater than the average salary of their department,
using window functions (not subqueries for avg).
*/

/*
Show emp_name, dept_id, salary
where salary < dept_max_salary
using window functions (not subqueries)
*/

/*
Show employees whose salary is above the average salary of their department
using window functions only (no subqueries, no WHERE on window directly — use two-layer logic)
*/

/*
Show employees whose salary
is between
the minimum and maximum salary
of their department,
using window functions — no GROUP BY, no subqueries.
*/

/* 
Using window functions, show each employee’s
salary, dept_id,
department min salary,
department average salary,
and keep only those employees whose salary is greater than the department average salary.
*/

/* Show employees whose salary is LESS THAN the MINIMUM salary of ANOTHER department (Finance) */

/* For each employee, compute:
department average salary
global minimum salary
global maximum salary
Then show only employees whose salary is:
✔ greater than their department average
AND
✔ between global_min and global_max (which will always be true except for learning)
*/

/*
For each employee, show:
emp_name
salary
dept_id
the difference between their salary and the department minimum salary
*/

/* For each employee, show:
emp_name
salary
running_total_salary
Running total should accumulate salaries in ascending order of salary.
*/

/*
For each employee, show:
emp_name
salary
running_min_salary
Running minimum should use salary ORDER BY salary ASC.
*/

/* For each employee, display:
emp_name
salary
running_max_salary
*/

/* List employees with:
emp_name
salary
running_avg_salary (average salary so far)
Based on ascending salary order.
*/

/* For each employee, show
emp_name
salary
running_total_salary
using this window frame:
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/

/* For each employee, calculate the 3-row moving sum of salary,
ordered by salary ascending.
*/

/* Calculate the 3-row moving average of salary
in ascending salary order.
*/

/* Show:
emp_name
salary
sum_current_row
*/

/* For each employee, compute:
emp_name
salary
forward_sum_salary
*/

/*
For each employee, compute the 3-row centered moving average
(previous row, current row, next row)
ordered by salary ascending
*/

/* (1 PRECEDING to 1 FOLLOWING)
compute the centered moving MINIMUM salary
ordered by salary ascending.
*/

/* Compute the centered moving MAXIMUM salary.
Output columns:
emp_name
salary
centered_max_salary
Ordered by salary ASC.
*/

