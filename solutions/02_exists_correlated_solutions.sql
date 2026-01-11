
/*
Display employee names
who belong to a department that exists in the Departments table.
*/

select
	emp_name
from employees
where exists (
select dept_id 
from departments
);



/*
Keep employees whose department exists in Departments table.
*/
use advanced_sql_practice;
select emp_name
from employees
where exists (select dept_id from departments where departments.dept_id = employees.dept_id);

/*
Display employee names
whose department name starts with ‘I’
*/

select
emp_name
from employees
where exists (
select 1 from departments
where departments.dept_id = employees.dept_id and departments.dept_name like 'I%'
);


/* Display employee names
whose department does NOT exist in the Departments table.
*/

select
	emp_name
from employees
where not exists (
select 1
from departments
where employees.dept_id= departments.dept_id
);

/* Show employees whose department name starts with “M” — using EXISTS
*/
select
	emp_name
from employees
where exists(
select 1
from departments
where departments.dept_id = employees.dept_id and dept_name like 'M%')
;

/*
Display employee names
whose department name is either Marketing or Finance
using EXISTS
*/
select 
	emp_name
from employees
where exists (
select 1
from departments
where departments.dept_id = employees.dept_id and dept_name in ('Marketing', 'Finance')
);

/*
Show employee names
who earn more than
the minimum salary in their own department.
*/

select
	emp_name
from employees 
where salary >   (
select min(salary)
from employees
where dept_id = employees.dept_id
);


/*
Display employee names
whose salary is EQUAL TO
the MAX salary in their own department.
*/

select
	emp_name
from employees
where salary = (
select max(salary)
from employees 
where dept_id = employees.dept_id
);


/*
Display employee names
whose salary is greater than the average salary
of THEIR department.
*/

select
	emp_name
from employees
where salary > (
select avg(salary)
from employees
where dept_id = employees.dept_id
);

/*
Show employee names
whose salary is less than
the highest salary within their department
BUT also greater than
the lowest salary in their department.
*/

select
	emp_name
from employees
where salary <
( select max(salary) from employees where dept_id =employees.dept_id)
and
salary > 
(select min(salary) from employees where dept_id = employees.dept_id)
;

/*
Display employee names
whose salary equals the second highest salary in their department.
*/
select
	emp_name
from employees
where salary = (
select max(salary) from employees 
where dept_id = employees.dept_id
and salary < (select max(salary) from employees
				where dept_id = employees.dept_id)
);


/*
Show employee names
whose salary is the second lowest in their department.
*/

select
	emp_name
from employees
where salary = (
select min(salary) from employees where dept_id = employees.dept_id
and salary > (select min(salary) from employees where dept_id = employees.dept_id)

);


/* Assign ranking numbers to employees
within their department
based on salary from highest to lowest.
*/

/*
Your query must:

