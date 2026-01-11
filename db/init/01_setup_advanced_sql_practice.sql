/* =========================================================
   Advanced SQL Practice - Database Setup (MySQL)
   Database: advanced_sql_practice
   Purpose: create tables + load deterministic data
   NOTE: This script is designed for Docker init execution.
   ========================================================= */

-- Ensure correct database context
CREATE DATABASE IF NOT EXISTS advanced_sql_practice;
USE advanced_sql_practice;

-- ---------------------------------------------------------
-- 1) Tables
-- ---------------------------------------------------------

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
  dept_id   INT PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
  emp_id   INT PRIMARY KEY,
  emp_name VARCHAR(50) NOT NULL,
  dept_id  INT NOT NULL,
  salary   INT NOT NULL,
  manager_id INT NULL,
  hire_date DATE NULL,
  hire_ts DATETIME NULL,
  last_promo_date DATE NULL,
  last_login_ts DATETIME NULL,
  date_text VARCHAR(30) NULL,
  shift_start_time TIME NULL,
  shift_end_time TIME NULL,
  CONSTRAINT fk_employees_dept
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- ---------------------------------------------------------
-- 2) Seed Departments (required by your practice queries)
-- ---------------------------------------------------------
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

-- ---------------------------------------------------------
-- 3) Seed Employees (your original inserts)
-- ---------------------------------------------------------

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
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

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(124, 'Xavier', 1, 5200),
(125, 'Yara',   1, 4800),
(126, 'Zane',   1, 4500);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(127, 'Abel',    2, 7900),
(128, 'Bella',   2, 7200),
(129, 'Cody',    2, 6600),
(130, 'Daisy',   2, 8000),
(131, 'Ethan',   2, 7000);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(132, 'Farah',   3, 7200),
(133, 'Gwen',    3, 6500),
(134, 'Hank',    3, 5900),
(135, 'Isla',    3, 7000),
(136, 'Jonas',   3, 6100);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(137, 'Kiara',   4, 4600),
(138, 'Liam',    4, 4700),
(139, 'Mona',    4, 4300),
(140, 'Nate',    4, 4800),
(141, 'Opal',    4, 5000);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(142, 'Perry',   1, 4600),
(143, ' Quinn',  1, 5100);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(144, 'Ralph',   2, 8100),
(145, 'Sophie',  2, 7700);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(146, 'Terry',   3, 5800),
(147, 'Umair',   3, 6500);

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(148, 'Pia',     4, 5100),
(149, 'Ravi',    4, 3900);

-- ---------------------------------------------------------
-- 4) Manager hierarchy (your original ALTER + UPDATE logic)
-- ---------------------------------------------------------

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

-- ---------------------------------------------------------
-- 5) Date/Time practice columns + population (your original)
-- ---------------------------------------------------------

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
                WHEN 0 THEN '2024-02-29'
                WHEN 1 THEN '2024-02-30'
                WHEN 2 THEN '2025-13-01'
                WHEN 3 THEN '2023-12-31'
                WHEN 4 THEN '2023-11-31'
                WHEN 5 THEN '2024-01-31'
                WHEN 6 THEN '2024-04-30'
                WHEN 7 THEN 'not_a_date'
                WHEN 8 THEN ''
                WHEN 9 THEN NULL
              END,

  shift_start_time = MAKETIME(8 + MOD(emp_id, 6), 0, 0),
  shift_end_time   = MAKETIME(16 + MOD(emp_id, 6), 0, 0);

-- Targeted overrides (your original)
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

-- ---------------------------------------------------------
-- 6) Verify (your original verification SELECT)
-- ---------------------------------------------------------
SELECT emp_id, emp_name, dept_id, salary, manager_id,
       hire_date, hire_ts, last_promo_date, last_login_ts, date_text,
       shift_start_time, shift_end_time
FROM Employees
ORDER BY emp_id;
