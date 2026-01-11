with dept_sizes as
(
select 
	dept_id,
    count(emp_id) as total_employees
from employees
group by dept_id
having total_employees >= 5
),
dept_avg_salary as
(
select
	dept_id,
    round(avg(salary),2) as avg_salary
from employees
group by dept_id
)
select 
	e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary,
    s.avg_salary
from employees e
join dept_sizes d
on e.dept_id = d.dept_id
join dept_avg_salary s
on e.dept_id = s.dept_id
where e.salary > s.avg_salary
order by dept_id asc, salary desc

/*
Practice Question 14 (you can start now):
Problem: For each department, return the employee(s) with the 2nd highest salary. 
If multiple employees tie for 2nd highest, include all of them.
Requirements:
Use a CTE to assign a salary rank within each department
The ranking method must treat ties correctly (so “2nd highest” can include multiple employees)
Output: dept_id, emp_id, emp_name, salary
Show departments in increasing order; within each department, show higher salaries first
*/
with ranking_salary as
(
select
	emp_id,
	dept_id,
	dense_rank() over(partition by dept_id order by salary desc) as salary_rank
from employees
)
select 
	e.dept_id,
    e.emp_id,
    e.emp_name,
    e.salary,
    r.salary_rank
from employees e
join ranking_salary r
on e.emp_id= r.emp_id
where r.salary_rank = 2
order by e.dept_id asc, e.salary desc;

/*
Practice Question 15 (reinforcement, same concept, slightly harder):
Problem: For each department, return the employee(s) who have the lowest salary (ties included).
Requirements:
Use one CTE
Avoid duplicate rows (no fan-out)
Output: dept_id, emp_id, emp_name, salary
Show departments in increasing order; within each department show higher salaries first
*/
with employees_rank as 
(
select
	emp_id,
    dept_id,
    dense_rank() over(partition by dept_id order by salary asc) as emp_rank
from employees
)
select
    e.dept_id,
    e.emp_id,
    e.emp_name,
    e.salary
from employees e
join employees_rank r 
on e.emp_id = r.emp_id
where r.emp_rank = 1
order by dept_id asc, salary desc;
   
/*
Next (Practice Question 16 — slightly harder, still same theme, no SQL-style hints):
Problem: Return employees who are in the top 2 salaries within their department (ties included).
Requirements: use one CTE with a ranking that handles ties; output dept_id, emp_id, emp_name, salary;
 show departments in increasing order, and within each department show higher salaries first.
*/
with top_salaries as
(
select 
	emp_id,
    dept_id,
    salary,
    dense_rank() over(partition by dept_id order by salary desc) as emp_salary
from employees
)
select
	e.emp_id,
    e.dept_id,
    e.emp_name,
    e.salary
from employees e
join top_salaries t
on e.emp_id = t.emp_id
where t.emp_salary <= 2
order by dept_id asc, salary desc;

/*
Practice Question 17 (next step: CTE chaining, still non-recursive):
Problem: For each department, return employees whose salary is above the department median salary. 
If the department has an even number of employees, use the average of the two middle salaries as the median.
Requirements: use CTEs to structure the steps; output dept_id, emp_id, emp_name, salary; 
show departments in increasing order, and within each department show higher salaries first.
*/
with median_salary as
(
select
dept_id,
avg(salary) as med_salary
from(
select
dept_id, emp_id, emp_name, salary, position, total_employees
from(
select 
    dept_id, emp_id, emp_name, salary,
    row_number() over(partition by dept_id order by salary asc) as position,
    count(*) over(partition by dept_id) as total_employees
from employees
)t
WHERE
(
  total_employees % 2 = 1
  AND position = (total_employees + 1) / 2
)
OR
(
  total_employees % 2 = 0
  AND position IN (total_employees / 2, total_employees / 2 + 1)
)

)b
group by dept_id

)
select
	e.dept_id, e.emp_id, e.emp_name, e.salary
from employees e
join median_salary m
on e.dept_id = m.dept_id
where e.salary > m.med_salary
order by dept_id asc, salary desc

/*
Reinforcement Question (CTE + Window, NO median)
Problem:
For each department, find employees who earn the lowest salary in that department (ties included).
Uses CTE
Uses department-level logic
Uses row vs group thinking
Much simpler than median
Reinforces: “select rows first, then reason at department level”
Rules:
Use one CTE
CTE should help identify the lowest salary per department
Final output columns: emp_id, emp_name, dept_id, salary
Show results department-wise, and within a department higher salaries should appear first	
*/

with lowest_salary as
(
select
	emp_id,
	dept_id,
    salary,
    dense_rank() over(partition by dept_id order by salary asc) as min_rank
from employees
) 
select
		e.emp_id,
        e.emp_name,
        e.dept_id,
        e.salary
from employees e
join lowest_salary l
on e.emp_id = l.emp_id
where l.min_rank = 1
order by dept_id asc, salary desc

/*
Practice Question (one at a time):
Problem: Show each department’s total salary, and also show what percent of the company’s total salary that department represents.
Output columns: dept_id, dept_total_salary, company_total_salary, dept_salary_percent
Rules:
Use CTEs (you will need at least two logical pieces: dept totals and company total)
dept_salary_percent should be a percentage number (not text)
Display departments from highest dept_total_salary to lowest
*/

with salary_propotion as
(
select
	dept_id,
    sum(salary)  as dept_totals
from employees
group by dept_id
)
,

company_salary as
(
select
	sum(salary) as company_total
from employees
)
select
	s.dept_id, s.dept_totals, c.company_total, (s.dept_totals/c.company_total *100) as dept_salary_percent
from salary_propotion s
cross join company_salary c
order by s.dept_totals desc

/*
Practice Question (Reinforcement – CTE + Grain Control)
Problem:
For each department, find how many employees earn more than the department’s minimum salary.
What this tests (important):
Using a CTE to compute a dept-level value
Applying that value to employee-level rows
Choosing the correct join key
Avoiding duplicates by controlling grain
Requirements:
Use one CTE
The CTE should compute the minimum salary per department
Final output should have one row per department
Output columns:
dept_id, employee_count_above_min_salary
Departments with no employee above the minimum should show count = 0
*/

with lowest_salary as
(
select
	dept_id,
    min(salary)  as min_salary
from employees
group by dept_id
)

select
	l.dept_id, 
    count(*) as employee_count_above_min_salary
from lowest_salary l
left join employees e
on l.dept_id = e.dept_id and e.salary > l.min_salary 
group by l.dept_id


