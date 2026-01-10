

INSERT INTO Employees VALUES
(108, 'Helen', 1, 4500),
(109, 'Ian', 1, 5000),
(110, 'Julia', 1, 5200),
(111, 'Karl', 1, 4500),

(112, 'Leo', 2, 7200),
(113, 'Mia', 2, 7000),
(114, 'Noah', 2, 6800),
(115, 'Olivia', 2, 8000),

(116, 'Paul', 3, 6500),
(117, 'Quinn', 3, 6100),
(118, 'Rita', 3, 6000),
(119, 'Sam', 3, 7000),

(120, 'Tina', 4, 4200),
(121, 'Uma', 4, 4500),
(122, 'Victor', 4, 4700),
(123, 'Wendy', 4, 4000);

INSERT INTO Employees VALUES
(124, 'Xavier', 1, 5200),
(125, 'Yara',   1, 4800),
(126, 'Zane',   1, 4500);  

INSERT INTO Employees VALUES
(127, 'Abel',    2, 7900),
(128, 'Bella',   2, 7200),  
(129, 'Cody',    2, 6600),
(130, 'Daisy',   2, 8000),  
(131, 'Ethan',   2, 7000);   

INSERT INTO Employees VALUES
(132, 'Farah',   3, 7200),
(133, 'Gwen',    3, 6500),  
(134, 'Hank',    3, 5900),
(135, 'Isla',    3, 7000),   
(136, 'Jonas',   3, 6100);  

INSERT INTO Employees VALUES
(137, 'Kiara',   4, 4600),
(138, 'Liam',    4, 4700),   
(139, 'Mona',    4, 4300),
(140, 'Nate',    4, 4800),
(141, 'Opal',    4, 5000);   

INSERT INTO Employees VALUES
(142, 'Perry',   1, 4600),
(143, ' Quinn',  1, 5100);

INSERT INTO Employees VALUES
(144, 'Ralph',   2, 8100),
(145, 'Sophie',  2, 7700);

INSERT INTO Employees VALUES
(146, 'Terry',   3, 5800),
(147, 'Umair',   3, 6500);

INSERT INTO Employees VALUES
(148, 'Pia',     4, 5100),
(149, 'Ravi',    4, 3900);

ALTER TABLE Employees
ADD COLUMN manager_id INT NULL;
UPDATE Employees
SET manager_id = NULL
WHERE emp_id IN (108, 115, 119, 141);
UPDATE Employees SET manager_id = 108 WHERE dept_id = 1 AND emp_id NOT IN (108);
UPDATE Employees SET manager_id = 109 WHERE emp_id IN (110,111,124,125,126,142,143);
UPDATE Employees SET manager_id = 115 WHERE dept_id = 2 AND emp_id NOT IN (115);
UPDATE Employees SET manager_id = 113 WHERE emp_id IN (112,114,127,128,129,131);
UPDATE Employees SET manager_id = 115 WHERE emp_id IN (130,144,145);
UPDATE Employees SET manager_id = 119 WHERE dept_id = 3 AND emp_id NOT IN (119);
UPDATE Employees SET manager_id = 116 WHERE emp_id IN (117,118,132,133,134,136,146,147);
UPDATE Employees SET manager_id = 119 WHERE emp_id IN (135);
UPDATE Employees SET manager_id = 141 WHERE dept_id = 4 AND emp_id NOT IN (141);
UPDATE Employees SET manager_id = 137 WHERE emp_id IN (120,121,122,123,139,140,148,149);
UPDATE Employees SET manager_id = 141 WHERE emp_id IN (138);
INSERT INTO Employees (emp_id, emp_name, dept_id, salary, manager_id) VALUES
(150, 'Asha',   2, 6900, 113),
(151, 'Biren',  2, 6400, 129),
(152, 'Chitra', 3, 6050, 116),
(153, 'Deepak', 1, 4700, 110),
(154, 'Eli',    4, 4550, 137);












/* Using a subquery, find the highest-paid employee(s)
*/
use practice_sql;
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
where exists (
select dept_id 
from departments
);



/*
Keep employees whose department exists in Departments table.
*/
use practice_sql;
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

/*
Display employee name, salary,
and a running total of salary across ALL employees,
ordered by salary ascending.
*/

select emp_name, salary, sum(salary) over(order by salary) as total_salary
from employees;


/* For each employee, display:
emp_name
dept_id
salary
running total of salary within their department,
ordered from smallest salary to largest inside each department
*/

select emp_name, dept_id, salary, sum(salary) over(partition by dept_id order by salary asc) as detailed_salary
from employees;

/* Question (Aggregate Window – COUNT, single concept)
For each employee, show:
emp_name
dept_id
salary
the number of employees in that employee’s department
*/

select emp_name, dept_id, salary, count(emp_id) over(partition by dept_id) as total_employees
from employees;


/*
Display each employee’s name, department, salary,
and the highest salary in their department using a window function.
*/
select emp_name, dept_id, salary, max(salary) over(partition by dept_id) as highest_salary
from employees;

/*
Display emp_name, dept_id, salary
and the lowest salary in their department using a window function.
*/

select emp_name, dept_id, salary, min(salary) over(partition by dept_id) as lowest_salary
from employees;

/*
Q4 (Evaluation — Aggregate Window + Comparison Logic)

Show emp_name, salary, dept_id
for employees whose salary
is greater than the average salary of their department,
using window functions (not subqueries for avg).
*/
use practice_sql;

