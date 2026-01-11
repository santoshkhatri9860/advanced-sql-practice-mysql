/* CTE*/
/* Practice Question 1
Problem: Find all employees who earn more than 5000.
Requirements:

Create a CTE named high_earners that selects all employees with salary > 5000
In your main query, select all columns from the CTE
Order the results by salary in descending order

Expected columns in output: emp_id, emp_name, dept_id, salary
*/

with high_earners as 
(
select emp_id, emp_name, dept_id, salary
from employees
where salary > 5000
)
select *
from high_earners
order by salary desc;

/* Practice Question 2
Problem: Find all employees from department 2 who have names starting with the letter 'D' or later in the alphabet (D, E, F, G, etc.).
Requirements:

Create a CTE named dept2_employees
Filter for employees in department 2 whose names start with 'D' or any letter that comes after 'D' alphabetically
In your main query, display emp_id, emp_name, and salary
Sort the results by emp_name alphabetically

Expected columns in output: emp_id, emp_name, salary
*/

with dept2_employees as
(
select emp_id, emp_name, salary
from employees
where dept_id = 2 and emp_name >= ('D')
)
select *
from dept2_employees
order by emp_name asc;

/* Practice Question 3
Problem: Find all employees whose salary is between 4000 and 5000 (inclusive) and who work in either department 1 or department 4.
Requirements:

Create a CTE named mid_range_salaries
Filter for employees with salaries between 4000 and 5000 (both values included)
Filter for employees in department 1 OR department 4
In your main query, display all columns
Sort by department (ascending), then by salary (descending)

Expected columns in output: emp_id, emp_name, dept_id, salary
*/
with mid_range_salaries as
(
select emp_id, emp_name, dept_id, salary
from employees
where (salary between 4000 and 5000)  and (dept_id in (1,4))
)
select *
from mid_range_salaries
order by dept_id asc, salary desc;

/* Practice Question 4
Problem: Find the employee with the highest salary in department 3.
Requirements:

Create a CTE named dept3_max_salary that finds the maximum salary in department 3
In your main query, join this CTE with the Employees table to get the complete employee details who has that maximum salary
Display emp_id, emp_name, dept_id, and salary

Expected columns in output: emp_id, emp_name, dept_id, salary
*/

with dept3_max_salary as 
(
select 
dept_id,
max(salary) as max_salary
from employees
where dept_id = 3
)
select e.emp_id, e.emp_name, e.dept_id, e.salary
from employees e
join dept3_max_salary d
on e.salary = d.max_salary ;

/* 
Practice Question 5
Problem: Calculate the average salary for each department and then find all employees who earn 
more than their department's average salary.
Requirements:

Create a CTE named dept_avg_salaries that calculates the average salary for each department
In your main query, join this CTE with the Employees table
Filter for employees whose salary is greater than their department's average
Display emp_id, emp_name, dept_id, salary, and the department's average salary (you can name it avg_dept_salary)
Sort by dept_id ascending, then by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, avg_dept_salary
*/

with dept_avg_salaries as 
(
select 
dept_id,
round(avg(salary),2) as avg_salary
from employees
group by dept_id
)
select
	e.emp_id, e.emp_name, e.dept_id, e.salary, avg_salary
from employees e
join dept_avg_salaries d
on e.dept_id = d.dept_id
where e.salary > d.avg_salary
order by dept_id asc, salary desc;

/*
Practice Question 6
Problem: Find all employees who earn exactly the same salary as at least one other employee in a different department.
Requirements:

Create a CTE named salary_counts that counts how many employees have each salary amount across all departments
In your main query, find employees whose salary appears more than once in the entire company
Display emp_id, emp_name, dept_id, and salary
Sort by salary descending, then by emp_name ascending

Expected columns in output: emp_id, emp_name, dept_id, salary
*/
with salary_counts as
(
select 
count(salary) as count_salary,
salary
from employees
group by salary
)
select e.emp_id, e.emp_name, e.dept_id, e.salary
from employees e
join salary_counts s
on e.salary = s.salary
where s.count_salary > 1
order by salary desc, emp_name asc;


