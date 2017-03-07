--Write SQL queries that:

	-- 1. Get a list of the employees who have finished all of their jobs (i.e., all their jobs in the job_history table have non-null end_dates).
	select distinct e.* from employees e, job_history jh where jh.end_dates IS NOT NULL; 
	
	-- 2. Get a list of employees along with their manager such that the managers have less seniority at the company and that all the employees’ jobs have been within the manager’s department.
	select emp.*
	from employees emp
	where emp.hire_date <= 
		(select man.hire_date 
		from employees man 
		where emp.manager_id=man.employee_id) 
	AND emp.employee_id = 
		(select emp.employee_id 
		FROM departments dep 
		WHERE dep.department_id = emp.department_id 
		AND emp.manager_id = dep.manager_id);

	--NOTES:
		-- employee:
		-- emp_id 	fname lname   email    phone# hire_date jobid comis manid depid
		-- 102 		lex   de haan ldehaan  515... 13-JAN-01 AD_VP 17000 100   90
		
		--manager:
		-- 100 steven king ad_pres 90
		
		--department:
		-- 90 executive 100 1700
	
	-- 3. The countries in which at least one department is located. Try to write this as both a join and a nested query. If you can, explain which is better. If you can’t, explain which is not possible and why.
		select * from Locations where location_id= (select location_id from departments where rownum <=1);
		
	
	
	0 200
	(xrightwall)
	current xpos > (xrightwall)
	heading(200) -- rotate a random amount of degrees from 200-340
		
	