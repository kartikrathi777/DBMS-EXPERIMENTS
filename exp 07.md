# <center>Experiment No.7
### 1. Compute the no. of days remaining in this year. 
~~~sql
SELECT 
DATEDIFF(
    MAKEDATE(YEAR(CURDATE()) + 1, 1),
    CURDATE()
) AS DAYS_REMAINING;
~~~
~~~sql
SELECT DATEDIFF(
    CONCAT(YEAR(CURDATE()),'-12-31'),CURDATE());
~~~
##### MAKEDATE(year, dayofyear) → First day of next year
##### DATEDIFF() → Difference in days
##### SELECT MAKEDATE(2024, 60);  -> (Returns the 60th day of 2024, which is '2024-02-29') 
### 2. Find the highest and lowest salaries and the difference between them. 
~~~sql
SELECT 
MAX(SAL) AS HIGHEST_SALARY,
MIN(SAL) AS LOWEST_SALARY,
MAX(SAL) - MIN(SAL) AS DIFFERENCE
FROM EMPLOYEE;
~~~
### 3. List employee whose commission is greater than 25 % of their salaries. 
~~~sql
SELECT ENAME, SAL, COMM
FROM EMPLOYEE
WHERE COMM > (SAL * 0.25);
~~~
~~~sql
SELECT ENAME, SAL, COMM
FROM EMPLOYEE
WHERE IFNULL(COMM,0) > SAL * 0.25;
~~~
### 4. Make a query that displays salary in dollar format. 
~~~sql
SELECT ENAME,
CONCAT('$', FORMAT(SAL, 2)) AS SALARY_IN_DOLLAR
FROM EMPLOYEE;
~~~
### For conversion of value(₹ → $ assuming rate 83):
~~~sql
SELECT 
ENAME,
CONCAT('$ ', FORMAT(SAL / 83, 2)) AS SALARY_IN_DOLLAR
FROM EMPLOYEE;
~~~
##### FORMAT(SAL,2) → 2 decimal places
### 5. Create a matrix query to display the job, the salary for that job based on department number, and the total salary for that job for all departments, giving each column an appropriate heading. 
~~~sql
SELECT 
JOB,
SUM(CASE WHEN DEPTNO = 10 THEN SAL ELSE 0 END) AS DEPT10,
SUM(CASE WHEN DEPTNO = 20 THEN SAL ELSE 0 END) AS DEPT20,
SUM(CASE WHEN DEPTNO = 30 THEN SAL ELSE 0 END) AS DEPT30,
SUM(CASE WHEN DEPTNO = 40 THEN SAL ELSE 0 END) AS DEPT40,
SUM(SAL) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY JOB;
~~~
### 6. Query that will display the total no of employees, and of that total the number who were hired in 1980,1981,1982 and 1983. Give appropriate column heading. 
~~~sql
SELECT
COUNT(*) AS TOTAL_EMPLOYEES,
SUM(CASE WHEN YEAR(HIREDATE) = 1980 THEN 1 ELSE 0 END) AS "1980",
SUM(CASE WHEN YEAR(HIREDATE) = 1981 THEN 1 ELSE 0 END) AS "1981",
SUM(CASE WHEN YEAR(HIREDATE) = 1982 THEN 1 ELSE 0 END) AS "1982",
SUM(CASE WHEN YEAR(HIREDATE) = 1983 THEN 1 ELSE 0 END) AS "1983"
FROM EMPLOYEE;
~~~
### 7. Query to get the last Sunday of Any Month. 
~~~sql
SELECT 
DATE_SUB(
    LAST_DAY('2026-02-01'),
    INTERVAL (WEEKDAY(LAST_DAY('2026-02-01')) + 1) DAY
) AS LAST_SUNDAY;
~~~
##### LAST_DAY() → Last date of month
##### Adjust backward to Sunday
### 8. Display department numbers and total number of employees working in each department. 
~~~sql
SELECT DEPTNO, COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEE
GROUP BY DEPTNO;
~~~
### 9. Display the various jobs and total number of employees within each job group.
~~~sql
SELECT JOB, COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEE
GROUP BY JOB;
~~~
### 10. Display the depart numbers and total salary for each department. 
~~~sql
SELECT DEPTNO, SUM(SAL) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPTNO;
~~~
    DATEDIFF() → days difference
    MAKEDATE() → create date using year
    FORMAT() → numeric formatting
    CASE → MySQL alternative to DECODE
    GROUP BY → aggregation per group
    Matrix query → Conditional SUM(CASE...)