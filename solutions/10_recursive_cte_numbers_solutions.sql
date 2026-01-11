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


