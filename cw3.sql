--View 1--
CREATE VIEW "VIEW1" AS
SELECT CONCAT(CONCAT(EMPLOYEES.LAST_NAME, ' '), EMPLOYEES.SALARY) AS Wynagrodzenie FROM EMPLOYEES 
WHERE ((EMPLOYEES.DEPARTMENT_ID=20) OR (EMPLOYEES.DEPARTMENT_ID=50)) AND (EMPLOYEES.SALARY > 2000 AND EMPLOYEES.SALARY < 7000)
ORDER BY EMPLOYEES.LAST_NAME;

--VIEW 2-
SELECT HIRE_DATE, LAST_NAME, &colName AS uservalue FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL AND HIRE_DATE BETWEEN '01-JAN-05' AND '31-DEC-05'
ORDER BY uservalue

--VIEW 3--
SELECT CONCAT(CONCAT(EMPLOYEES.FIRST_NAME, ' '), EMPLOYEES.LAST_NAME) AS EMPL_NAME, EMPLOYEES.SALARY, EMPLOYEES.PHONE_NUMBER FROM EMPLOYEES
WHERE EMPLOYEES.FIRST_NAME LIKE '%&VAL%'
ORDER BY EMPL_NAME ASC, EMPLOYEES.SALARY DESC


--VIEW 4--
CREATE VIEW "VIEW4" AS
SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, ROUND(MONTHS_BETWEEN(CURRENT_DATE,HIRE_DATE)) AS "MONTHS",
CASE
WHEN ROUND(MONTHS_BETWEEN(CURRENT_DATE, HIRE_DATE)) < 149 THEN SALARY*0.10
WHEN ROUND(MONTHS_BETWEEN(CURRENT_DATE, HIRE_DATE)) BETWEEN 150 AND 200 THEN SALARY*0.20
WHEN ROUND(MONTHS_BETWEEN(CURRENT_DATE, HIRE_DATE)) > 200 THEN SALARY*0.30
ELSE 0 
END
AS EXTRA
FROM EMPLOYEES
ORDER BY MONTHS

--VIEW 5--
 CREATE VIEW VIEW5 AS
 SELECT SUMA, SREDNIA FROM
 (
    SELECT ROUND(SUM(EMPLOYEES.SALARY)) AS SUMA, ROUND(AVG(EMPLOYEES.SALARY)) AS SREDNIA, ROUND(MIN(SALARY)) AS MINIMUM, EMPLOYEES.DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY EMPLOYEES.DEPARTMENT_ID
)
WHERE MINIMUM>5000;

--VIEW 6--
CREATE VIEW VIEW6 AS 
SELECT EMPLOYEES.LAST_NAME, EMPLOYEES.DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_NAME, EMPLOYEES.JOB_ID
FROM EMPLOYEES
INNER JOIN DEPARTMENTS ON DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
INNER JOIN LOCATIONS ON LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID
WHERE LOCATIONS.CITY='Toronto';

--VIEW 7--
CREATE VIEW VIEW7 AS
SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN
(
    SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME='Jennifer'
);



--VIEW 8--
CREATE VIEW VIEW8 AS 
SELECT DEPARTMENTS.* FROM DEPARTMENTS 
WHERE DEPARTMENTS.DEPARTMENT_ID NOT IN (
SELECT EMPLOYEES.DEPARTMENT_ID FROM EMPLOYEES
WHERE EMPLOYEES.DEPARTMENT_ID IS NOT NULL
)

--VIEW 10--
CREATE VIEW VIEW10 AS 
SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, EMPLOYEES.JOB_ID, DEPARTMENTS.DEPARTMENT_NAME, EMPLOYEES.SALARY, JOB_GRADES.GRADE FROM EMPLOYEES
JOIN DEPARTMENTS ON DEPARTMENTS.DEPARTMENT_ID=EMPLOYEES.DEPARTMENT_ID
JOIN JOB_GRADES ON EMPLOYEES.SALARY BETWEEN  JOB_GRADES.MIN_SALARY AND JOB_GRADES.MAX_SALARY 


--VIEW 11--
CREATE VIEW VIEW11 AS
SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, EMPLOYEES.SALARY FROM EMPLOYEES
WHERE 
EMPLOYEES.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY EMPLOYEES.SALARY DESC

--VIEW 12--
CREATE VIEW VIEW12 AS
SELECT EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME FROM EMPLOYEES
WHERE DEPARTMENT_ID IN
(
    SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%'
)