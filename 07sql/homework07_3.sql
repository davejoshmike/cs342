-- Exercise 7.3
    --a.
    -- original
    SELECT employee_id, first_name, last_name, email, hire_date, d.department_name 
           FROM (Employees e JOIN Departments d ON e.department_id=d.department_id
    
    -- relational algebra    
    PI_employee_id, first_name, last_name, email, hire_date, department_name(RHO_e(Employees) THETA JOIN_e.department_id=d.department_id RHO_d(Departments))
    
    -- relational calculus
    { e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name | Employee(e) ^ Department(d) ^ e.department_id=d.department_id }

--b. 
    -- original
    select first_name, last_name, employee_id
    from EmployeeDepartmentView
    where hire_date=
        (select max(hire_date)
        from EmployeeDepartmentView 
        where department_name='Executive')
    and department_name='Executive';

    -- relational calculus
    { dv.first_name,dv.last_name,dv.employee_id | DeptView(dv) ^ dv.hire_date={ max(dv2.hire_date) | DeptView(dv2) ^ department_name="Executive" } ^ dv.department_name="executive" }
