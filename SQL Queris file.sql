-- LOCATION table
CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);

create database case_study_2;

-- Inserting data into the LOCATION table
INSERT INTO LOCATION (Location_ID, City) VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

-- DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_Id INT,
    FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);

-- Inserting data into the DEPARTMENT table
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id) VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);


-- JOB table
CREATE TABLE JOB (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);

-- Inserting data into the JOB table
INSERT INTO JOB (Job_ID, Designation) VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');

-- EMPLOYEE table
CREATE TABLE EMPLOYEE (
    Employee_Id INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_Id INT,
    Hire_Date DATE,
    Salary DECIMAL(10, 2),
    Comm DECIMAL(10, 2),
    Department_Id INT,
    FOREIGN KEY (Job_Id) REFERENCES JOB(Job_ID),
    FOREIGN KEY (Department_Id) REFERENCES DEPARTMENT(Department_Id)
);

-- Inserting data into the EMPLOYEE table
INSERT INTO EMPLOYEE (Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(7555, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(7566, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(7567, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 30),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 40);

--Simple Queries:
--1. List all the employee details. 
SELECT  * FROM employee;

--2. List all the department details. 
SELECT  * FROM department;
--3. List all job details.

SELECT * FROM job;

--4. List all the locations.

SELECT * FROM location;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT  First_name,Last_name,Salary,Comm 
FROM employee;

--6. List out the Employee ID, Last Name, Department ID for all employeesandalias
--Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", Department ID as "Dep_id". 

SELECT Employee_id AS ID_of_the_Employee,Last_name AS Name_of_the_Employee,Department_id AS Dep_id
FROM employee;
 
--7. List out the annual salary of the employees with their names only

SELECT * FROM employee;

SELECT CONCAT(First_Name, ' ', Last_Name) AS "Employee Name", Salary * 12 AS  "Annual Salary" FROM EMPLOYEE;


--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM employee
WHERE Last_name='Smith';

--2. List out the employees who are working in department 20. 

SELECT*FROM employee
WHERE Department_Id=20;

--3. List out the employees who are earning salaries between 3000and4500.

SELECT * FROM employee WHERE salary between 3000 and 4500;

--4. List out the employees who are working in department 10 or 20. 

SELECT  * FROM EMPLOYEE WHERE Department_Id IN (10, 20);


--5. Find out the employees who are not working in department 10 or 30. 

SELECT * FROM EMPLOYEE WHERE Department_Id NOT IN (10, 30);

--6. List out the employees whose name starts with 'S'
SELECT *, CONCAT(First_Name, ' ', Last_Name) AS "Employee Name"
FROM EMPLOYEE
WHERE CONCAT(First_Name, ' ', Last_Name) LIKE 'S%';

--7. List out the employees whose name starts with 'S' and ends with'H'. 
SELECT * 
FROM EMPLOYEE
WHERE First_Name LIKE 'S%' AND Last_Name LIKE  '%H';

--8. List out the employees whose name length is 4 and start with 'S'.
SELECT *
FROM EMPLOYEE
WHERE LEN(CONCAT(First_Name, Last_Name)) = 4
AND First_Name LIKE 'S%';

--9. List out employees who are working in department 10 and draw salaries morethan 3500.
SELECT *
FROM EMPLOYEE
WHERE Department_Id=10 AND Salary >3500;

--10. List out the employees who are not receiving commission.
SELECT *
FROM EMPLOYEE
WHERE Comm IS NULL;

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order basedon the Employee ID. 

SELECT Employee_Id ,Last_Name 
FROM Employee
ORDER BY Employee_Id;

--2. List out the Employee ID and Name in descending order based on salary.

SELECT Employee_Id,First_Name,Last_Name  
FROM Employee
ORDER BY Salary DESC;
--3. List out the employee details according to their Last Name in ascending-order.

SELECT * FROM Employee
ORDER BY Last_Name;

--4. List out the employee details according to their Last Name in ascendingorder and then Department ID in descending order.
SELECT * FROM Employee
ORDER BY Last_Name,Department_Id DESC; 

--GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization? 
SELECT Department_Id, COUNT(*) AS "Number of Employees"
FROM EMPLOYEE
GROUP BY Department_Id;
--2. List out the department wise maximum salary, minimumsalary andaverage salary of the employees. 

SELECT Department_Id,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM Employee
GROUP BY Department_Id;

--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees. 

SELECT Job_Id,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM Employee
GROUP BY Job_Id;

select * from job;
--4. List out the number of employees who joined each month in ascending order.

select * from employee;

SELECT COUNT(*) AS No_Of_Employees , MONTH(Hire_Date) AS Month_of_Join 
FROM Employee
GROUP BY MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);

--5. List out the number of employees for each month and year in
--ascending order based on the year and month. 

SELECT COUNT(*) AS No_Of_Employees,
       MONTH(Hire_Date) AS Month_of_Join,
       YEAR(Hire_Date) AS Year_of_Join
FROM Employee
GROUP BY MONTH(Hire_Date), YEAR(Hire_Date)
ORDER BY Year_of_Join, Month_of_Join;

--6. List out the Department ID having at least four employees. 

SELECT Department_Id, COUNT(*) AS "Number of Employees"
FROM Employee
GROUP BY Department_Id
HAVING COUNT(*) >= 4;

--7. How many employees joined in the month of January?
SELECT
    COUNT(*) AS No_Of_Employees_Joined_in_January
FROM Employee
WHERE MONTH(Hire_Date) = 1;

--8. How many employees joined in the month of January orSeptember?
SELECT
    COUNT(*) AS No_Of_Employees_Joined_in_January_or_September
FROM Employee
WHERE MONTH(Hire_Date) = 9 OR MONTH(Hire_Date) = 1;

--9. How many employees joined in 1985?
SELECT
    COUNT(*) AS No_Of_Employees_Joined_in_1985year
FROM Employee
WHERE YEAR(Hire_Date) = 1985;
--10. How many employees joined each month in 1985?
SELECT
    MONTH(Hire_Date) AS Month_Joined,
    COUNT(*) AS No_Of_Employees_Joined_in_each_month_of_1985
FROM Employee
WHERE YEAR(Hire_Date) = 1985
GROUP BY MONTH(Hire_Date)
ORDER BY Month_Joined;

--11. How many employees joined in March 1985?
SELECT
    MONTH(Hire_Date) AS Month_Joined,
    COUNT(*) AS No_Of_Employees_Joined_in_march_month_of_1985
FROM Employee
WHERE YEAR(Hire_Date) = 1985 AND  MONTH(Hire_Date)=3
GROUP BY MONTH(Hire_Date);

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT Department_Id,
    MONTH(Hire_Date) AS Month_Joined,
    COUNT(*) AS No_Of_Employees_Joined_in_April_month_of_1985
FROM Employee
WHERE YEAR(Hire_Date) = 1985 AND  MONTH(Hire_Date)=4
GROUP BY MONTH(Hire_Date),Department_Id
HAVING  COUNT(*)>=3;

--Joins:
--1. List out employees with their department names. 

SELECT
    E.Employee_Id,
    E.Last_Name,
    E.First_Name,
    D.Name AS Department_Name
FROM
    EMPLOYEE E
JOIN
    DEPARTMENT D ON E.Department_Id = D.Department_Id;


--2. Display employees with their designations.

SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

SELECT
    E.Employee_Id,
    E.Last_Name,
    E.First_Name,
    J.Designation
FROM
    EMPLOYEE E
JOIN
    JOB J ON E.Job_Id = J.Job_Id;

--3. Display the employees with their department names and regional groups.
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
SELECT * FROM LOCATION;

--4. How many employees are working in different departments? Displaywithdepartment names. 
SELECT
    E.Employee_Id,
    E.Last_Name,
    E.First_Name,
    D.Name AS Department_Name,
    L.City AS Regional_Group
FROM
    EMPLOYEE E
JOIN
    DEPARTMENT D ON E.Department_Id = D.Department_Id
JOIN
    LOCATION L ON D.Location_Id = L.Location_ID;

--5. How many employees are working in the sales department?

	SELECT 
     COUNT(*) AS "No Of Employees Working in Sales Department"
FROM 
    EMPLOYEE E
JOIN
    DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE	
    D.Name = 'Sales';

--6. Which is the department having greater than or equal to 5
--employees? Display the department names in ascending order.

SELECT 
    COUNT(*) AS "No Of Employees Working in Sales Department",
    D.Name as Department_Name
FROM 
    EMPLOYEE E
JOIN
    DEPARTMENT D ON E.Department_Id = D.Department_Id
GROUP BY D.Name
HAVING 
    COUNT(*) >= 5
ORDER BY D.Name;

--7. How many jobs are there in the organization? Display with designations.

SELECT COUNT(Job_Id) AS No_Of_Jobs,Designation
FROM JOB
GROUP BY Designation;

--8. How many employees are working in "New York"?

SELECT COUNT(*) AS "No of employees", D.Name AS "Department Name"
FROM Employee E
JOIN Department D ON E.Department_Id = D.Department_Id
JOIN Location L ON D.Location_Id = L.Location_Id
WHERE L.City = 'New York'
GROUP BY D.Name;

--9. Display the employee details with salary grades. Use conditional statement to create a grade column. 

SELECT *,
CASE
    WHEN Salary<1000 THEN 'C'
	WHEN Salary>=1000 THEN 'B'
	WHEN Salary>=2000 THEN 'A'
	ELSE 'D'
END AS 'GRADE'
FROM Employee;

--10. List out the number of employees grade wise. Use conditional statement to  create a grade column. 

SELECT GRADE ,
COUNT(*) AS "Grade Wise Employees"
FROM( SELECT 
      CASE
          WHEN Salary<1000 THEN 'C'
	      WHEN Salary>=1000 AND Salary<=2000 THEN 'B'
	      WHEN Salary>=2000 THEN 'A'
	      ELSE 'D'
          END AS 'GRADE'
          FROM Employee) AS Subquery
GROUP BY GRADE;


SELECT
    First_Name,
    Last_Name,
    Grade,
    COUNT(*) AS "Grade Wise Employees"
FROM (
    SELECT
        First_Name,
        Last_Name,
        CASE
            WHEN Salary < 1000 THEN 'C'
            WHEN Salary >= 1000 AND Salary <= 2000 THEN 'B'
            WHEN Salary >= 2000 THEN 'A'
            ELSE 'D'
        END AS Grade
    FROM Employee
) AS Subquery
GROUP BY First_Name, Last_Name, Grade;



--11.Display the employee salary grades and the number of employees

SELECT SALARY_GRADE ,COUNT(*) AS "Grade Wise Employees"
FROM( SELECT 
      CASE
          WHEN Salary<1000 THEN 'C'
	      WHEN Salary>=1000 AND Salary<=2000 THEN 'B'
	      WHEN Salary>=2000 THEN 'A'
	      ELSE 'D'
          END AS 'SALARY_GRADE'
          FROM Employee) AS Subquery
GROUP BY SALARY_GRADE;

--SET Operators:
--1. List out the distinct jobs in sales and accounting departments.


SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Sales'
)
UNION
SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Accounting'
);

