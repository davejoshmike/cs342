-- if using FOR UPDATE:
        -- https://docs.oracle.com/database/121/DWHSG/basicmv.htm#i1007007
-- Exercise 2: Materialized View
    DROP MATERIALIZED VIEW EmployeeDepartmentMatView;
    CREATE MATERIALIZED VIEW EmployeeDepartmentMatView AS
        (SELECT e1.employee_id, e1.first_name, e1.last_name, e1.email, 
            e1.hire_date, d.department_name
        FROM Employees e1, Departments d
        WHERE e1.department_id = d.department_id
        );

--        CREATE MATERIALIZED VIEW EmployeeDepartmentMatView FOR UPDATE AS
--        (SELECT e1.employee_id, e1.first_name, e1.last_name, e1.email, 
--            e1.hire_date, e1.department_id "e_dep_id", d.department_name, 
--            d.department_id "d_dep_id"
--        FROM Employees e1, Departments d
--        WHERE e1.department_id = d.department_id
--        );

    -- a. 
    select first_name, last_name, employee_id
    from EmployeeDepartmentView
    where hire_date=
        (select max(hire_date)
        from EmployeeDepartmentMatView 
        where department_name='Executive')
    and department_name='Executive';
        
    -- b. 
    update EmployeeDepartmentMatView
    set department_name='Bean Counting'
    where department_name='Administration';
    -- Error: "data manipulation operation not legal on this view"
    -- since the view is not key preserved, the view is not
    -- updateable

    -- c. 
    update EmployeeDepartmentMatView
    set first_name = NULL 
    where first_name = 'Jose'
        AND last_name = 'Manuel';
    -- Error: "data manipulation operation not legal on this view"
    -- Even though the Employee table part is key preserved, the 
    -- view strangely does not allow updates

    -- d. 
    insert into EmployeeDepartmentMatView
    values ((select max(employee_id) from EmployeeDepartmentMatView), 
    'Bob', 'Dylan',
    'bdylan@yahoo.com',
    to_date('08/10/1942', 'MM/DD/YYYY'),
    'Payroll');
    -- Error: "data manipulation operation not legal on this view"
