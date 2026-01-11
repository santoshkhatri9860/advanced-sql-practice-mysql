/* Assign row numbers to employees ordered by salary ascending.
Output:
emp_name
salary
row_number_by_salary
*/

/* Assign row numbers within each department, ordered by salary ascending.
Output:
emp_name
dept_id
salary
row_number_in_dept
*/

/* Using ROW_NUMBER(), return only the lowest salary employee per department.
Output:
emp_name
dept_id
salary
*/

/* Find the HIGHEST-paid employee per department using ROW_NUMBER().
Output:
emp_name
dept_id
salary
*/

/* Find the second-highest-paid employee in each department.
Output:
emp_name
dept_id
salary
Rules:
Must use ROW_NUMBER() (not RANK or DENSE_RANK)
Must rank DESC (high → low)
Must filter for row_number = 2
*/

/*
For each department, assign row numbers only to employees whose salary is above the department’s average salary.
Output only:
emp_name
dept_id
salary
row_number_above_avg
Requirements:
Must use ROW_NUMBER()
Must use a subquery
Must filter salaries > department average
Must use PARTITION BY dept_id
Must order by salary DESC
No joins
No window functions inside WHERE
All filtering must happen in the correct place
*/

/* For each department, list all employees whose salary is below the department average.
Output:
emp_name
dept_id
salary
dept_avg
❗ No ranking needed
❗ Must use the 3-layer structure
❗ Window function must compute dept_avg
❗ Filtering must be done in outer layer
*/

/*
For each department, list employees whose salary is ABOVE the department average, and also show how much their salary exceeds the average.
Output:
emp_name
dept_id
salary
dept_avg
difference (salary – dept_avg)
*/

/* For each department, list employees whose salary is ABOVE the department average, and show how they compare to the department MIN and MAX salaries.
Output:
emp_name
dept_id
salary
dept_avg
dept_min
dept_max
salary_minus_min
max_minus_salary
*/

/* For each department, list employees whose salary is BELOW the department MAX salary but ABOVE the department MIN salary (i.e., strictly in the middle). Also show:
dept_min
dept_max
difference_from_min
difference_from_max
difference_from_avg
Columns required in output:
| emp_name | dept_id | salary | dept_min | dept_max | dept_avg | diff_from_min | diff_from_max | diff_from_avg |
*/

/*
For each department, rank all employees who are ABOVE the department average salary.
Output:
emp_name
dept_id
salary
dept_avg
row_number_above_avg
Rules:
Must use EXACT 3-layer structure
Must compute dept_avg in Layer 1
Must filter salary > dept_avg in Layer 2
Must apply ROW_NUMBER() in Layer 3
Must partition by dept_id
Must order salary DESC
*/

/*
For each department, find the TOP 2 employees who are ABOVE the department average salary.
Rank them by salary DESC.
Return only those with row_number ≤ 2.
Output:
emp_name
dept_id
salary
dept_avg
row_num_above_avg
Rules:
Must use 3 layers
Must filter to salary > dept_avg
Must rank using ROW_NUMBER
Must keep only rows where row_number ≤ 2
*/

/*
For each department, list the TOP 3 employees whose salary is BELOW the department MAX salary.
Rank them from highest to lowest salary (DESC).
Return only the top 3 rows per dept.
Output:
emp_name
dept_id
salary
dept_max
rank_below_max
Rules:
Must use layered structure
Must compute dept_max in Layer 1
Must filter salary < dept_max in Layer 2
Must rank in Layer 3
Must filter rank ≤ 3 in Layer 4
*/

/* 
For each department, find the TOP 2 employees whose salary is BETWEEN the department MIN and MAX values (strictly between), ranked by salary DESC.
Output:
emp_name
dept_id
salary
dept_min
dept_max
rank_middle
Requirements:
Layer 1: compute dept_min and dept_max
Layer 2: filter salary > dept_min AND salary < dept_max
Layer 3: apply row_number over (partition by dept_id order by salary desc)
Layer 4: filter row_number <= 2
*/