select emp_name, salary, dept_id, avg(salary) over(partition by dept_id)  as average_salary
from employees;


select * 
from (
select emp_name, salary, dept_id, avg(salary) over(partition by dept_id)  as average_salary
from employees) as t
where t.salary < t.average_salary  ;

/*
Show emp_name, dept_id, salary
where salary < dept_max_salary
using window functions (not subqueries)
*/

select *
from (
select emp_name, dept_id, salary, max(salary) over(partition by dept_id) as highest_salary
from employees) as sub
where sub.salary < sub.highest_salary;

/*
Show employees whose salary is above the average salary of their department
using window functions only (no subqueries, no WHERE on window directly — use two-layer logic)
*/

select emp_name
from (select emp_name,salary, avg(salary) over(partition by dept_id) as average_salary
	from employees) as a
where a.salary > a.average_salary;


/*
Show employees whose salary
is between
the minimum and maximum salary
of their department,
using window functions — no GROUP BY, no subqueries.
*/
select *
from 
(select emp_name, salary, dept_id, min(salary) over(partition by dept_id)  as min_salary,
max(salary) over(partition by dept_id) as max_salary 
from employees) as a
where a.salary > a.min_salary and  a.salary < a.max_salary;

/* 
Using window functions, show each employee’s
salary, dept_id,
department min salary,
department average salary,
and keep only those employees whose salary is greater than the department average salary.
*/

select *
from (
select
	emp_name,
	salary, 
	dept_id, 
    min(salary) over (partition by dept_id) as min_salary,
	avg(salary) over (partition by dept_id) as avg_salary
from employees) as a
where a.salary > a.avg_salary;

/* Show employees whose salary is LESS THAN the MINIMUM salary of ANOTHER department (Finance) */

select *
from (
select e.emp_name, e.dept_id , e.salary, d.dept_name, MIN(CASE WHEN dept_name = 'Finance' THEN salary END)
OVER () as finance_min_salary
		from employees e
        join departments d
        on e.dept_id = d.dept_id 
) as b
where b.salary < b.finance_min_salary ;

/* For each employee, compute:
department average salary
global minimum salary
global maximum salary
Then show only employees whose salary is:
✔ greater than their department average
AND
✔ between global_min and global_max (which will always be true except for learning)
*/

select *
from (select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dept_avg, min(salary) over() as global_min,
max(salary) over() as global_max
from employees ) as b
where b.salary > b.dept_avg and (b.salary between b.global_min and b.global_max)
;

/*
For each employee, show:
emp_name
salary
dept_id
the difference between their salary and the department minimum salary
*/

select *
from (select emp_name, salary, dept_id, (salary- min(salary) over(partition by dept_id)) as difference
from employees) as b;

/* For each employee, show:
emp_name
salary
running_total_salary
Running total should accumulate salaries in ascending order of salary.
*/
select emp_name, salary, sum(salary) over(order by salary asc) as running_total_salary
from employees;


/*
For each employee, show:
emp_name
salary
running_min_salary
Running minimum should use salary ORDER BY salary ASC.
*/
select emp_name, salary, min(salary) over(order by salary asc) as running_min_salary
from employees;


/* For each employee, display:
emp_name
salary
running_max_salary
*/
select emp_name, salary, max(salary) over (order by salary asc) as running_max_salary
from employees;

/* List employees with:
emp_name
salary
running_avg_salary (average salary so far)
Based on ascending salary order.
*/
select emp_name, salary, avg(salary) over (order by salary asc) as running_avg_salary
from employees;

/* For each employee, show
emp_name
salary
running_total_salary
using this window frame:
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/
select emp_name, salary, sum(salary) over(order by salary rows between unbounded preceding and current row) as running_total_salary
from employees;

/* For each employee, calculate the 3-row moving sum of salary,
ordered by salary ascending.
*/

select emp_name, salary, sum(salary) over(order by salary asc rows between 2 preceding and current row) as moving_sum
from employees;

/* Calculate the 3-row moving average of salary
in ascending salary order.
*/
select emp_name, salary, avg(salary) over(order by salary asc rows between 2 preceding and current row) as moving_avg
from employees;

/* Show:
emp_name
salary
sum_current_row
*/
select emp_name, salary, sum(salary) over(order by salary asc rows between current row and current row) as sum_current_row
from employees;

/* For each employee, compute:
emp_name
salary
forward_sum_salary
*/
select emp_name, salary, sum(salary) over(order by salary asc rows between current row and 2 following) as forward_sum_salary
from employees;

/*
For each employee, compute the 3-row centered moving average
(previous row, current row, next row)
ordered by salary ascending
*/
select emp_name, salary, avg(salary) over(order by salary asc rows between 1 preceding and 1 following) as centered_moving 
from employees;

/* (1 PRECEDING to 1 FOLLOWING)
compute the centered moving MINIMUM salary
ordered by salary ascending.
*/
select emp_name, salary, min(salary) over(order by salary asc rows between 1 preceding and 1 following) as mini_salary
from employees;

/* Compute the centered moving MAXIMUM salary.
Output columns:
emp_name
salary
centered_max_salary
Ordered by salary ASC.
*/
select emp_name, salary, max(salary) over(order by salary asc rows between 1 preceding and 1 following) as centered_max_salary
from employees;

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
/* Assign row numbers to employees ordered by salary ascending.
Output:
emp_name
salary
row_number_by_salary
*/
select
	emp_name, salary, row_number() over(order by salary asc) as row_number_by_salary
from employees;

