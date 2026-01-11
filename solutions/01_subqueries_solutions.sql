/* Using a subquery, find the highest-paid employee(s)
*/
use advanced_sql_practice;
select
	emp_name,
    salary
from employees
where salary = (select max(salary) from employees);

/*
Question 6

Display employee names who work in departments
where the average salary is greater than 5500
*/

select
	emp_id,
	emp_name
from employees
where dept_id in
(
select
	dept_id
from employees
group by dept_id
having avg(salary) > 5500);

/*
Write a query to display employee names
who work in departments where
the average salary is greater than 6000.
*/
select
	emp_name
from employees
where dept_id in(

select
	dept_id
from employees
group by dept_id
having avg(salary) > 6000);
/*
Display employee names who work in departments
where the maximum salary is greater than 7000.
*/
select
	emp_name
from employees
where dept_id in (
select
	dept_id
from employees
group by dept_id
having max(salary) > 7000);

/*
Display department names
where at least one employee earns more than Grace.
*/

select
	dept_name
from departments
where dept_id in
(select
    dept_id
from employees
where salary > (select salary from employees where emp_name ='Grace')
group by dept_id
);


/* Show the employee names
who earn more than Grace
*/

select
	emp_name
from employees
where salary > (select salary from employees where emp_name= 'Grace');

/*
Display department names
where no one earns more than Grace.
*/

select
	dept_name
from departments
where dept_id not in (
select
	dept_id
from employees
where salary > (select salary from employees where emp_name = 'Grace')
);

/*
Display employee names
whose salary is not less than anyone in IT department
*/

select
	emp_name
from employees
where salary >= (


(select min(salary) from employees where  dept_id= (SELECT dept_id FROM departments WHERE dept_name = 'IT'))
);

/*
Display employee names
whose salary is greater than or equal to
the highest salary in HR department.
*/

select
	emp_name
from employees
where salary >= (
select max(salary) from employees where dept_id= 
(select dept_id from departments where dept_name = 'HR')
);
	
/*Display employee names
whose salary is greater than or equal to
the average salary in Finance department.
*/
select
	emp_name
from employees
where salary >= (
select avg(salary) from employees where dept_id =
(select dept_id from departments where dept_name = 'Finance')
);

/* 
Display employee names
whose salary is less than
the highest salary in the Marketing department.
*/
select
	emp_name
from employees
where salary < (
select max(salary) from employees where dept_id= 
(select dept_id from departments where  dept_name = 'Marketing')
);

/* Display employee names
whose salary is equal to
the minimum salary in the HR department.
*/

select
	emp_name
from employees
where salary = (select min(salary) from employees where dept_id = (select dept_id from departments where dept_name ='HR'));

/*
Display employee names
whose salary is NOT equal to
the highest salary in the IT department.
*/

select
	emp_name
from employees
where salary != (select max(salary) from employees where dept_id = (select dept_id from departments where dept_name = 'IT'));


/* Display employee names
whose salary is not equal to
the minimum salary in the Finance department.
*/

select
	emp_name
from employees
where salary <> (select min(salary) from employees where dept_id = (select dept_id from departments where dept_name = 'Finance'));


/* Display employee names
whose salary is equal to
the maximum salary in the department where David works.
*/
select
 emp_name
from employees
where salary = (select max(salary) from employees where dept_id =  
(select dept_id from employees where emp_name = 'David'));

/*
Display department names
where the average salary is less than Grace’s salary.
*/
select
	dept_name
from departments
where dept_id in 

(select dept_id from employees group by dept_id having avg(salary)
< (select salary from employees where emp_name = 'Grace'));

/*
Display department names
where the maximum salary
is greater than Grace’s salary.
*/

select
	dept_name
from departments
where dept_id in (
select dept_id
from employees
group by dept_id
having  max(salary) >
(select salary 
from employees
where emp_name= 'Grace')
);

/*
Display department names
where the minimum salary
is less than Grace’s salary.
*/

select
	dept_name
from departments
where dept_id in
(select dept_id
from employees
group by dept_id
having min(salary)<
(select salary from employees where emp_name = 'Grace')
);

/*
Display department names
where the average salary
is equal to the average salary
of the Sales department.
*/
SELECT * FROM Departments;
SELECT * FROM Employees;

select
dept_name
from departments
where dept_id in(
select dept_id
from employees
group by dept_id
having avg(salary) =


(select avg(salary)
from employees
where dept_id =
(select dept_id 
from departments
where dept_name =  'Sales'
)));


/*
Display employee names
who belong to a department that exists in the Departments table.
*/

select
	emp_name
from employees
