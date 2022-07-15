use machineTest

--creating employee table
CREATE TABLE empTable (
 empNo INT PRIMARY KEY,
 eName VARCHAR(25),
 job VARCHAR(25),
 manager INT,
 hireDate DATE,
 SAL INT,
 commission INT,
 deptNo INT
 );

 --creating department table
 CREATE TABLE deprt(
 deprtNo INT PRIMARY KEY,
 dname VARCHAR(25),
 loc VARCHAR(25)
 );

 INSERT INTO empTable VALUES
 (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10),
 (7698,'BLAKE','MANAGER',7839,'1981-01-05',2850,NULL,30),
 (7782,'CLARK','MANAGER',7839,'1981-09-06',2450,NULL,10),
 (7566,'JONES','MANAGER',7839,'1981-02-04',2975,NULL,20),
 (7788,'SCOTT','ANALYST',7566,'1982-09-12',3000,NULL,20),
 (7902,'FORD','ANALYST',7566,'1981-03-12',3000,NULL,20),
 (7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20),
 (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30),
 (7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30),
 (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30),
 (7844,'TURNER','SALESMAN',7698,'1981-08-09',1500,NULL,30),
 (7876,'ADAMS','CLERK',7788,'1983-01-12',1100,NULL,30),
 (7900,'JAMES','CLERK',7698,'1981-03-12',950,NULL,20),
 (7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10)

 --inserting values into department table
 INSERT INTO deprt VALUES
 (10,'Accounting','New York'),
 (20,'Research','Dallas'),
 (30,'Sales','Chicago'),
 (40,'Operations','Boston');

 

 --1. Report needed: Names of employees who are manager. --2.List the name of all employees along with their department name and Annual
--Income.For each row get the output in the form ‘Every Year Mark of Accounts department 
--4. Find out employee name and departmentname of employees who either works in a Toy
--or Shoe department.

--question was wrong but changed the value to get response

SELECT empTable.eName,deprt.dname
FROM empTable
INNER JOIN deprt
ON empTable.deptNo = deprt.deprtNo
WHERE dname IN ('Sales','Research')

--5. Report needed: Name concatenated with department, separated by comma and space
--and name column Employee and department.SELECT CONCAT (empTable.eName,', ',deprt.dname) AS Name_and_Department
FROM empTable
INNER JOIN deprt
ON empTable.deptNo = deprt.deprtNo
--6. Write a query to display name, job, department number and department name for
--all employees who work in DALLAS.SELECT empTable.eName,empTable.job,empTable.deptNo,deprt.dname
FROM empTable
INNER JOIN deprt
ON empTable.deptNo = deprt.deprtNo
WHERE loc IN ('Dallas')

--7. List the names of all employees along with name of managers
SELECT t1.empNo, t2.eName AS employee,t1.eName AS Manager
FROM empTable t1,empTable t2
WHERE t1.empNo = t2.manager

--8. Display all employee name, manager number and manager name of all employees
--including King who have no manager.SELECT * FROM empTable WHERE manager IS NULL --not a valid question, but similar answer