/* Assign row numbers within each department, ordered by salary ascending.
Output:
emp_name
dept_id
salary
row_number_in_dept
*/
select 
emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary asc) as row_numbwr_in_dept
from employees; 

/* Using ROW_NUMBER(), return only the lowest salary employee per department.
Output:
emp_name
dept_id
salary
*/
select emp_name, dept_id, salary 
from (select emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary asc) as t
from employees) as b
where b.t =  1;

/* Find the HIGHEST-paid employee per department using ROW_NUMBER().
Output:
emp_name
dept_id
salary
*/
select emp_name, dept_id, salary
from (select emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary desc) as t
from employees) as b
where b.t= 1;


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
select emp_name, dept_id, salary
from (select emp_name, dept_id, salary, row_number() over(partition by dept_id order by salary desc) as b
from employees ) e
where e.b = 2;

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

use practice_sql;

select  emp_name, dept_id, salary, avg_salary, row_number() over(partition by dept_id order by salary desc) as row_num_above_avg
from(
select  emp_name, dept_id, salary, avg_salary
from 
(select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as avg_salary from employees) as e
where salary > e.avg_salary) as t ;

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
select emp_name, dept_id, salary, dpt_avg
from(
 select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dpt_avg
 from employees) as e
 where salary < e.dpt_avg;


/*
For each department, list employees whose salary is ABOVE the department average, and also show how much their salary exceeds the average.
Output:
emp_name
dept_id
salary
dept_avg
difference (salary – dept_avg)
*/
select emp_name, dept_id, salary, dept_avg, abs(salary-dept_avg) as difference
from
(select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dept_avg
from employees) as e
where salary > e.dept_avg;


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
select emp_name,dept_id, salary, dept_avg,dept_min, dept_max, abs(salary- dept_min) as salary_minus_min, abs(dept_max-salary) as max_minus_salary
from(
select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dept_avg, 
min(salary) over(partition by dept_id) as dept_min,
max(salary) over(partition by dept_id) as dept_max
from employees) as e 
where salary > e.dept_avg;


/* For each department, list employees whose salary is BELOW the department MAX salary but ABOVE the department MIN salary (i.e., strictly in the middle). Also show:
dept_min
dept_max
difference_from_min
difference_from_max
difference_from_avg
Columns required in output:
| emp_name | dept_id | salary | dept_min | dept_max | dept_avg | diff_from_min | diff_from_max | diff_from_avg |
*/
select emp_name, dept_id, salary, dept_min, dept_max, dept_avg, abs(salary-dept_min) as diff_from_min, abs(dept_max - salary) as diff_from_max, abs(salary-dept_avg) as diff_from_avg
from(select emp_name, dept_id, salary, 
		min(salary) over(partition by dept_id) as dept_min,
        max(salary) over(partition by dept_id) as dept_max,
        avg(salary) over(partition by dept_id) as dept_avg
from employees) as e
where salary < e.dept_max and salary > e.dept_min;

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

select emp_name, dept_id, salary, dept_avg, row_number() over(partition by dept_id order by salary desc) as row_number_above_avg
from (
select emp_name, dept_id, salary, dept_avg
from(
select emp_name, dept_id, salary, avg(salary) over(partition by dept_id) as dept_avg
from employees) as e
where salary > e.dept_avg) as t;

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
select *
from(
select emp_name, dept_id, salary, dept_avg, row_number() over(partition by dept_id order by salary desc) as ranks
from (
select emp_name, dept_id, salary, dept_avg
from
(select emp_name, dept_id, salary, avg(salary) over (partition by dept_id) as dept_avg
from employees) as e
where salary > e.dept_avg) as t) as s
where s.ranks <=2;

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

select *
from(
select emp_name, dept_id, salary, dept_max, rank_below_max
from( 
select emp_name, dept_id, salary, dept_max, row_number() over(partition by dept_id order by salary desc) as rank_below_max
from (
select emp_name, dept_id, salary, max(salary) over(partition by dept_id) as dept_max
from employees) as e
where salary < e.dept_max) as b) as ranks
where ranks.rank_below_max <= 3;

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
select *
from(
select emp_name, dept_id, salary, dept_min, dept_max, rank_middle
from(
select emp_name, dept_id, salary, dept_min, dept_max, row_number() over(partition by dept_id order by salary desc) as rank_middle
from
(select emp_name, dept_id, salary, min(salary) over(partition by dept_id) as dept_min, max(salary) over(partition by dept_id) as dept_max
from employees) as e
where salary > e.dept_min and salary < e.dept_max) as b) as c
where c.rank_middle <= 2;


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
use practice_sql;

select emp_name, dept_id, salary, dense_rank_salary
from(select emp_name, dept_id, salary, dense_rank() over(partition by dept_id order by salary desc) as dense_rank_salary
from employees) as e
where e.dense_rank_salary <= 3

use practice_sql;

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


/* Recursive CTE 
Practice Question R1 (mechanics only, no tables)
Problem: Generate a sequence of integers starting at 1 and ending at 10 using a recursive CTE.
Output: one column named num with values 1 through 10 (each number on its own row).
*/
with recursive numbers as
(
select 1 as num
union all
select num+1 from numbers
where num < 10
)
select num from numbers;

/*Practice Question R2 (Still basic)
Problem:
Generate salary levels starting at 4000, increasing by 500 each step, and stop once the value exceeds 6000.
*/
with recursive amount as
(
select 4000 as salary
union all
select salary+500
from amount
where salary < 6000
)
select salary from amount;

