--Write SQL queries that:

	-- 1. Get a list of the employees who have finished all of their jobs (i.e., all their jobs in the job_history table have non-null end_dates).
	select distinct e.*
    from (employees e JOIN job_history jh
         ON jh.end_date IS NOT NULL
         AND e.employee_id = jh.employee_id)
    ORDER BY e.employee_id; 
	
	-- 2. Get a list of employees along with their manager such that the managers have less seniority at the company and that all the employees’ jobs have been within the manager’s department.
    select distinct emp.employee_id, emp.first_name || ' ' || emp.last_name employee_name,
        man.employee_id manager_id, man.first_name || ' ' || man.last_name manager_name, department_name
	from (((employees emp JOIN employees man
        ON emp.manager_id=man.employee_id
        AND emp.HIRE_DATE <= man.HIRE_DATE)
        JOIN Departments dep
        ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
        AND emp.MANAGER_ID = dep.MANAGER_ID)
        JOIN job_history jh
        ON dep.department_id = jh.department_id);
	
	-- 3. The countries in which at least one department is located. Try to write this as both a join and a nested query. If you can, explain which is better. If you can’t, explain which is not possible and why.
		-- nested
        select country_id, count(*) from Locations where location_id in (select location_id from Departments) group by country_id;
        	    
        -- join
        select country_id, count(*) from (Locations JOIN DEPARTMENTS ON DEPARTMENTS.LOCATION_ID in LOCATIONS.LOCATION_ID) group by country_id;

        -- join queries have the ability to be optimized better at the machine level than subqueries do
        -- because they are better able to be predicted than subqueries. Therefore it is better to use
        -- join queries rather than subqueries
