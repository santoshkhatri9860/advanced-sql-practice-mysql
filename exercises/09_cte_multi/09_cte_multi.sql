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

/*
Practice Question 15 (reinforcement, same concept, slightly harder):
Problem: For each department, return the employee(s) who have the lowest salary (ties included).
Requirements:
Use one CTE
Avoid duplicate rows (no fan-out)
Output: dept_id, emp_id, emp_name, salary
Show departments in increasing order; within each department show higher salaries first
*/

/*
Next (Practice Question 16 — slightly harder, still same theme, no SQL-style hints):
Problem: Return employees who are in the top 2 salaries within their department (ties included).
Requirements: use one CTE with a ranking that handles ties; output dept_id, emp_id, emp_name, salary;
 show departments in increasing order, and within each department show higher salaries first.
*/

/*
Practice Question 17 (next step: CTE chaining, still non-recursive):
Problem: For each department, return employees whose salary is above the department median salary. 
If the department has an even number of employees, use the average of the two middle salaries as the median.
Requirements: use CTEs to structure the steps; output dept_id, emp_id, emp_name, salary; 
show departments in increasing order, and within each department show higher salaries first.
*/

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

/*
Practice Question (one at a time):
Problem: Show each department’s total salary, and also show what percent of the company’s total salary that department represents.
Output columns: dept_id, dept_total_salary, company_total_salary, dept_salary_percent
Rules:
Use CTEs (you will need at least two logical pieces: dept totals and company total)
dept_salary_percent should be a percentage number (not text)
Display departments from highest dept_total_salary to lowest
*/

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

