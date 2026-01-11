/*Next question (Recursive Hierarchy Q1 — Employees only)
Problem: Starting from the HR department head (dept_id = 1, manager_id is NULL), 
list all employees in that reporting chain (head + all direct/indirect reports).
Output columns:
level (1 for head, 2 for direct reports, 3 for indirect, etc.)
emp_id
emp_name
manager_id
dept_id
Rules:
One recursive CTE
Anchor: dept_id = 1 and manager_id is NULL
Recursive: employees whose manager_id matches the previous level’s emp_id (and still dept_id = 1)
Display from top to bottom by level (and within each level, smaller emp_id first)
*/


with recursive seniority as
(
select 
	1 as hier_level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from employees
where dept_id = 1 and manager_id is null
union all
select
	hier_level+1,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    e.dept_id
from employees e
join seniority s
on e.manager_id = s.emp_id
where e.dept_id = 1
)
select
	hier_level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from seniority;

/*Next (Recursive Hierarchy Q3 — still Employees only, still simple):
Problem: For dept_id = 1, return only employees at the deepest level of the hierarchy 
(if multiple employees are tied for deepest, include all).
Output: hier, emp_id, emp_name, manager_id, dept_id
*/
with recursive seniority as
(
select 
	1 as level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from employees 
where dept_id = 1 and manager_id is null
union all
select
	s.level +1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    e.dept_id
from employees e
join seniority s
on e.manager_id = s.emp_id
where e.dept_id = 1
),
max_level as(
select max(level)as deepest_level
from seniority
)

select
	s.level,
    s.emp_id,
    s.emp_name,
    s.manager_id,
    s.dept_id
from seniority s
cross join max_level m
where s.level = m.deepest_level
order by s.emp_id;



/*Recursive Hierarchy Question 4 (Employees only)
Problem:
For dept_id = 1, list each employee along with the total number of people who report to them
(include both direct and indirect reports).
Output columns:
emp_id
emp_name
total_reports
*/
WITH RECURSIVE hierarchy AS (
  SELECT
    emp_id,
    emp_name,
    manager_id,
    1 AS level
  FROM employees
  WHERE dept_id = 1 AND manager_id IS NULL

  UNION ALL

  SELECT
    e.emp_id,
    e.emp_name,
    e.manager_id,
    h.level + 1
  FROM employees e
  JOIN hierarchy h
    ON e.manager_id = h.emp_id
  WHERE e.dept_id = 1
),
report_counts AS (
  SELECT
    a.emp_id AS manager_emp_id,
    COUNT(b.emp_id) AS total_reports
  FROM hierarchy a
  JOIN hierarchy b
    ON a.level < b.level
  GROUP BY a.emp_id
)
SELECT
  e.emp_id,
  e.emp_name,
  COALESCE(r.total_reports, 0) AS total_reports
FROM employees e
LEFT JOIN report_counts r
  ON e.emp_id = r.manager_emp_id
WHERE e.dept_id = 1
ORDER BY e.emp_id;

/*
Multi-CTE Reinforcement — Exercise 1 (Very Controlled)
Big picture (don’t solve yet)
We want this final result:
For each department, show how many employees earn more than the department’s average salary.
*/
with dept_average as
(
select
	dept_id,
    round(avg(salary),2) as average
from employees
group by dept_id
), 
 employees_count as
(select 
	e.emp_id,
    e.dept_id,
    e.salary,
    d.average
from employees e
join dept_average d
on e.dept_id = d.dept_id
where e.salary > d.average
),
dept_counts as (

select 
	dept_id,
	count(emp_id) as total_employees
from employees_count
group by dept_id
)
select
	d.dept_id,
    coalesce(c.total_employees,0) as total_employees
from Departments d
left join dept_counts c
on d.dept_id = c.dept_id
order by d.dept_id;

/* Problem
For each department, show:
dept_id
total number of employees
Requirement:
Departments with no employees must show 0 */

