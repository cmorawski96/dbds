---------------------------------------ZAD 1
DECLARE
numer_max NUMBER;
dept_name departments.department_name%TYPE:='EDUCATION';
BEGIN
SELECT MAX(department_id) INTO numer_max FROM departments;
DBMS_OUTPUT.put_line(numer_max);
INSERT INTO departments
(department_id, department_name, manager_id, location_id)
VALUES
(numer_max+10, dept_name, NULL, NULL);
END;

----------------------------------------ZAD 2
DECLARE
numer_max NUMBER;
dept_name departments.department_name%TYPE:='EDUCATION';
BEGIN
SELECT MAX(department_id) INTO numer_max FROM departments;
DBMS_OUTPUT.put_line(numer_max);
INSERT INTO departments
(department_id, department_name, manager_id, location_id)
VALUES
(numer_max+10, dept_name, NULL, NULL);
UPDATE departments SET location_id = 3000 WHERE department_id=numer_max+10;
END;

------------------------------------------ZAD 3
CREATE TABLE nowa (pole varchar2(10));

BEGIN
    FOR i IN 1..10
    LOOP
        IF (NOT (i=4 OR i=6)) THEN INSERT INTO nowa VALUES (i);
        END IF;
    END LOOP;
END;

-------------------------------------------ZAD 4
DECLARE
row_value countries%ROWTYPE;
BEGIN
SELECT * into row_value FROM countries WHERE country_id = 'CA';
DBMS_OUTPUT.PUT_LINE(row_value.country_name);
DBMS_OUTPUT.PUT_LINE(row_value.region_id);
END;

-------------------------------------------ZAD 5
DECLARE
TYPE zad5 IS TABLE OF
departments.department_name%TYPE INDEX BY PLS_INTEGER;
tabela zad5;
counter NUMBER:=10;
BEGIN
FOR i IN 1..10
LOOP
    SELECT department_name INTO tabela(i) FROM departments 
    WHERE department_id=counter;
    counter:=counter+10;
    DBMS_OUTPUT.PUT_LINE(tabela(i));
END LOOP;
END;

-------------------------------------------ZAD 6
DECLARE
TYPE zad5 IS TABLE OF
departments%ROWTYPE INDEX BY PLS_INTEGER;
tabela zad5;
counter NUMBER:=10;
BEGIN
FOR i IN 1..10
LOOP
    SELECT * INTO tabela(i) FROM departments 
    WHERE department_id=counter;
    counter:=counter+10;
    DBMS_OUTPUT.PUT_LINE(tabela(i).department_id || ' ' || tabela(i).department_name);
END LOOP;
END;

------------------------------------------ZAD 7
--TO BE CONTINUED