/*
Practice Question R3 (Recursive + CTE output usage):
Problem:
Using a recursive CTE, generate numbers from 1 to 5, and in the final SELECT, also show the square of each number.
*/

with recursive numbers as
(
select 1 as num
union all
select num+1
from numbers
where num < 5
)
select
	num, pow(num,2)
from numbers;


/*Practice Question R4 (Recursive + Derived Value)
Problem:
Using a recursive CTE, generate a sequence that starts at 2 and keeps doubling each time, stopping once the value exceeds 64.
*/
with recursive sequence as
(
select 2 as num
union all
select num*2
from sequence
where num < 64
)
select num
from sequence;


/*
Practice Question R5 (Recursive + Counter):
Using a recursive CTE, generate numbers from 1 to 5, and also show a step number that counts 
how many iterations were used to reach each value.
*/

with recursive numbers as
(
select 1 as num, 1 as step
union all
select num+1, step+1
from numbers
where num < 5
)
select num, step
from numbers;

/*Next (R6 — last numbers reinforcement, still basic but very useful):
Problem: Generate numbers from 1 to 10 using a recursive CTE, and also show a running total (cumulative sum) of those numbers.
Output columns: num, running_total
Example idea: at num=4, running_total should be 1+2+3+4 = 10.
*/
with recursive numbers as
(
select 1 as num, 1 as running_total
union all
select num+1, running_total + num+1
from numbers
where num < 10
)
select num, running_total
from numbers;


/*Task:
Generate numbers from 1 to 5 and show num and double_num where double_num = num * 2.
I’ll guide you:
Anchor: num=1, double_num=2
Recursive step: num increases by 1, double_num increases accordingly
Stop at 5
*/
with recursive numbers as
(
select 1 as num, 2 as double_num
union all
select num+1, (num+1)*2
from numbers
where num < 5
)
select num, double_num
from numbers;

/*Next (R7 — still basic, same pattern, one new twist):
Problem: Generate numbers from 1 to 6, and show whether each number is odd or even as a column 
named parity with values 'Odd' or 'Even'.
Output columns: num, parity
*/
with recursive numbers as
(
select 1 as num
union all
select num+1
from numbers
where num < 6
)
select
	num,
    case 
    when num %2 = 1 then 'odd'
    when num%2 = 0 then 'even'
    end as parity
from numbers;


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


with recursive seniority as
(
select 
	1 as hier_level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from employees
where dept_id = 1 and manager_id is null
union all
select
	hier_level+1,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    e.dept_id
from employees e
join seniority s
on e.manager_id = s.emp_id
where e.dept_id = 1
)
select
	hier_level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from seniority;

/*Next (Recursive Hierarchy Q3 — still Employees only, still simple):
Problem: For dept_id = 1, return only employees at the deepest level of the hierarchy 
(if multiple employees are tied for deepest, include all).
Output: hier, emp_id, emp_name, manager_id, dept_id
*/
with recursive seniority as
(
select 
	1 as level,
    emp_id,
    emp_name,
    manager_id,
    dept_id
from employees 
where dept_id = 1 and manager_id is null
union all
select
	s.level +1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    e.dept_id
from employees e
join seniority s
on e.manager_id = s.emp_id
where e.dept_id = 1
),
max_level as(
select max(level)as deepest_level
from seniority
)

select
	s.level,
    s.emp_id,
    s.emp_name,
    s.manager_id,
    s.dept_id
from seniority s
cross join max_level m
where s.level = m.deepest_level
order by s.emp_id;



/*Recursive Hierarchy Question 4 (Employees only)
Problem:
For dept_id = 1, list each employee along with the total number of people who report to them
(include both direct and indirect reports).
Output columns:
emp_id
emp_name
total_reports
*/
WITH RECURSIVE hierarchy AS (
  SELECT
    emp_id,
    emp_name,
    manager_id,
    1 AS level
  FROM employees
  WHERE dept_id = 1 AND manager_id IS NULL

  UNION ALL

  SELECT
    e.emp_id,
    e.emp_name,
    e.manager_id,
    h.level + 1
  FROM employees e
  JOIN hierarchy h
    ON e.manager_id = h.emp_id
  WHERE e.dept_id = 1
),
report_counts AS (
  SELECT
    a.emp_id AS manager_emp_id,
    COUNT(b.emp_id) AS total_reports
  FROM hierarchy a
  JOIN hierarchy b
    ON a.level < b.level
  GROUP BY a.emp_id
)
SELECT
  e.emp_id,
  e.emp_name,
  COALESCE(r.total_reports, 0) AS total_reports
FROM employees e
LEFT JOIN report_counts r
  ON e.emp_id = r.manager_emp_id
WHERE e.dept_id = 1
ORDER BY e.emp_id;

/*
Multi-CTE Reinforcement — Exercise 1 (Very Controlled)
Big picture (don’t solve yet)
We want this final result:
For each department, show how many employees earn more than the department’s average salary.
*/
with dept_average as
(
select
	dept_id,
    round(avg(salary),2) as average
from employees
group by dept_id
), 
 employees_count as
(select 
	e.emp_id,
    e.dept_id,
    e.salary,
    d.average
from employees e
join dept_average d
on e.dept_id = d.dept_id
where e.salary > d.average
),
dept_counts as (

select 
	dept_id,
	count(emp_id) as total_employees
from employees_count
group by dept_id
)
select
	d.dept_id,
    coalesce(c.total_employees,0) as total_employees
