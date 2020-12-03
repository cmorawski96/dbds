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
/*
Zadeklaruj kursor jako wynagrodzenie, nazwisko dla departamentu o numerze 50. Dla elementów kursora wypisać na ekran, 
jeśli wynagrodzenie jest wyższe niż 3100: nazwisko osoby i tekst ‘nie dawać podwyżki’ w przeciwnym przypadku: nazwisko + ‘dać podwyżkę’
*/
DECLARE
    CURSOR zad7 IS
        SELECT salary, last_name FROM employees WHERE department_id=50;
BEGIN
    FOR wiersz IN zad7
    LOOP
        IF wiersz.salary > 3100 THEN dbms_output.put_line(wiersz.last_name ||(wiersz.salary || ' nie dawac podwyzki'));
        ELSE dbms_output.put_line(wiersz.last_name || (wiersz.salary || ' dac podwyzke'));
        END IF;
    END LOOP;
    dbms_output.put_line(zad7%ROWCOUNT);
END;

----------------------------------------ZAD 8
/*
Zadeklarować kursor zwracający zarobki imię i nazwisko pracownika z parametrami, 
gdzie pierwsze dwa parametry określają widełki zarobków a trzeci część imienia pracownika. Wypisać na ekran pracowników:
a.       z widełkami 1000- 5000 z częścią imienia a (może być również A)
b.       z widełkami 5000-20000 z częścią imienia u (może być również U)

*/
DECLARE
    CURSOR zad8 (lowsalary NUMBER, highsalary NUMBER, partname VARCHAR2) IS
        SELECT salary, first_name, last_name FROM employees WHERE (salary>=lowsalary AND salary<=highsalary AND (UPPER(first_name) LIKE UPPER(('%'||partname)||'%')));
    wiersz zad8%ROWTYPE;
BEGIN

        DBMS_OUTPUT.PUT_LINE('Podpunkt a');
    OPEN zad8(1000, 5000, 'a');
    LOOP
        FETCH zad8 INTO wiersz;
        EXIT WHEN zad8%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(wiersz.first_name||(' '||(wiersz.last_name||(' '||wiersz.salary))));
    END LOOP;
    CLOSE zad8;
        DBMS_OUTPUT.PUT_LINE('Podpunkt b');
    OPEN zad8(5000, 20000, 'u');
    LOOP
        FETCH zad8 INTO wiersz;
        EXIT WHEN zad8%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(wiersz.first_name||(' '||(wiersz.last_name||(' '||wiersz.salary))));
    END LOOP;
    CLOSE zad8;    
END;

---------------------------------------ZAD 9a
/* Stwórz procedurę:
dodającą wiersz do tabeli Jobs – z dwoma parametrami wejściowymi określającymi Job_id, Job_title, przetestuj działanie wrzuć wyjątki – co najmniej when others
*/
CREATE OR REPLACE PROCEDURE zad9a(jobid IN VARCHAR2, jobtitle IN VARCHAR2) IS
wiersz jobs%ROWTYPE;
wyjątek EXCEPTION;
BEGIN
    INSERT INTO jobs VALUES(jobid, jobtitle, NULL, NULL);
    dbms_output.put_line('Success');
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('Others');
END;

BEGIN
zad9a('test1','test1');
END;

-------------------------------------ZAD 9b
/* Stwórz procedurę:
  modyfikującą title w  tabeli Jobs – z dwoma parametrami 
  id dla którego ma być modyfikacja oraz nową wartość dla Job_title – przetestować działanie, dodać swój wyjątek dla no Jobs updated – najpierw sprawdzić numer błędu
*/
CREATE OR REPLACE PROCEDURE zad9b(jobid IN VARCHAR2, jobtitle IN VARCHAR2) IS
wiersz jobs%ROWTYPE;
wyjątek EXCEPTION;
BEGIN
    SELECT * INTO wiersz FROM jobs WHERE job_id=jobid;
    UPDATE jobs
    SET job_title = jobtitle
    WHERE
    job_id=jobid;
    dbms_output.put_line('Success');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No Jobs Updated - error code 01403');
    WHEN OTHERS THEN
    dbms_output.put_line('Others');

END;

--------------------------------------ZAD 9c
/*Stworzyć procedurę
   usuwającą wiersz z tabeli Jobs  o podanym Job_id– przetestować działanie, dodaj wyjątek dla no Jobs deleted
*/
CREATE OR REPLACE PROCEDURE zad9c(jobid IN VARCHAR2) IS
wiersz jobs%ROWTYPE;
wyjątek EXCEPTION;
BEGIN
    SELECT * INTO wiersz FROM jobs WHERE job_id=jobid;
    DELETE FROM jobs
    WHERE
    job_id=jobid;
    dbms_output.put_line('Success');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No Jobs deleted - error code 01403');
    WHEN OTHERS THEN
    dbms_output.put_line('Others');
END;

---------------------------------ZAD 9d
/*Stworzyć procedurę
   Wyciągającą zarobki i nazwisko (parametry zwracane przez procedurę) z tabeli employees dla pracownika o przekazanym jako parametr id
*/
CREATE OR REPLACE PROCEDURE zad9d(employeeid IN NUMBER, zarobki OUT NUMBER, lastname OUT VARCHAR2) IS
wiersz jobs%ROWTYPE;
wyjątek EXCEPTION;
BEGIN
    SELECT salary, last_name INTO zarobki, lastname FROM employees WHERE employee_id=employeeid;
    dbms_output.put_line('Success');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No employee found - error code 01403');
    WHEN OTHERS THEN
    dbms_output.put_line('Others');
END;

------------------------------------ZAD 9e
/*Stworzyć procedurę
    dodającą do tabeli employees wiersz – większość parametrów ustawić na domyślne (id poprzez sekwencję), 
    stworzyć wyjątek jeśli wynagrodzenie dodawanego pracownika jest wyższe niż 20000
*/
create or replace PROCEDURE zad9e(
employeeid IN NUMBER DEFAULT employeeid_seq.nextval,
firstname IN VARCHAR2 DEFAULT 'Imie',
lastname IN VARCHAR2 DEFAULT 'Nazwisko',
mail IN VARCHAR2 DEFAULT 'email',
telefon IN VARCHAR2 DEFAULT 'telefon',
datazatrudnienia IN DATE DEFAULT SYSDATE,
jobid IN VARCHAR2 DEFAULT 'SA_REP',
pensja IN NUMBER DEFAULT 1500,
prowizja IN NUMBER DEFAULT 2,
menadzer IN NUMBER DEFAULT 200,
wydzial IN NUMBER DEFAULT 10
) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
    IF pensja>20000 THEN
        RAISE wyjatek;
    END IF;
    INSERT INTO employees VALUES (employeeid, firstname, lastname, mail, telefon, datazatrudnienia, jobid, pensja, prowizja, menadzer, wydzial);
    dbms_output.put_line('Success');
EXCEPTION
    WHEN wyjatek THEN
    dbms_output.put_line('ZA DUZE ZAROBKI');
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No employee found - error code 01403');
    WHEN OTHERS THEN
    dbms_output.put_line('Others');
END;