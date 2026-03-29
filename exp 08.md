# <center>SQL Practical - EMP, DEPT, SALGRADE</center>

---

## <h2>📌 Create SALGRADE Table</h2>

```sql
CREATE TABLE SALGRADE (
    GRADE CHAR(1),
    LOSAL INT,
    HISAL INT
);

INSERT INTO SALGRADE VALUES
('A',700,1200),
('B',1201,1400),
('C',1401,2000),
('D',2001,3000),
('E',3001,9999);
 🔹 Q1. Display all employees with their dept name 
SELECT E.ENAME, D.DNAME
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;
🔹 Q2. Employees whose manager is JONES
SELECT E.ENAME AS employee, M.ENAME AS manager
FROM EMP E
JOIN EMP M ON E.MGR = M.EMPNO
WHERE M.ENAME = 'JONES';
🔹 Q3. Employee + Job + Dept + Manager + Grade (Dept wise)
SELECT 
    E.ENAME,
    E.JOB,
    D.DNAME,
    M.ENAME AS manager,
    S.GRADE
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DNAME;
🔹 Q4. Exclude CLERK, show highest salary first
SELECT 
    E.ENAME,
    E.JOB,
    S.GRADE,
    D.DNAME,
    E.SAL
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.JOB <> 'CLERK'
ORDER BY E.SAL DESC;
🔹 Q5. Employee + Job + Manager (include no manager)
SELECT 
    E.ENAME,
    E.JOB,
    IFNULL(M.ENAME, 'NO MANAGER') AS manager
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;
🔹 Q6. Annual salary ≥ 36000 OR not clerks
SELECT 
    E.ENAME,
    E.JOB,
    (E.SAL*12) AS annual_salary,
    E.DEPTNO,
    D.DNAME,
    S.GRADE
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE (E.SAL*12) >= 36000 OR E.JOB <> 'CLERK';
🔹 Q7. Annual salary ≥ 30000 AND not clerks
SELECT 
    E.ENAME,
    E.JOB,
    (E.SAL*12) AS annual_salary,
    E.DEPTNO,
    D.DNAME,
    S.GRADE
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE (E.SAL*12) >= 30000
AND E.JOB <> 'CLERK';
🔹 Q8. Employee + Manager (No manager if NULL)
SELECT 
    E.EMPNO,
    E.ENAME,
    IFNULL(M.EMPNO, 'NULL') AS mgr_no,
    IFNULL(M.ENAME, 'NO MANAGER') AS manager
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;
🔹 Q9. Dept name, dept no, total salary
SELECT 
    D.DNAME,
    D.DEPTNO,
    SUM(E.SAL) AS total_salary
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME;
🔹 Q10. Employee number, name, department location
SELECT 
    E.EMPNO,
    E.ENAME,
    D.LOC
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;
🔹 Q11. Employee name and department name
SELECT 
    E.ENAME,
    D.DNAME
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;
## <center>END OF PRACTICAL</center> 