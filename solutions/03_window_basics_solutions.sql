/* Assign ranking numbers to employees
within their department
based on salary from highest to lowest.
*/

/*
Your query must:

✔ Use ROW_NUMBER()
✔ Use PARTITION BY dept_id
✔ Use ORDER BY salary DESC
*/

select
	emp_name,
    dept_id,
    salary,
    row_number() over (partition by dept_id order by salary desc) as ranking
from employees ;

/* For each employee, return:
employee name
department id
salary
the average salary of their department
using a window function.
*/

select
	emp_name, dept_id, salary,
    avg(salary) over(partition by dept_id) as average_Salary
from employees;

