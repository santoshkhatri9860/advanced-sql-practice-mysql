/* Write the SQL to compute previous_salary using LAG().
*/

/*For each employee, show:
emp_name
salary
next_salary
*/

/* For each employee, calculate the salary difference compared to the previous employee, based on ascending salary order.
Output:
emp_name
salary
previous_salary
salary_difference
*/

/*
For each employee, show:
emp_name
salary
previous_salary
did_salary_increase
*/

/*
For each employee, classify their salary trend compared to the previous employee.
Output columns:
emp_name
salary
previous_salary
salary_trend
*/

/* For each employee, compute the salary change amount and salary change direction
compared to the previous employee.
Output:
emp_name
salary
previous_salary
salary_change_amount
salary_change_direction
Where:
salary_change_amount = salary - previous_salary
salary_change_direction = 'Up', 'Down', 'Same', or 'N/A'
*/

/* For each employee, compute the salary difference compared to the previous employee within the SAME department.
Output:
emp_name
dept_id
salary
previous_salary_in_dept
difference_in_dept
*/

/*
For each employee, show the next employee's salary within the same department
(ordered by salary ASC).
Output:
emp_name
dept_id
salary
next_salary_in_dept
difference_to_next
*/

/*
For each employee, show:
emp_name
dept_id
salary
previous_salary_in_dept
next_salary_in_dept
is_current_salary_the_middle_value
Where:
is_current_salary_the_middle_value = 'YES' if:
previous_salary < salary < next_salary
Otherwise 'NO'.
NULL cases should produce 'N/A' for the first or last salary in each department.
*/

