-- Exercise 1: View
    CREATE OR REPLACE VIEW EmployeeDepartmentView AS
        (SELECT employee_id, first_name, last_name, email, hire_date, department_name 
        FROM (Employees e JOIN Departments d ON e.department_id=d.department_id)
        );

    -- a. 
    select first_name, last_name, employee_id
    from EmployeeDepartmentView
    where hire_date=
        (select max(hire_date)
        from EmployeeDepartmentView 
        where department_name='Executive')
    and department_name='Executive';

    -- b. 
    update EmployeeDepartmentView
    set department_name='Bean Counting'
    where department_name='Administration';
    -- Error: "cannot modify more than one base table through a join view"
    -- updating the department_name wont work because the Department part of the
    -- view is not key-preserved (unlike the Employee part, which is indeed
    -- key-preserved)

    -- c. 
    update EmployeeDepartmentView
    set first_name = 'Jose'
    where first_name = 'Jose Manuel';
    -- select * from employeedepartmentview where first_name LIKE '%Jose%';
    -- select * from employees where first_name LIKE 'Jose%';
    -- works!

    -- d. 
    insert into EmployeeDepartmentView
    values ((select max(employee_id) from EmployeeDepartmentView), 
    'Bob', 'Dylan',
    'bdylan@yahoo.com',
    to_date('08/10/1942', 'MM/DD/YYYY'),
    'Payroll');
    -- Error: "Cannot modify more than one base table through a join view"
    -- since departments is not key preserved, we cannot add department
    -- specific columns, as there is no key to bind them to
       