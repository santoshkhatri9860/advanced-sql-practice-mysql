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

/*
For each department, list
emp_name
dept_id
salary
rank of salary within the department (highest salary = rank 1)
using only RANK(), nothing else.
*/

/* For each department, list employees whose salary rank is 1 or 2 using RANK().
*/

/*
For each department, return all employees except those with salary rank = 1
(so exclude the highest-paid employees in every department).
*/

/*
For each department, show:
emp_name
dept_id
salary
salary_dense_rank
where salary_dense_rank is dense_rank of salary within each department (highest salary = 1).
*/

/* Show each employee’s
emp_name
dept_id
salary
dense rank of salary ACROSS the entire company, not per department.
*/

/*
For each department, list only those employees who have dense_rank = 1 or 2
(i.e., the top two salary groups, including ties).
*/

/* For each department, return ONLY employees whose salary is in the third highest salary group, based on DENSE_RANK.
*/

/* For each department, return:
emp_name
dept_id
salary
rank_salary
dense_rank_salary

 */

/*
For each department, return only the employees who earn the second-highest salary amount in that department.
*/

/*
For each department, return the employee who appears second when salaries are sorted in descending order, ignoring ties.
*/

/*
For each department, return all employees whose salary falls in the top 3 salary groups of that department.
(If there are ties within the top 3 groups, include them as well.)
*/