from Departments d
left join dept_counts c
on d.dept_id = c.dept_id
order by d.dept_id;

/* Problem
For each department, show:
dept_id
total number of employees
Requirement:
Departments with no employees must show 0 */

with emp_number as
(
select
	dept_id,
    count(emp_id) as total_employees
from employees
group by dept_id
)
select *, coalesce(n.total_employees,0) as total_employees
from departments d
left join  emp_number n 
on d.dept_id = n.dept_id;

/*Problem
For each department, show:
dept_id
total salary paid in that department
Requirement:
Departments with no employees must show 0 total salary. */
with salary_per_dept as
(
select
	dept_id,
    sum(salary) as total_salary
from employees
group by dept_id
)
select
	d.dept_id,
	d.dept_name,
    coalesce(s.total_salary,0) as total_salary
from departments d
left join salary_per_dept s
on d.dept_id = s.dept_id;

/* Practice #4
Problem
For each department, show:
dept_id
highest_salary in that department
Requirement
Departments with no employees must show 0 */
with highest_salary as
(
select
	dept_id,
    max(salary) as max_salary
from employees
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(h.max_salary,0) as max_salary
from departments d
left join highest_salary h
on d.dept_id = h.dept_id;

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
with company_salary as
(
select
	round(avg(salary),2) as avg_salary
from employees
),
above_company_average as
(
select
	e.emp_id,
    e.dept_id
from employees e
cross join company_salary s 
where e.salary > s.avg_salary
),
employees_count as
(
select
	dept_id,
    count(a.emp_id) as total_employees
from above_company_average a
group by dept_id	
)

select 
	d.dept_id,
    d.dept_name,
    coalesce(c.total_employees,0) as employee_count_above_company_average
from departments d
left join employees_count c
on d.dept_id = c.dept_id

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

with dept_avg_salary as
(
select
	dept_id,
    round(avg(salary),2) as avg_salary
from employees
group by dept_id
),
employees_above_average as
(
select
	e.emp_id,
    e.dept_id,
    e.salary as above_average
from employees e
join dept_avg_salary d
on e.dept_id = d.dept_id
where e.salary > d.avg_salary
),
avg_salary_above_dept as
(
select
	dept_id,
	round(avg(a.above_average),2) as avg_salary_above_dept_avg
from employees_above_average a
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(b.avg_salary_above_dept_avg,0) as avg_salary_above_dept_avg
from departments d
left join avg_salary_above_dept b
on d.dept_id = b.dept_id;

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
with dept_average as
(
select 
	dept_id,
    round(avg(salary),2) as avg_salary
from employees
group by dept_id
),
above_average as
(
select 
	e.emp_id,
    e.dept_id,
    e.salary
from employees e
join dept_average a
on e.dept_id = a.dept_id
where e.salary > a.avg_salary
),
dept_total_salary as
(
select
	dept_id,
    sum(salary) as total_salary
from above_average
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(s.total_salary, 0) as total_salary_above_dept_avg
from departments d
left join dept_total_salary s 
on d.dept_id = s.dept_id;

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
with company_avg as
(
select 
	round(avg(salary),2) as avg_company
from employees
),
dept_avg as
(
select
	dept_id,
    round(avg(salary),2) as avg_dept
from employees 
group by dept_id
),
above_average as 
(
select
	e.emp_id,
    e.dept_id,
    e.salary,
    c.avg_company,
    d.avg_dept
from employees e
cross join company_avg c
join dept_avg d
on e.dept_id = d.dept_id
where e.salary > c.avg_company and e.salary > d.avg_dept
),
qualified_employees as
(
select
	dept_id,
    count(emp_id) as qualify_emp
from above_average
group by dept_id
)
select
	d.dept_id,
    d.dept_name,
    coalesce(q.qualify_emp,0) as employee_count_above_company_avg_and_dept_avg
from departments d
left join qualified_employees q
on d.dept_id = q.dept_id;


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
with recursive managing_details as
(
select 
	emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_details m 
on e.manager_id = m.emp_id
)
select 
	emp_id,
    emp_name,
    manager_id
from managing_details;

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
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	level,
    emp_id,
    emp_name,
    manager_id
from managing_levels
where level >= 3;

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
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	level,
    count(emp_id) as no_of_employees
from managing_levels
group by level;

/*
Your task
Write a query that returns:
the maximum hierarchy level
*/
with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join managing_levels m
on e.manager_id = m.emp_id
)
select
	max(level) as max_depth
from managing_levels;


/*Problem
Using the employee hierarchy you have already built with a recursive CTE:
For each employee, determine how many total reports they have.
expected Output (conceptual)
Each row should represent one employee, showing:
employee identifier
employee name
total number of reports
*/

with recursive managing_levels as 
(
select
	1 as level,
    emp_id,
    emp_name,
    manager_id,
    emp_id as root_id
from employees
where manager_id is null
union all
select
	level+1 as level,
    e.emp_id,
    e.emp_name,
    e.manager_id,
    m.root_id 
from employees e
join managing_levels m
on e.manager_id = m.emp_id
),
reports_count AS (
select
	a.emp_id,
    count(b.emp_id) as total_reports
from managing_levels a
left join managing_levels b
on a.root_id = b.root_id and a.level < b.level
group by a.emp_id
)

SELECT
    e.emp_id,
    e.emp_name,
    COALESCE(r.total_reports, 0) AS total_reports
FROM employees e
LEFT JOIN reports_count r
    ON e.emp_id = r.emp_id
ORDER BY e.emp_id;

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
with recursive cte as 
(
select
	emp_id,
    emp_name,
    manager_id
from employees
where manager_id is null
union all
select
	e.emp_id,
    e.emp_name,
    e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id,emp_name, manager_id
from cte;

/*Recursive CTE — Question 2 (Still BASIC, One New Concept)
Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy 
and show how deep each employee is in the hierarchy.
*/

with recursive cte as
(
select emp_id, emp_name, manager_id, 1 as level
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, level+1
from employees e
join cte c
on e.manager_id= c.emp_id
)
select emp_id, emp_name, manager_id, level
from cte;

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee also show who the top-level manager is.
*/
with recursive cte as
(
select emp_id, emp_name, manager_id, emp_id as top_manager_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, c.top_manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, top_manager_id
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a top-level employee or not.
*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id, 
    case
		when manager_id is null then 'yes' else 'no' end as is_top_employee
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id,  'no' as is_top_employee
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, is_top_employee
from cte ;

/*Using the Employees table:

Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a leaf employee or not.
*/

with recursive cte as 
(
select emp_id, emp_name, manager_id 	
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select emp_id, emp_name, manager_id, 
	case
		when emp_id in (select manager_id from cte ) then 'no' 
        else 'yes' 
	end as is_leaf_employee
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they are a manager or not.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select 
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id, emp_name, manager_id,
    case
		when emp_id in (select manager_id from cte) then 'yes'
        else 'no' 
	end as is_manager
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy, 
and for each employee indicate whether they report to someone or not.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	emp_id, emp_name, manager_id,
    case
		when manager_id in (select emp_id from cte) then 'yes'
        else 'no'
	end as reports_to_someone
from cte;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many direct reports they have. */
with recursive cte as
(
select 
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select a.emp_id, a.emp_name, count(b.emp_id) as direct_report_count
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, show how many employees report directly to them.*/

with  recursive cte as
(
select
	emp_id, emp_name, manager_id
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as emp_report_count
from cte a
left join cte b 
on b.manager_id = a.emp_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the total salary of their direct reports.
*/
with recursive cte as
(
select 
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name,  sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, determine the highest salary among their direct reports.*/
with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name, max(b.salary) as max_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate the average salary of their direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name, avg(b.salary) as avg_salary
from cte a
left join cte b
on a.emp_id = b.manager_id 
group by a.emp_id, a.emp_name;

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the average salary of those direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select
	a.emp_id, a.emp_name,
    count(b.emp_id) as direct_reporters,
    avg(b.salary) as avg_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as total_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who have at least one direct report. */

with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as total_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name
having total_reporters >= 1;

/* Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, for each employee, calculate:
the number of direct reports, and
the total salary of those direct reports.
Finally, show only those employees who:
have at least 2 direct reports, AND
whose total direct-report salary is greater than 10,000. */
with recursive cte as
(
select
	emp_id, emp_name, manager_id, salary
from employees 
where manager_id is null
union all
select
	e.emp_id, e.emp_name, e.manager_id, e.salary
from employees e
join cte c 
on e.manager_id = c.emp_id
)
select 
	a.emp_id, a.emp_name,
    count(b.emp_id) as direct_reporters,
    sum(b.salary) as total_salary
from cte a
left join cte b
on a.emp_id = b.manager_id
group by a.emp_id, a.emp_name
having direct_reporters >=2 and total_salary > 10000;


/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees in that department, and
the total salary of employees in that department. */
with recursive cte as
(
select emp_id, emp_name, manager_id, dept_id, salary
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.dept_id, e.salary
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
		count(emp_id) as total_employees,
        sum(salary) as total_salary
from cte
group by dept_id;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the average salary of employees in that department, and
the maximum salary in that department.*/
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
	avg(salary) as avg_salary,
    max(salary) as max_salary
from cte
group by dept_id;

/*Problem
Using the Employees table:
Starting from employees who do not have a manager, recursively find all employees in the reporting hierarchy.
Then, group the results by department, and for each department calculate:
the total number of employees, and
the average salary in that department.
Finally, show only those departments where:
the employee count is at least 5, AND
the average salary is greater than 6,000.*/
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
)
select dept_id,
		count(emp_id) as total_employees,
        avg(salary) as avg_salary
from cte
group by dept_id
having total_employees >= 5 and avg_salary > 6000;

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
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as (
select dept_id,
		count(emp_id) as total_employees,
        avg(salary) as avg_salary
from cte a
group by dept_id
)
select d.dept_id, d.dept_name, 
	case when a.total_employees is null then 0 else a.total_employees end as  total_employees,
    case when a.avg_salary is null then 0 else a.avg_salary end as avg_salary
from departments d
left join cte2 a
on d.dept_id = a.dept_id;

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
with recursive cte as
(
select emp_id, emp_name, manager_id, salary, dept_id
from employees 
where manager_id is null
union all
select e.emp_id, e.emp_name, e.manager_id, e.salary, e.dept_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as 
(
select dept_id,
	count(emp_id) as total_employees,
    avg(salary) as avg_salary
from cte
group by dept_id
), cte3 as 
(
select x.dept_id,
		count(x.emp_id) as employees_above_dept_avg 
from cte x
join cte2 y
on x.dept_id = y.dept_id
where x.salary > y.avg_salary
group by x.dept_id
)
SELECT
    d.dept_id,
    d.dept_name,
    COALESCE(a.total_employees, 0) AS employee_count,
    COALESCE(a.avg_salary, 0) AS avg_department_salary,
    COALESCE(b.employees_above_dept_avg, 0) AS employees_above_dept_avg
from departments d
left join cte2 a
on d.dept_id = a.dept_id
left join cte3 b 
on d.dept_id = b.dept_id;

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
with recursive cte as
(
select emp_id, emp_name, dept_id, salary, manager_id
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary, e.manager_id
from employees e
join cte c
on e.manager_id = c.emp_id
), cte2 as
(
select dept_id, 
		count(emp_id) as total_employees,
        max(salary) as max_salary
from cte
group by dept_id
), cte3 as
(
select a.dept_id, count(emp_id) as dept_total_employees
from cte a
join cte2 b 
on a.dept_id =b.dept_id
where a.salary = b.max_salary
group by a.dept_id
)
select
	d.dept_id, d.dept_name, 
	coalesce (w.total_employees, 0) as total_employees,
    coalesce(w.max_salary, 0) as max_salary,
    coalesce(x.dept_total_employees,0) as dept_total_employees
from departments d
left join cte2 w
on d.dept_id = w.dept_id
left join cte3 x
on d.dept_id = x.dept_id;

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
with recursive hierarchy as
(
select *
from employees
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary , e.manager_id
from employees e
join hierarchy h
on e.manager_id = h.emp_id
), dept_wise as
(
select dept_id,
		count(emp_id) as total_employees,
        min(salary) as min_salary
from hierarchy
group by dept_id
), above_min as 
(
select a.dept_id,
		count(emp_id) as above_dept_min_salary
from hierarchy a
join dept_wise w
on a.dept_id = w.dept_id
where a.salary > w.min_salary
group by a.dept_id
)
select 
	d.dept_id, d.dept_name, 
    coalesce(c.total_employees,0) as total_employees,
    coalesce(c.min_salary,0) as min_salary,
    coalesce(f.above_dept_min_salary,0) as above_dept_min_salary
from departments d
left join dept_wise c
on d.dept_id = c.dept_id
left join above_min f
on d.dept_id = f.dept_id;

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
with recursive hier as
(
select emp_id, emp_name, dept_id, salary, manager_id
from employees 
where manager_id is null
union all
select e.emp_id, e.emp_name, e.dept_id, e.salary, e.manager_id
from employees e
join hier h 
on e.manager_id = h.emp_id
), dept_wise_detail as 
(
select dept_id, count(emp_id) as total_employees, avg(salary) as avg_salary, min(salary) as min_salary, max(salary) as max_salary
from hier
group by dept_id 
), no_of_between_salary as
(
select a.dept_id, count(emp_id) as middle_salary_employees 
from hier a
join dept_wise_detail b
on a.dept_id= b.dept_id
where salary > b.min_salary and salary < b.max_salary 
group by a.dept_id
)
select 
	d.dept_id, d.dept_name,
    coalesce(c.total_employees,0) as total_employees,
    coalesce(c.avg_salary,0) as avg_salary,
    coalesce(f.middle_salary_employees,0) as middle_salary_employees
from departments d
left join dept_wise_detail c
on d.dept_id = c.dept_id
left join no_of_between_salary f
on d.dept_id = f.dept_id;

USE practice_sql;
SHOW COLUMNS FROM Employees;




/* MySQL (practice_sql) — add Date/Time practice columns + populate varied data
   Covers data variety needed for: year/month/day/weekday extraction, month-end, “truncate”, add/diff,
   casting/formatting, and date-validation practice using date_text strings. */

USE practice_sql;

-- 1) Add columns
ALTER TABLE Employees
  ADD COLUMN hire_date DATE NULL,
  ADD COLUMN hire_ts DATETIME NULL,
  ADD COLUMN last_promo_date DATE NULL,
  ADD COLUMN last_login_ts DATETIME NULL,
  ADD COLUMN date_text VARCHAR(30) NULL,
  ADD COLUMN shift_start_time TIME NULL,
  ADD COLUMN shift_end_time TIME NULL;

-- 2) Populate ALL employees with deterministic variety
UPDATE Employees
SET
  hire_date = DATE_ADD('2022-01-01', INTERVAL (emp_id - 108) * 11 DAY),

  hire_ts = DATE_ADD(
            CONCAT(DATE_ADD('2022-01-01', INTERVAL (emp_id - 108) * 11 DAY), ' 00:00:00'),
            INTERVAL MOD(emp_id * 97, 86400) SECOND
          ),

  last_promo_date = CASE
                      WHEN MOD(emp_id, 6) = 0 THEN NULL
                      ELSE DATE_ADD('2023-01-15', INTERVAL MOD(emp_id, 18) MONTH)
                    END,

  last_login_ts = DATE_ADD(
                  DATE_ADD('2025-01-01 00:00:00', INTERVAL MOD(emp_id, 120) DAY),
                  INTERVAL MOD(emp_id * 13, 1440) MINUTE
                ),

  date_text = CASE MOD(emp_id, 10)
                WHEN 0 THEN '2024-02-29'    -- valid leap day
                WHEN 1 THEN '2024-02-30'    -- invalid day
                WHEN 2 THEN '2025-13-01'    -- invalid month
                WHEN 3 THEN '2023-12-31'    -- valid (month end)
                WHEN 4 THEN '2023-11-31'    -- invalid day
                WHEN 5 THEN '2024-01-31'    -- valid (month end)
                WHEN 6 THEN '2024-04-30'    -- valid (month end)
                WHEN 7 THEN 'not_a_date'    -- invalid text
                WHEN 8 THEN ''              -- empty string
                WHEN 9 THEN NULL            -- NULL
              END,

  shift_start_time = MAKETIME(8 + MOD(emp_id, 6), 0, 0),
  shift_end_time   = MAKETIME(16 + MOD(emp_id, 6), 0, 0);

-- 3) Targeted overrides to GUARANTEE tricky cases (month-ends, leap day, quarter ends, time edges)
UPDATE Employees
SET hire_date='2023-01-31', hire_ts='2023-01-31 23:59:59',
    last_promo_date='2023-02-28', last_login_ts='2025-01-31 00:00:01',
    date_text='2023-01-31'
WHERE emp_id=108;

UPDATE Employees
SET hire_date='2023-04-30', hire_ts='2023-04-30 00:00:00',
    last_promo_date=NULL, last_login_ts='2025-04-30 12:34:56',
    date_text='2023-04-30'
WHERE emp_id=115;

UPDATE Employees
SET hire_date='2024-02-29', hire_ts='2024-02-29 09:15:00',
    last_promo_date='2024-12-31', last_login_ts='2025-02-28 18:00:00',
    date_text='2024-02-29'
WHERE emp_id=119;

UPDATE Employees
SET hire_date='2024-12-31', hire_ts='2024-12-31 23:00:00',
    last_promo_date='2025-01-31', last_login_ts='2025-12-31 23:59:59',
    date_text='2024-12-31'
WHERE emp_id=141;

UPDATE Employees
SET hire_date='2025-03-31', hire_ts='2025-03-31 10:10:10',
    last_promo_date='2025-06-30', last_login_ts='2025-07-01 00:00:00',
    date_text='2025-03-31'
WHERE emp_id=150;

UPDATE Employees
SET hire_date='2025-06-30', hire_ts='2025-06-30 14:20:00',
    last_promo_date='2025-09-30', last_login_ts='2025-06-30 23:59:59',
    date_text='2025-06-30'
WHERE emp_id=151;

UPDATE Employees
SET hire_date='2025-09-30', hire_ts='2025-09-30 07:05:00',
    last_promo_date=NULL, last_login_ts='2025-10-01 00:00:01',
    date_text='2025-09-30'
WHERE emp_id=152;

UPDATE Employees
SET hire_date='2025-11-30', hire_ts='2025-11-30 16:45:00',
    last_promo_date='2025-12-31', last_login_ts='2025-11-30 08:00:00',
    date_text='2025-11-30'
WHERE emp_id=153;

UPDATE Employees
SET hire_date='2026-01-01', hire_ts='2026-01-01 00:00:00',
    last_promo_date=NULL, last_login_ts='2026-01-01 00:00:00',
    date_text='2026-01-01'
WHERE emp_id=154;

-- 4) Verify
SELECT emp_id, emp_name, dept_id, salary, manager_id,
       hire_date, hire_ts, last_promo_date, last_login_ts, date_text,
       shift_start_time, shift_end_time
FROM Employees
ORDER BY emp_id;

/* Practice Question 1 (only 1 question)
From Employees, show: emp_id, emp_name, hire_date, plus:
hire year (number)
hire month number
hire weekday name
Sort so the newest hire_date appears first.
*/

select emp_id, emp_name, hire_date, year(hire_date) as hire_year, month(hire_date) as hire_month, dayname(hire_date)
from employees
order by hire_date desc;

/* From Employees, show:
emp_id
emp_name
hire_date
weekday name of hire_date
month name of hire_date
Sort so the newest hire_date appears first. */
select emp_id, emp_name, hire_date, dayname(hire_date), monthname(hire_date)
from employees
order by hire_date desc;

/*Practice Question 2 (only 1 question)
For each employee, show:
emp_id
emp_name
hire_date
a column that shows the date exactly 30 days after hire_date
Sort by emp_id ascending.
*/
select emp_id, emp_name, hire_date, adddate(hire_date, 30)
from employees
order by emp_id asc;

/*For each employee, display:
emp_id
emp_name
hire_date
number of days since hire_date (up to today)
Sort by the number of days (highest first).*/
select emp_id, emp_name, hire_date, datediff(current_date, hire_date) as days_since
from employees
order by days_since desc;

/*From Employees, show:
emp_id
emp_name
last_login_ts
hour of last_login_ts
Sort by last_login_ts from newest to oldest. */

select emp_id, emp_name, last_login_ts, hour(last_login_ts) as hourtime
from employees
order by last_login_ts desc;

/*For each employee, show:
emp_id
emp_name
last_login_ts
number of hours since last_login_ts (up to now)
Sort by the number of hours (largest first).*/
select emp_id, emp_name, last_login_ts, timestampdiff( hour,last_login_ts, now()) as hourssince
from employees
order by hourssince desc;

/*From Employees, show:
emp_id
emp_name
last_promo_date
number of days since last_promo_date
If last_promo_date is NULL, show NULL (not 0)
Sort by days since promotion, largest first.*/
select emp_id, emp_name, last_promo_date, datediff(current_date, last_promo_date) as days_since_last_promo
from employees
order by days_since_last_promo desc;

/*From Employees, display:
emp_id
emp_name
last_promo_date
number of months since last_promo_date
If last_promo_date is NULL, the result must remain NULL
Sort by months since promotion (largest first).*/
select emp_id, emp_name, last_promo_date, timestampdiff(month, last_promo_date, now()) as no_of_months
from employees
order by no_of_months desc;


