SELECT * FROM (
select departments.department_name,employees.department_id, employees.first_name, employees.last_name, employees.salary 
from employees
join departments on departments.department_id=employees.department_id
where (employees.department_id, salary) in
(
select department_id, max(salary) from (
Select E1.Department_id,E1.Salary
From Employees E1,(Select Department_id,Max(Salary) as Salary
                  From Employees group by Department_id) E2
Where E1.Department_id = E2.Department_id
And E1.Salary<E2.Salary
order by department_id desc
) E
group by department_id
)
) WHERE ROWID IN
(SELECT MAX(ROWID) FROM 
(select departments.department_name,employees.department_id, 
employees.first_name, employees.last_name, 
employees.salary from employees
join departments on departments.department_id=employees.department_id

where (employees.department_id, salary) in
(
select department_id, max(salary) from (
Select E1.Department_id,E1.Salary
From Employees E1,(Select Department_id,Max(Salary) as Salary
                  From Employees group by Department_id) E2
Where E1.Department_id = E2.Department_id
And E1.Salary<E2.Salary
order by department_id desc
) E
group by department_id
)
)
group by department_name
)