--2. List out all the jobs in sales and accounting departments. 

SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Sales'
)
UNION ALL
SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Accounting'
);

--3. List out the common jobs in research and accounting departments in ascending order.

SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Research'
)
INTERSECT
SELECT Job.Designation
FROM Job
WHERE Job.Job_ID IN (
    SELECT Employee.Job_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    WHERE Department.Name = 'Accounting'
)
ORDER BY Job.Designation;

--Subqueries:
--1. Display the employees list who got the maximum salary.

SELECT Employee_Id, Last_Name, First_Name, Salary
FROM Employee
WHERE Salary = (SELECT MAX(Salary) FROM Employee);

--2. Display the employees who are working in the sales department. 

SELECT Employee_Id, Last_Name, First_Name
FROM Employee
WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.

SELECT Employee_Id, Last_Name, First_Name
FROM Employee
WHERE Job_Id = (SELECT Job_Id FROM Job WHERE Designation = 'Clerk');

--4. Display the list of employees who are living in "New York".

SELECT Employee_Id, Last_Name, First_Name
FROM Employee
WHERE Employee_Id IN (
    SELECT Employee_Id
    FROM Employee
    JOIN Department ON Employee.Department_Id = Department.Department_Id
    JOIN Location ON Department.Location_Id = Location.Location_ID
    WHERE Location.City = 'New York'
);
--5. Find out the number of employees working in the sales department.


