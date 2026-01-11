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

/*Next (Recursive Hierarchy Q3 — still Employees only, still simple):
Problem: For dept_id = 1, return only employees at the deepest level of the hierarchy 
(if multiple employees are tied for deepest, include all).
Output: hier, emp_id, emp_name, manager_id, dept_id
*/

/*Recursive Hierarchy Question 4 (Employees only)
Problem:
For dept_id = 1, list each employee along with the total number of people who report to them
(include both direct and indirect reports).
Output columns:
emp_id
emp_name
total_reports
*/

/*
Multi-CTE Reinforcement — Exercise 1 (Very Controlled)
Big picture (don’t solve yet)
We want this final result:
For each department, show how many employees earn more than the department’s average salary.
*/

/* Problem
For each department, show:
dept_id
total number of employees
Requirement:
Departments with no employees must show 0 */

/*Problem
For each department, show:
dept_id
total salary paid in that department
Requirement:
Departments with no employees must show 0 total salary. */

/* Practice #4
Problem
For each department, show:
dept_id
highest_salary in that department
Requirement
Departments with no employees must show 0 */

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

/*
Your task
Write a query that returns:
the maximum hierarchy level
*/

/*Problem
Using the employee hierarchy you have already built with a recursive CTE:
For each employee, determine how many total reports they have.
expected Output (conceptual)
Each row should represent one employee, showing:
employee identifier
employee name
total number of reports
*/

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

/*Recursive CTE — Question 2 (Still BASIC, One New Concept)
Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy 
and show how deep each employee is in the hierarchy.
*/

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee also show who the top-level manager is.
*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a top-level employee or not.
*/

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a leaf employee or not.
*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a manager or not.*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they report to someone or not.*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many direct reports they have. */

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many employees report directly to them.*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the total salary of their direct reports.
*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, determine the highest salary among their direct reports.*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the average salary of their direct reports. */

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the average salary of those direct reports. */

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports. */

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who have at least one direct report. */

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who:
have at least 2 direct reports, AND
whose total direct-report salary is greater than 10,000. */

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees in that department, and
the total salary of employees in that department. */

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the average salary of employees in that department, and
the maximum salary in that department.*/

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees, and
the average salary in that department.
Finally, show only those departments where:
the employee count is at least 5, AND
the average salary is greater than 6,000.*/

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

