# SQL PRACTICAL FILE (MariaDB / MySQL)

---

## **EXPERIMENT 1: Table Creation & Basic Operations**

### Create DEPARTMENT Table

```sql
CREATE TABLE department (
    deptno INT PRIMARY KEY,
    dname VARCHAR(15) NOT NULL
) ENGINE=InnoDB;
```

### Create EMPLOYEE Table

```sql
CREATE TABLE employee (
    empno INT PRIMARY KEY,
    ename VARCHAR(20) NOT NULL,
    job VARCHAR(20),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10,0),
    comm DECIMAL(7,0),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES department(deptno)
) ENGINE=InnoDB;
```

### Create EMPLOYEE_MASTER from EMPLOYEE

```sql
CREATE TABLE employee_master AS
SELECT * FROM employee;
```

### Delete employees of Dept 10

```sql
DELETE FROM employee_master WHERE deptno = 10;
```

### Update salary of Dept 20 by 10%

```sql
UPDATE employee_master
SET sal = sal * 1.10
WHERE deptno = 20;
```

### Alter SAL column size

```sql
ALTER TABLE employee_master
MODIFY sal DECIMAL(10,2);
```

### Drop EMPLOYEE_MASTER

```sql
DROP TABLE employee_master;
```

---

## **EXPERIMENT 2: Retrieving Data**

```sql
-- 1. Distinct jobs
SELECT DISTINCT job FROM employee;

-- 2. Employees in Dept 30
SELECT * FROM employee WHERE deptno = 30;

-- 3. Department number & name greater than 20
SELECT deptno, dname FROM department WHERE deptno > 20;

-- 4. Managers and clerks in Dept 30
SELECT * FROM employee
WHERE deptno = 30 AND job IN ('MANAGER','CLERK');

-- 5. Name, empno, dept of clerks
SELECT empno, ename, deptno FROM employee WHERE job = 'CLERK';

-- 6. Managers not in Dept 30
SELECT * FROM employee WHERE job = 'MANAGER' AND deptno <> 30;

-- 7. Dept 10 employees not manager or clerk
SELECT * FROM employee
WHERE deptno = 10 AND job NOT IN ('MANAGER','CLERK');

-- 8. Employees earning between 1200 and 1400
SELECT ename, job FROM employee WHERE sal BETWEEN 1200 AND 1400;

-- 9. Clerks, analysts or salesman
SELECT ename, deptno FROM employee
WHERE job IN ('CLERK','ANALYST','SALESMAN');

-- 10. Names starting with M
SELECT ename, deptno FROM employee WHERE ename LIKE 'M%';
```

---

## **EXPERIMENT 3: Pattern Matching & Salary Queries**

```sql
-- 1. Dept 30 employees order by salary desc
SELECT ename, job FROM employee
WHERE deptno = 30 ORDER BY sal DESC;

-- 2. 5-letter names starting A ending N
SELECT job, deptno FROM employee WHERE ename LIKE 'A___N';

-- 3. Names starting with S
SELECT ename FROM employee WHERE ename LIKE 'S%';

-- 4. Names ending with S
SELECT ename FROM employee WHERE ename LIKE '%S';

-- 5. Dept 10/20/40 or clerk/salesman/analyst
SELECT ename FROM employee
WHERE deptno IN (10,20,40)
OR job IN ('CLERK','SALESMAN','ANALYST');

-- 6. Employees earning commission
SELECT empno, ename FROM employee WHERE comm IS NOT NULL AND comm > 0;

-- 7. Total salary (sal + comm)
SELECT empno, sal + IFNULL(comm,0) AS total_salary FROM employee;

-- 8. Annual salary
SELECT empno, sal*12 AS annual_salary FROM employee;

-- 9. Clerks earning more than 3000
SELECT ename FROM employee WHERE job='CLERK' AND sal>3000;

-- 10. Clerk/salesman/analyst earning >3000
SELECT ename FROM employee
WHERE job IN ('CLERK','SALESMAN','ANALYST') AND sal>3000;
```

---

## **EXPERIMENT 4: Date, Salary & Update Queries**

```sql
-- 1. Joined before 30-Jun-1980 or after 31-Dec-1981
SELECT * FROM employee
WHERE hiredate < '1980-06-30' OR hiredate > '1981-12-31';

-- 2. Second letter A
SELECT ename FROM employee WHERE ename LIKE '_A%';

-- 3. Exactly 5 characters
SELECT ename FROM employee WHERE LENGTH(ename)=5;

-- 4. Second letter A (repeat)
SELECT ename FROM employee WHERE ename LIKE '_A%';

-- 5. Not salesman/clerk/analyst
SELECT ename FROM employee
WHERE job NOT IN ('SALESMAN','CLERK','ANALYST');

-- 6. Annual salary highest first
SELECT ename, sal*12 AS annual_salary
FROM employee ORDER BY sal DESC;

-- 7. HRA, DA, PF, Total Salary
SELECT ename, sal,
       sal*0.15 AS hra,
       sal*0.10 AS da,
       sal*0.05 AS pf,
       (sal + sal*0.15 + sal*0.10 - sal*0.05) AS totalsal
FROM employee ORDER BY totalsal;

-- 8. Update salary 10% where no commission
UPDATE employee
SET sal = sal*1.10
WHERE comm IS NULL OR comm = 0;

-- 9. Salary >3000 after 20% increment
SELECT ename FROM employee WHERE sal*1.20 > 3000;

-- 10. Salary at least 3 digits
SELECT ename FROM employee WHERE sal >= 100;
```

---

## **EXPERIMENT 5: Aggregate & String Functions**

```sql
-- 1. Total employees
SELECT COUNT(*) FROM employee;

-- 2. Total salary
SELECT SUM(sal) FROM employee;

-- 3. Maximum salary
SELECT MAX(sal) FROM employee;

-- 4. Minimum salary
SELECT MIN(sal) FROM employee;

-- 5. Average salary
SELECT AVG(sal) FROM employee;

-- 6. Max salary of clerk
SELECT MAX(sal) FROM employee WHERE job='CLERK';

-- 7. Max salary in Dept 20
SELECT MAX(sal) FROM employee WHERE deptno=20;

-- 8. Min salary of salesman
SELECT MIN(sal) FROM employee WHERE job='SALESMAN';

-- 9. Avg salary of managers
SELECT AVG(sal) FROM employee WHERE job='MANAGER';

-- 10. Total salary of analyst in Dept 40
SELECT SUM(sal) FROM employee WHERE job='ANALYST' AND deptno=40;

-- 11. Names in uppercase
SELECT UPPER(ename) FROM employee;

-- 12. Names in lowercase
SELECT LOWER(ename) FROM employee;

-- 13. Names in proper case
SELECT CONCAT(UPPER(LEFT(ename,1)), LOWER(SUBSTRING(ename,2))) FROM employee;

-- 14. Length of your name
SELECT LENGTH('KARTIK') AS name_length;

-- 15. Length of all employee names
SELECT ename, LENGTH(ename) FROM employee;
```