with emp_number as
(
select
	dept_id,
    count(emp_id) as total_employees
from employees
group by dept_id
)
select *, coalesce(n.total_employees,0) as total_employees
from departments d
left join  emp_number n 
on d.dept_id = n.dept_id;

/*Problem
For each department, show:
dept_id
total salary paid in that department
Requirement:
Departments with no employees must show 0 total salary. */
with salary_per_dept as
(
select
	dept_id,
    sum(salary) as total_salary
from employees
group by dept_id
)
select
	d.dept_id,
	d.dept_name,
    coalesce(s.total_salary,0) as total_salary
from departments d
left join salary_per_dept s
on d.dept_id = s.dept_id;

/* Practice #4
Problem
For each department, show:
dept_id
highest_salary in that department
Requirement
Departments with no employees must show 0 */
with highest_salary as
(
select
	dept_id,
    max(salary) as max_salary
from employees
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(h.max_salary,0) as max_salary
from departments d
left join highest_salary h
on d.dept_id = h.dept_id;

/*Mixed Multi-CTE Practice #5 (Carefully staged)
Problem
For each department, show:
dept_id
dept_name
employee_count_above_company_avg
Requirements
First compute the company-wide average salary.
Then identify employees who earn more than the company average.
Then compute how many such employees each department has.
Departments with no such employees must show 0.
*/
with company_salary as
(
select
	round(avg(salary),2) as avg_salary
from employees
),
above_company_average as
(
select
	e.emp_id,
    e.dept_id
from employees e
cross join company_salary s 
where e.salary > s.avg_salary
),
employees_count as
(
select
	dept_id,
    count(a.emp_id) as total_employees
from above_company_average a
group by dept_id	
)

select 
	d.dept_id,
    d.dept_name,
    coalesce(c.total_employees,0) as employee_count_above_company_average
from departments d
left join employees_count c
on d.dept_id = c.dept_id

/*
Problem
For each department, show:
dept_id
dept_name
avg_salary_above_dept_avg
What this means
First calculate the average salary per department
Then find employees whose salary is above their own department’s average
Then calculate the average salary of only those above-average employees, per department
If a department has no employees above its department average, show 0
*/

with dept_avg_salary as
(
select
	dept_id,
    round(avg(salary),2) as avg_salary
from employees
group by dept_id
),
employees_above_average as
(
select
	e.emp_id,
    e.dept_id,
    e.salary as above_average
from employees e
join dept_avg_salary d
on e.dept_id = d.dept_id
where e.salary > d.avg_salary
),
avg_salary_above_dept as
(
select
	dept_id,
	round(avg(a.above_average),2) as avg_salary_above_dept_avg
from employees_above_average a
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(b.avg_salary_above_dept_avg,0) as avg_salary_above_dept_avg
from departments d
left join avg_salary_above_dept b
on d.dept_id = b.dept_id;

/*Problem
For each department, show:
dept_id
dept_name
total_salary_above_dept_avg
What this means
First calculate the average salary per department
Then find employees whose salary is above their own department’s average
Then calculate the total salary of only those employees, per department
Departments with no such employees must show 0
*/
with dept_average as
(
select 
	dept_id,
    round(avg(salary),2) as avg_salary
from employees
group by dept_id
),
above_average as
(
select 
	e.emp_id,
    e.dept_id,
    e.salary
from employees e
join dept_average a
on e.dept_id = a.dept_id
where e.salary > a.avg_salary
),
dept_total_salary as
(
select
	dept_id,
    sum(salary) as total_salary
from above_average
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(s.total_salary, 0) as total_salary_above_dept_avg
from departments d
left join dept_total_salary s 
on d.dept_id = s.dept_id;

/* Problem
For each department, show:
dept_id
dept_name
employee_count_above_company_avg_and_dept_avg
What this means (very precise)
An employee should be counted only if BOTH conditions are true:
Their salary is above the company-wide average salary
Their salary is also above their own department’s average salary
*/
with company_avg as
(
select 
	round(avg(salary),2) as avg_company
from employees
),
dept_avg as
(
select
	dept_id,
    round(avg(salary),2) as avg_dept
from employees 
group by dept_id
),
above_average as 
(
select
	e.emp_id,
    e.dept_id,
    e.salary,
    c.avg_company,
    d.avg_dept
from employees e
cross join company_avg c
join dept_avg d
on e.dept_id = d.dept_id
where e.salary > c.avg_company and e.salary > d.avg_dept
),
qualified_employees as
(
select
	dept_id,
    count(emp_id) as qualify_emp
from above_average
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(q.qualify_emp,0) as employee_count_above_company_avg_and_dept_avg
from departments d
left join qualified_employees q
on d.dept_id = q.dept_id;


/*
Write a recursive CTE that:
Uses employees
Anchor: manager_id IS NULL
Recursive step:
joins employees to the CTE
using employees.manager_id = cte.emp_id
Output:
emp_id
emp_name
manager_id
*/
with recursive managing_details as
(
select 
	emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_details m 
on e.manager_id = m.emp_id
)
select 
	emp_id,
    emp_name,
    manager_id
from managing_details;

/* 
Next step will be only one small addition:
Recursive Hierarchy — Q2
Add one column:
level (or depth)
So we can see:
top manager → level 1
direct reports → level 2
indirect reports → level 3, etc. */
/* “Show only employees who are at level 3 or deeper in the hierarchy.” */
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	level,
    emp_id,
    emp_name,
    manager_id
from managing_levels
where level >= 3;

/* 
The one sentence you must remember

If a condition is about what you want to see, it goes after recursion.
If a condition is about what you want to build, it goes inside recursion.
Final mental rule for filtering recursion (write this down)

Filters inside recursion decide what exists.
Filters outside recursion decide what is shown.
*/

/*Using your existing recursive CTE:
write a query that shows:
level
number of employees at that level
*/
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	level,
    count(emp_id) as no_of_employees
from managing_levels
group by level;

/*
Your task
Write a query that returns:
the maximum hierarchy level
*/
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	max(level) as max_depth
from managing_levels;


/*Problem
Using the employee hierarchy you have already built with a recursive CTE:
For each employee, determine how many total reports they have.
expected Output (conceptual)
Each row should represent one employee, showing:
employee identifier
employee name
total number of reports
*/

with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id,
    emp_id as root_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    m.root_id 
from employees e
join managing_levels m
on e.manager_id = m.emp_id
),
reports_count AS (
select
	a.emp_id,
    count(b.emp_id) as total_reports
from managing_levels a
left join managing_levels b
on a.root_id = b.root_id and a.level < b.level
group by a.emp_id
)

SELECT
    e.emp_id,
    e.emp_name,
    COALESCE(r.total_reports, 0) AS total_reports
FROM employees e
LEFT JOIN reports_count r
    ON e.emp_id = r.emp_id
ORDER BY e.emp_id;

/*
Using your Employees table:
Use a recursive CTE
Anchor:
employees with manager_id IS NULL
Recursive step:
add employees whose manager_id matches someone already found
Final output:
emp_id
emp_name
manager_id
*/
with recursive cte as 
(
select
	emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id,emp_name, manager_id
from cte;

/*Recursive CTE — Question 2 (Still BASIC, One New Concept)
Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy 
and show how deep each employee is in the hierarchy.
*/

with recursive cte as
(
select emp_id, emp_name, manager_id, 1 as level
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, level+1
from employees e
join cte c
on e.manager_id= c.emp_id
)
select emp_id, emp_name, manager_id, level
from cte;

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee also show who the top-level manager is.
*/
with recursive cte as
(
select emp_id, emp_name, manager_id, emp_id as top_manager_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, c.top_manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, top_manager_id
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a top-level employee or not.
*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id, 
    case
		when manager_id is null then 'yes' else 'no' end as is_top_employee
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id,  'no' as is_top_employee
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, is_top_employee
from cte ;

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a leaf employee or not.
*/

with recursive cte as 
(
select emp_id, emp_name, manager_id 	
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, 
	case
		when emp_id in (select manager_id from cte ) then 'no' 
        else 'yes' 
	end as is_leaf_employee
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a manager or not.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select 
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id, emp_name, manager_id,
    case
		when emp_id in (select manager_id from cte) then 'yes'
        else 'no' 
	end as is_manager
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they report to someone or not.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id, emp_name, manager_id,
    case
		when manager_id in (select emp_id from cte) then 'yes'
        else 'no'
	end as reports_to_someone
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many direct reports they have. */
with recursive cte as
(
select 
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select a.emp_id, a.emp_name, count(b.emp_id) as direct_report_count
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many employees report directly to them.*/

with  recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as emp_report_count
from cte a
left join cte b 
on b.manager_id = a.emp_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the total salary of their direct reports.
*/
with recursive cte as
(
select 
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name,  sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, determine the highest salary among their direct reports.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name, max(b.salary) as max_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the average salary of their direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name, avg(b.salary) as avg_salary
from cte a
left join cte b
on a.emp_id = b.manager_id 
group by a.emp_id, a.emp_name;

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the average salary of those direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name,
    count(b.emp_id) as direct_reporters,
    avg(b.salary) as avg_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as total_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who have at least one direct report. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as total_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name
having total_reporters >= 1;

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who:
have at least 2 direct reports, AND
whose total direct-report salary is greater than 10,000. */
with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees 
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as direct_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name
having direct_reporters >=2 and total_salary > 10000;


/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees in that department, and
the total salary of employees in that department. */
with recursive cte as
(
select emp_id, emp_name, manager_id, dept_id, salary
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.dept_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
		count(emp_id) as total_employees,
        sum(salary) as total_salary
from cte
group by dept_id;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the average salary of employees in that department, and
the maximum salary in that department.*/
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
	avg(salary) as avg_salary,
    max(salary) as max_salary
from cte
group by dept_id;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees, and
the average salary in that department.
Finally, show only those departments where:
the employee count is at least 5, AND
the average salary is greater than 6,000.*/
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
		count(emp_id) as total_employees,
        avg(salary) as avg_salary
from cte
group by dept_id
having total_employees >= 5 and avg_salary > 6000;

/*Problem
Using the Employees and Departments tables:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees, and
the average salary in that department.
Finally, join this result with the Departments table so that:
every department appears in the output
departments with no employees show:
employee count = 0
average salary = 0*/
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as (
select dept_id,
		count(emp_id) as total_employees,
        avg(salary) as avg_salary
from cte a
group by dept_id
)
select d.dept_id, d.dept_name, 
	case when a.total_employees is null then 0 else a.total_employees end as  total_employees,
    case when a.avg_salary is null then 0 else a.avg_salary end as avg_salary
from departments d
left join cte2 a
on d.dept_id = a.dept_id;

/*Problem
Using the Employees and Departments tables:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each department, calculate:
the total number of employees,
the average salary, and
the number of employees whose salary is above their department’s average salary.
Finally, return all departments, including those with no employees, such that:
employee count shows 0 when there are no employees
average salary shows 0 when there are no employees
above-average employee count shows 0 when none qualify */
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees 
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as 
(
select dept_id,
	count(emp_id) as total_employees,
    avg(salary) as avg_salary
from cte
group by dept_id
), cte3 as 
(
select x.dept_id,
		count(x.emp_id) as employees_above_dept_avg 
from cte x
join cte2 y
on x.dept_id = y.dept_id
where x.salary > y.avg_salary
group by x.dept_id
)
SELECT
    d.dept_id,
    d.dept_name,
    COALESCE(a.total_employees, 0) AS employee_count,
    COALESCE(a.avg_salary, 0) AS avg_department_salary,
    COALESCE(b.employees_above_dept_avg, 0) AS employees_above_dept_avg
from departments d
left join cte2 a
on d.dept_id = a.dept_id
left join cte3 b 
on d.dept_id = b.dept_id;

/*
Problem
Using the Employees and Departments tables:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each department, calculate:
the total number of employees,
the maximum salary in that department, and
the number of employees whose salary is equal to the department’s maximum salary.
Finally, return all departments, including those with no employees, such that:
employee count shows 0 when there are no employees
maximum salary shows 0 when there are no employees
number of employees at maximum salary shows 0 when none qualify */
with recursive cte as
(
select emp_id, emp_name, dept_id, salary, manager_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as
(
select dept_id, 
		count(emp_id) as total_employees,
        max(salary) as max_salary
from cte
group by dept_id
), cte3 as
(
select a.dept_id, count(emp_id) as dept_total_employees
from cte a
join cte2 b 
on a.dept_id =b.dept_id
where a.salary = b.max_salary
group by a.dept_id
)
select
	d.dept_id, d.dept_name, 
	coalesce (w.total_employees, 0) as total_employees,
    coalesce(w.max_salary, 0) as max_salary,
    coalesce(x.dept_total_employees,0) as dept_total_employees
from departments d
left join cte2 w
on d.dept_id = w.dept_id
left join cte3 x
on d.dept_id = x.dept_id;

/*Problem
Using the Employees and Departments tables:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each department, calculate:
the total number of employees,
the minimum salary in that department, and
the number of employees whose salary is strictly greater than the department’s minimum salary.
Finally, return all departments, including those with no employees, such that:
employee count shows 0 when there are no employees
minimum salary shows 0 when there are no employees
the count of employees above the minimum salary shows 0 when none qualify*/
with recursive hierarchy as
(
select *
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary , e.manager_id
from employees e
join hierarchy h
on e.manager_id = h.emp_id
), dept_wise as
(
select dept_id,
		count(emp_id) as total_employees,
        min(salary) as min_salary
from hierarchy
group by dept_id
), above_min as 
(
select a.dept_id,
		count(emp_id) as above_dept_min_salary
from hierarchy a
join dept_wise w
on a.dept_id = w.dept_id
where a.salary > w.min_salary
group by a.dept_id
)
select 
	d.dept_id, d.dept_name, 
    coalesce(c.total_employees,0) as total_employees,
    coalesce(c.min_salary,0) as min_salary,
    coalesce(f.above_dept_min_salary,0) as above_dept_min_salary
from departments d
left join dept_wise c
on d.dept_id = c.dept_id
left join above_min f
on d.dept_id = f.dept_id;

/*Problem
Using the Employees and Departments tables:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each department, calculate:
the total number of employees,
the average salary of the department, and
the number of employees whose salary is between the department’s minimum salary and maximum salary (exclusive).
Finally, return all departments, including those with no employees, such that:
employee count shows 0 when there are no employees
average salary shows 0 when there are no employees
the “between min and max” employee count shows 0 when none qualify */
with recursive hier as
(
select emp_id, emp_name, dept_id, salary, manager_id
from employees 
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary, e.manager_id
from employees e
join hier h 
on e.manager_id = h.emp_id
), dept_wise_detail as 
(
select dept_id, count(emp_id) as total_employees, avg(salary) as avg_salary, min(salary) as min_salary, max(salary) as max_salary
from hier
group by dept_id 
), no_of_between_salary as
(
select a.dept_id, count(emp_id) as middle_salary_employees 
from hier a
join dept_wise_detail b
on a.dept_id= b.dept_id
where salary > b.min_salary and salary < b.max_salary 
group by a.dept_id
)
select 
	d.dept_id, d.dept_name,
    coalesce(c.total_employees,0) as total_employees,
    coalesce(c.avg_salary,0) as avg_salary,
    coalesce(f.middle_salary_employees,0) as middle_salary_employees
from departments d
left join dept_wise_detail c
on d.dept_id = c.dept_id
left join no_of_between_salary f
on d.dept_id = f.dept_id;

USE practice_sql;
SHOW COLUMNS FROM Employees;




