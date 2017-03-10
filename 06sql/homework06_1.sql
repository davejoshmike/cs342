--Homework06
-- a.
    select man.employee_id, man.first_name || ' ' || man.last_name "FULLNAME", count(emp.EMPLOYEE_ID)
    from (Employees man JOIN Employees emp
        ON emp.manager_id=man.employee_id)
    group by man.employee_id, man.first_name, man.last_name
    order by count(*) desc
    ;

-- b.   
    select dep.department_id, dep.department_name, 
        count(emp.employee_id) "EMPLOYEES", sum(emp.salary) "TOTAL SALARY"
    from ((employees emp JOIN departments dep 
        ON dep.department_id = emp.department_id) 
        JOIN locations loc 
        ON dep.location_id = loc.location_iD 
        AND loc.country_id = 'US')
    group by dep.department_id, dep.department_name
    having count(emp.employee_id) < 100
    order by dep.department_id asc
    ;   

-- c. 
    select dep.department_name, man.first_name || ' ' || man.last_name "MANAGER", job.job_title
    from (Employees man JOIN Jobs job ON man.job_id=job.job_id)
        RIGHT OUTER JOIN Departments dep ON man.employee_id=dep.manager_id
    ;

-- d.
    select dep.department_name, sum(emp.salary) "TOTAL SALARY"
    from (departments dep LEFT OUTER JOIN Employees emp
        ON dep.department_id=emp.department_id)
    group by dep.department_name    
    order by sum(emp.salary) asc
    ;

        