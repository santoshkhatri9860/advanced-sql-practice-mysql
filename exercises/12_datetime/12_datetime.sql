/* MySQL (advanced_sql_practice) — add Date/Time practice columns + populate varied data
   Covers data variety needed for: year/month/day/weekday extraction, month-end, “truncate”, add/diff,
   casting/formatting, and date-validation practice using date_text strings. */

/* Practice Question 1 (only 1 question)
From Employees, show: emp_id, emp_name, hire_date, plus:
hire year (number)
hire month number
hire weekday name
Sort so the newest hire_date appears first.
*/

/* From Employees, show:
emp_id
emp_name
hire_date
weekday name of hire_date
month name of hire_date
Sort so the newest hire_date appears first. */

/*Practice Question 2 (only 1 question)
For each employee, show:
emp_id
emp_name
hire_date
a column that shows the date exactly 30 days after hire_date
Sort by emp_id ascending.
*/

/*For each employee, display:
emp_id
emp_name
hire_date
number of days since hire_date (up to today)
Sort by the number of days (highest first).*/

/*From Employees, show:
emp_id
emp_name
last_login_ts
hour of last_login_ts
Sort by last_login_ts from newest to oldest. */

/*For each employee, show:
emp_id
emp_name
last_login_ts
number of hours since last_login_ts (up to now)
Sort by the number of hours (largest first).*/

/*From Employees, show:
emp_id
emp_name
last_promo_date
number of days since last_promo_date
If last_promo_date is NULL, show NULL (not 0)
Sort by days since promotion, largest first.*/

/*From Employees, display:
emp_id
emp_name
last_promo_date
number of months since last_promo_date
If last_promo_date is NULL, the result must remain NULL
Sort by months since promotion (largest first).*/

