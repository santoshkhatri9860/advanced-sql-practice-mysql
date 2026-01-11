/* Ranking Question 1 (Beginner Level)
For each department, return:
emp_name
dept_id
salary
ROW_NUMBER() over salary DESC
RANK() over salary DESC
DENSE_RANK() over salary DESC
Partition by dept_id
Order by salary DESC
*/
select emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary desc), rank() over(partition by dept_id order by salary desc), dense_rank() over(partition by dept_id order by salary desc)
from employees;

/*
For each department, list
emp_name
dept_id
salary
rank of salary within the department (highest salary = rank 1)
using only RANK(), nothing else.
*/

select emp_name, dept_id, salary, rank() over(partition by dept_id order by salary desc)
from employees;

/* For each department, list employees whose salary rank is 1 or 2 using RANK().
*/
select emp_name, dept_id, salary, dept_salary_rank from 
(
select emp_name,dept_id, salary, rank() over(partition by dept_id order by salary desc) as dept_salary_rank
from employees) as e
where e.dept_salary_rank in (1,2) ;

/*
For each department, return all employees except those with salary rank = 1
(so exclude the highest-paid employees in every department).
*/
select emp_name, dept_id, salary, dept_salary_rank
from(
select emp_name, dept_id, salary, rank() over(partition by dept_id order by salary desc) as dept_salary_rank
from employees) as e
where e.dept_salary_rank not in (1);


select emp_name, dept_id, salary, dept_salary_rank 
from
( select emp_name, dept_id, salary, rank() over(partition by dept_id order by salary desc) as dept_salary_rank 
from employees) as e 
where e.dept_salary_rank > 1;

/*
For each department, show:
emp_name
dept_id
salary
salary_dense_rank
where salary_dense_rank is dense_rank of salary within each department (highest salary = 1).
*/
select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as salary_dense_rank
from employees;


/* Show each employee’s
emp_name
dept_id
salary
dense rank of salary ACROSS the entire company, not per department.
*/
select emp_name, dept_id, salary, dense_rank() over(order by salary desc) as company_dense_rank
from employees;

/*
For each department, list only those employees who have dense_rank = 1 or 2
(i.e., the top two salary groups, including ties).
*/
select emp_name, dept_id, salary, dense_salary_rank
from (select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as dense_salary_rank
from employees) as e
where e.dense_salary_rank <= 2;

/* For each department, return ONLY employees whose salary is in the third highest salary group, based on DENSE_RANK.
*/
select emp_name, dept_id, salary, dense_salary_rank
from (select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as dense_salary_rank
from employees) as e
where e.dense_salary_rank = 3


/* For each department, return:
emp_name
dept_id
salary
rank_salary
dense_rank_salary

 */
 
 select emp_name, dept_id, salary, rank() over(partition by dept_id order by salary desc) as rank_salary, 
 dense_rank() over(partition by dept_id order by salary desc) as dense_rank_salary
from employees;
		
/*
For each department, return only the employees who earn the second-highest salary amount in that department.
*/
select emp_name, dept_id, salary, dense_rank_salary
from (select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as dense_rank_salary
from employees) as e
where e.dense_rank_salary = 2


/*
For each department, return the employee who appears second when salaries are sorted in descending order, ignoring ties.
*/
select emp_name, dept_id, salary, employee_salary
from
(select emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary desc) as employee_salary
from employees) as e
where employee_salary = 2;

/*
For each department, return all employees whose salary falls in the top 3 salary groups of that department.
(If there are ties within the top 3 groups, include them as well.)
*/
use advanced_sql_practice;

select emp_name, dept_id, salary, dense_rank_salary
from(select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as dense_rank_salary
from employees) as e
where e.dense_rank_salary <= 3;

