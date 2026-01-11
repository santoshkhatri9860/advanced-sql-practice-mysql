/* Write the SQL to compute previous_salary using LAG().
*/
select emp_name, salary, lag(salary,1) over(order by salary asc)  as previous_salary
from employees;

/*For each employee, show:
emp_name
salary
next_salary
*/
select emp_name,salary, lead(salary,1) over(order by salary asc) as next_salary
from employees;

/* For each employee, calculate the salary difference compared to the previous employee, based on ascending salary order.
Output:
emp_name
salary
previous_salary
salary_difference
*/
select emp_name,salary,lag(salary,1) over(order by salary asc) as previous_salary, (salary-lag(salary,1) over(order by salary asc)) as salary_difference
from employees;

/*
For each employee, show:
emp_name
salary
previous_salary
did_salary_increase
*/
select emp_name,salary,lag(salary) over(order by salary asc) as previous_salary, 
(case when salary- lag(salary) over(order by salary asc) > 0 then 'Yes' 
	  when lag(salary) over(order by salary asc) is null then 'N/A'
      else 'No' end) as did_salary_increase
from employees;


/*
For each employee, classify their salary trend compared to the previous employee.
Output columns:
emp_name
salary
previous_salary
salary_trend
*/
select 
	emp_name,
    salary,
    previous_salary,
    (case
    when  previous_salary is null then 'N/A'
    when salary > previous_salary then 'Increased'
    when salary = previous_salary then 'No change'
    when salary < previous_salary then 'Decreased'
    end) as salary_trend
from 
(select emp_name, salary, lag(salary) over(order by salary asc) as previous_salary
from employees)
as t
;

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

select
	emp_name,
    salary,
    previous_salary,
    (salary - previous_salary) as scm,
    (case
    when previous_salary is null then 'N/A'
    when salary < previous_salary then 'Down'
    when salary = previous_salary then 'Same'
    when salary > previous_salary then 'Up'
    end) as scd
from
(select
	emp_name,
    salary,
    lag(salary) over(order by salary asc) as previous_salary
from employees)
as t;

/* For each employee, compute the salary difference compared to the previous employee within the SAME department.
Output:
emp_name
dept_id
salary
previous_salary_in_dept
difference_in_dept
*/
select
	emp_name, 
    dept_id, 
    salary, 
    lag(salary) over(partition by dept_id order by salary asc) as previous_salary_in_dept,
    (salary - lag(salary) over(partition by dept_id order by salary asc)) as difference_in_dept
from employees;


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
select 
	emp_name,
    dept_id,
    salary,
    lead(salary) over(partition by dept_id order by salary asc) as next_salary,
    abs(salary - lead(salary) over(partition by dept_id order by salary asc)) as difference
from employees;


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
select
	emp_name, dept_id, salary,
	previous_salary,
    next_salary,
    (case
		when previous_salary is null or next_salary is null then 'N/A'
		when previous_salary < salary  and salary < next_salary then 'YES'
        else 'NO'
        end) as is_current_salary
        
from
(select emp_name, dept_id, salary, lag(salary) over(partition by dept_id order by salary asc) as previous_salary,
    lead(salary) over(partition by dept_id order by salary asc) as next_salary
from employees)
as t; 

use practice_sql;