SELECT COUNT(*) AS "No of Employees Working in the Sales Department"
FROM Employee
WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%. 

UPDATE Employee
SET Salary = Salary * 1.10
WHERE Job_Id = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');


--7. Delete the employees who are working in the accounting department. 

DELETE FROM Employee
WHERE Department_Id = (SELECT Department_Id FROM Department WHERE Name = 'Accounting');

--8. Display the second highest salary drawing employee details. 

select * from employee;
select * from job;
select * from location;

SELECT E2.Employee_Id, E2.Last_Name, E2.First_Name, E2.Salary
FROM Employee AS E2
WHERE E2.Salary = (
    SELECT MAX(Salary)
    FROM Employee AS E1
    WHERE E1.Salary < (
        SELECT MAX(Salary)
        FROM Employee
    )
);


--9. Display the nth highest salary drawing employee details.

DECLARE @n INT = 3; -- Replace 3 with the desired rank

SELECT Employee_Id, Last_Name, First_Name, Salary
FROM (
    SELECT Employee_Id, Last_Name, First_Name, Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employee
) RankedEmployees
WHERE SalaryRank = @n;

--10. List out the employees who earn more than every employee in department 30.

SELECT Employee_id, First_Name, Last_Name, Department_Id
FROM Employee
WHERE Salary > (SELECT MAX(Salary) FROM Employee WHERE Department_Id = 30);

---11. List out the employees who earn more than the lowest salary in
---department.Find out whose department has no employees.

SELECT E.Employee_Id, E.First_Name, E.Last_Name, E.Salary, E.Department_Id
FROM Employee E
WHERE E.Salary > (
    SELECT MIN(Salary)
    FROM Employee
    WHERE Department_Id = E.Department_Id
);

--12. Find out which department has no employees.

SELECT D.Department_Id, D.Name AS Department_Name
FROM Department D
WHERE D.Department_Id NOT IN (
    SELECT DISTINCT Department_Id
    FROM Employee
);

--13. Find out the employees who earn greater than the average salary for their department.

SELECT E.Employee_Id, E.First_Name, E.Last_Name, E.Salary, E.Department_Id
FROM Employee E
WHERE E.Salary > (
    SELECT AVG(E2.Salary)
    FROM Employee E2
    WHERE E2.Department_Id = E.Department_Id
);
