/* =====================================================
   Author: SaraAhmed
   Database: SQL SERVER
   Sample DB: Company_SD
   File: JOIN_Queries
   Description: This file contains different types of SQL JOIN queries 
                (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, 
                CROSS JOIN) to demonstrate how to combine and retrieve 
                related data between tables in the company.
   ===================================================== */

select * 
from Departments;


select * 
from Dependent;

select * 
from Employee;

select * 
from Project;

select * 
from Works_for;



--1.Display the Department id, name and id and the name of its manager.

SELECT d.Dname as DepartmemtName, e.Fname as Manager
FROM Departments as d join Employee as e 
ON D.MGRSSN = E.SSN;

 

--2.	Display the name of the departments and the name of the projects under its control.

SELECT d.Dname as DepartmentName, p.Pname as ProjectName
FROM Project as p  join Departments as d 
ON p.Dnum = d.Dnum;



--3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.

Select D.* ,e.Fname
From Employee as e join Dependent as d
ON e.SSN = d.ESSN;


--4.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

Select e.Fname , e.Dno, w.Hours, p.Pname
From Works_for as w  join Project as p
ON p.Pnumber = w.pno
join Employee as e
ON e.SSN = w.ESSn
where  e.Dno = 10
and w.Hours >= 10
and p.Pname = 'AL Rabwah';



--5.	Find the names of the employees who directly supervised with Kamel Mohamed.

select A.fname AS Manager, B.Fname 
FROM  Employee A join  Employee B
ON A.SSN = B.Superssn
WHERE A.Fname = 'Kamel' and A.Lname = 'Mohamed';
;


--6.	Display All Employees data and the data of their dependents even if they have no dependents

Select *
From Employee as e left join Dependent as d
ON e.SSN = d.ESSN;

--7.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees


SELECT d.Dname, max(Salary) as MaxSalary, min(Salary) as MinSalary, avg(Salary) as AvgSalary
FROM Departments AS d join Employee as e
ON d.Dnum = e.Dno
Group by Dname;

--8.	For each department, retrieve the department name and the maximum salary of its employees. (hint use subquery)

--wrong answer
SELECT Dname , 
(
select max(salary)
from Departments as d join Employee as e
on d.Dnum = e.Dno
) as maxSalary
from Departments


SELECT Dname,
    (SELECT MAX(salary)
        FROM employee e
        ) AS max_salary
FROM departments d


--9.	display the full name and salary of the employee who earns the highest salary(using Sub query)

select Fname,Lname, salary
from Employee
where Salary = (
select Max(salary)
)



select * 
from Departments join Employee on Departments.Dnum = Employee.Dno


select * from Employee