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

--1) The total number of employees.
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id --not working
FROM employee
INNER JOIN id ON employee.emp_id = id.emp_id
INNER JOIN department ON id.dept_id = department.dept_id

