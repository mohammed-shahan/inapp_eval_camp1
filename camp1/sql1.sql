--Mohammed Shahan

--Creating a general database for all questions
CREATE DATABASE machineTest
--setting machineTest db as active database
USE machineTest

--Normalising the table into  employee {emp_id, emp_name, pay}
-- department {dept_id, dept_name}
-- emp {emp_id, dept_id}

--creating table employee
CREATE TABLE employee
(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(25),
	pay INT
	);

--creating table department
CREATE TABLE department
(
	dept_id INT  PRIMARY KEY,
	dept_name VARCHAR(25)
	);

--creating table id
CREATE TABLE id
( emp_id INT ,
	dept_id INT
	
	);


--inserting values into employee
INSERT INTO employee VALUES
	(001,'Dilip',3000),
	(002,'Fahad',4000),
	(003,'Lal',6000),
	(004,'Nivin',2000),
	(005,'Vijay',9000),
	(006,'Anu',5000),
	(007,'Nimisha',5000),
	(008,'Praveena',8000)

--inserting values into department
INSERT INTO department VALUES
	(101,'IT'),
	(102,'Sales'),
	(103,'Marketing'),
	(104,'HR')
	
--inserting values into employee
INSERT INTO id VALUES
	(001,101),
	(002,102),
	(003,103),
	(004,101),
	(005,102),
	(006,104),
	(007,102),
	(008,103)

	----------

--1) The total number of employees.SELECT COUNT(*)  AS Total_Employees FROM employee;--2) Total amount required to pay all employees.SELECT SUM(pay) FROM employee;--3) Average, minimum and maximum pay in the organization.SELECT AVG(pay) FROM employee;SELECT MAX(pay) FROM employee;SELECT MIN(pay) FROM employee;--4) Each Department wise total paySELECT department.dept_name,SUM(employee.pay)
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_idGROUP BY dept_name--5) Average, minimum and maximum pay department-wise.SELECT department.dept_name,AVG(employee.pay) AS average,MAX(employee.pay) AS Max,MIN(employee.pay) AS Min
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_idGROUP BY dept_name--6) Employee details who earns the maximum pay.SELECT employee.emp_id,employee.emp_name,employee.pay,department.dept_name
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_idWHERE employee.emp_id= (SELECT employee.emp_id FROM employee WHERE  employee.pay=(SELECT MAX(employee.pay) FROM employee))--7) Employee details who is having a maximum pay in the department.SELECT employee.emp_id,employee.emp_name,employee.pay,department.dept_name
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id --not workingWHERE employee.emp_id= (SELECT employee.emp_id FROM employee WHERE  employee.pay=(SELECT MAX(employee.pay) FROM employee))--10)Unique departments in the companySELECT DISTINCT dept_name FROM department--11)Employees In increasing order of paySELECT * FROM employee ORDER BY pay ASC--12)Department In increasing order of paySELECT department.dept_name, SUM(employee.pay) AS pay
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_idGROUP BY dept_nameORDER BY pay ASC


