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