/*
Practice Question 7
Problem: Find the second highest salary in each department.
Requirements:
Create a CTE named dept_salary_ranks that assigns a rank to each salary within each department 
(highest salary gets rank 1, second highest gets rank 2, etc.)
Use the DENSE_RANK() window function
In your main query, filter for only the rows where the rank is 2
Display dept_id and the second highest salary (you can name it second_highest_salary)
Sort by dept_id ascending

Expected columns in output: dept_id, second_highest_salary
Hint: You'll need to use PARTITION BY with the window function.
*/
with dept_salary_ranks as 
(
select
	dept_id,
    salary,
    dense_rank() over(partition by dept_id order by salary desc) as second_highest_salary_rank
    from employees	
)
select 
	dept_id, 
	salary as second_highest_salary
from dept_salary_ranks
where second_highest_salary_rank = 2
order by dept_id asc;

/*
Practice Question 8
Problem: Find employees who earn more than the average salary of the entire company.
Requirements:

Create a CTE named company_avg that calculates the overall average salary across all employees (just one number for the whole company)
In your main query, select employees whose salary is greater than this company average
Display emp_id, emp_name, dept_id, salary, and the company average (name it company_avg_salary)
Sort by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, company_avg_salary
*/

with company_avg as
(
select
	round(avg(salary),2) as company_avg_salary
from employees
)
select
	e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary,
    c.company_avg_salary
from employees e
cross join company_avg c
where e.salary > c.company_avg_salary
order by salary desc;
    
/*
Practice Question 9
Problem: Find the total number of employees and total salary expenditure for each department, 
but only show departments where the total salary expenditure exceeds 25000.
Requirements:

Create a CTE named dept_summary that calculates the count of employees and sum of salaries for each department
In your main query, filter for departments where total salary is greater than 25000
Display dept_id, total number of employees (name it employee_count), and total salary (name it total_salary)
Sort by total_salary descending

Expected columns in output: dept_id, employee_count, total_salary
*/

with dept_summary as
(
select
	dept_id,
    count(*) as employee_count,
    sum(salary) as total_salary
from employees
group by dept_id
)
select
	dept_id,
    employee_count,
    total_salary
from dept_summary
where total_salary > 25000
order by total_salary desc;
    
/*
Practice Question 10
Problem: Find all employees whose salary is higher than the average salary of their own department.
Requirements:

Create a CTE named dept_averages that calculates the average salary for each department
In your main query, join with the employees table and filter for employees whose salary exceeds their department's average
Display emp_id, emp_name, dept_id, employee's salary, and their department's average salary (name it dept_avg_salary)
Sort by dept_id ascending, then by salary descending

Expected columns in output: emp_id, emp_name, dept_id, salary, dept_avg_salary
*/
with dept_averages as
(
select
	dept_id,
    round(avg(salary),2) as dept_avg_salary
from employees
group by dept_id
)
select 
	e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary,
	c.dept_avg_salary
from employees e
join dept_averages c
on e.dept_id = c.dept_id
where e.salary > c.dept_avg_salary
order by e.dept_id asc, e.salary desc;


/*
Practice Question 11 (Intermediate – CTE + Aggregation)
Find departments where the average salary is greater than 6000, then list all employees in those departments.
Requirements:
Create a CTE named high_avg_departments
Compute average salary per department
Keep only departments with avg salary > 6000
In the main query, return employees from those departments
Output columns: emp_id, emp_name, dept_id, salary
Order by dept_id ASC, salary DESC
*/
with high_avg_departments as
(
select 
	dept_id,
	round(avg(salary),2) as dept_avg
from employees
group by dept_id
having dept_avg > 6000


)
select
	e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary
from employees e
join high_avg_departments h
on e.dept_id = h.dept_id
order by dept_id asc, salary desc;

/* Practice Question 12 (Next Level – CTE + Ranking Concept)
Problem:
For each department, find employees who earn the highest salary in that department.
Rules:
Use one CTE
The CTE should help identify the top salary per department
Final output should show only employees who match that top salary
Output columns: emp_id, emp_name, dept_id, salary
*/

with max_dept_salary as
(
select
	dept_id,
    max(salary) as max_salary
from employees
group by dept_id
)
select
	e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary
from employees e
join max_dept_salary m
on e.dept_id = m.dept_id
where e.salary = m.max_salary;

/*
Practice Question 13 (same question, rewritten in your preferred style):
Problem: Return employees who earn more than their own department’s average salary,
 but only include departments that have 5 or more employees.
Requirements:
Use CTEs to (1) identify departments with at least 5 employees, and (2) compute department average salaries
Final output columns: emp_id, emp_name, dept_id, salary
Display results grouped by department, and within each department show higher salaries before lower salaries
*/
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


