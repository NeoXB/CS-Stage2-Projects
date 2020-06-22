/*******************************************************************************
  Foreign key constraints enabled
********************************************************************************/
PRAGMA foreign_keys = ON;

/*******************************************************************************
   Drop Tables
********************************************************************************/
DROP TABLE IF EXISTS [Department];
DROP TABLE IF EXISTS [Employee];

DROP TABLE IF EXISTS [Project];
DROP TABLE IF EXISTS [Project_Assignment];
DROP TABLE IF EXISTS [Salary_Grade];


/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE [Department]
(
  [departmentID] INTEGER NOT NULL,
  [departmentName] VARCHAR(20),
  [location] VARCHAR(20),
    	CONSTRAINT Department_pk PRIMARY KEY([departmentID])
);
CREATE TABLE [Employee]
(
    [employeeID] INTEGER NOT NULL,
	[empName] VARCHAR(25)  NOT NULL,
	[gender] VARCHAR(1)  NOT NULL,
    [jobDescription] VARCHAR(25)  NOT NULL,
	[managerID] INTEGER,
    [hireDate] DATE NOT NULL,
    [salary] NUMERIC(10,2),
    [commission] NUMERIC(10,2),
    [departmentID] INTEGER NOT NULL,
		 CONSTRAINT Employee_pk PRIMARY KEY([employeeID]),
		 CONSTRAINT gender_ch CHECK(gender IN ('M','F')),
		 CONSTRAINT Employee_fk FOREIGN KEY([departmentID]) REFERENCES Department([departmentID])
);

CREATE TABLE [Project]
(
  [projectNo] INTEGER NOT NULL,
  [projectName] VARCHAR(20),
  [projectStartDate] DATE NOT NULL,
  [projectEndDate] DATE NOT NULL,
  [cost] NUMERIC(10,2),
  [departmentID] INTEGER NOT NULL,
	CONSTRAINT Project_pk PRIMARY KEY([projectNo]),
	CONSTRAINT Project_fk FOREIGN KEY([departmentID]) REFERENCES Department([departmentID])
);

CREATE TABLE [Project_Assignment]
(
	[projectNo] INTEGER NOT NULL,
	[employeeID] INTEGER NOT NULL,
	[allocatedHours] INTEGER NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NOT NULL,
	CONSTRAINT Project_Assignment_pk PRIMARY KEY([projectNo], [employeeID]),
	CONSTRAINT Project_Assignment_fk1 FOREIGN KEY([projectNo]) REFERENCES Project([projectNo]),
	CONSTRAINT Project_Assignment_fk2 FOREIGN KEY([employeeID]) REFERENCES Employee([employeeID])
);

CREATE TABLE [Salary_Grade]
(
  [gradeID] INTEGER NOT NULL,
  [minSalary] NUMERIC(10,2),
  [maxSalary] NUMERIC(10,2),
	CONSTRAINT Salary_Grade_pk PRIMARY KEY([gradeID])
);




/*******************************************************************************
   Populate Tables
********************************************************************************/

INSERT INTO [Department] ([departmentID], [departmentName], [location]) VALUES (10, 'ACCOUNTING', "NEW YORK");
INSERT INTO [Department] ([departmentID], [departmentName], [location]) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO [Department] ([departmentID], [departmentName], [location]) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO [Department] ([departmentID], [departmentName], [location]) VALUES (40, 'OPERATIONS', 'BOSTON');


INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7839, 'KING', 'M' ,'president', NULL,  '1998-11-17 00:00:00', 5000, NULL, 10);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7698, 'BLAKE', 'M' ,'manager', 7839, '2014-05-01 00:00:00', 2850 ,NULL, 30);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7782, 'CLARK','M' , 'manager',7839 , '2014-06-09 00:00:00', 2450 , NULL, 10);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7566, 'JONES', 'M' ,'manager', 7839, '2014-04-02 00:00:00', 2975, NULL, 20);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7654, 'MARTIN', 'M' ,'salesman',7698 , '2014-09-28 00:00:00', 1250,1400, 30 );
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7499, 'ALLEN','M' , 'salesman', 7698, '2010-02-20 00:00:00', 1600, 300, 30);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7844, 'TURNER', 'M' ,'salesman',7698 , '2010-09-08 00:00:00', 1500, 0, 30);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7900, 'JAMES','M' , 'clerk', 7698, '2010-03-12 00:00:00', 950 , NULL, 30 );
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7521, 'LOLA','F' , 'salesman',7698 , '2010-02-22 00:00:00', 1250 , 500, 30);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7902, 'FORD', 'M' ,'sales analyst', 7566, '2010-03-12 00:00:00', 3000 , NULL, 20);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7369, 'SMITH', 'M' ,'clerk',7902 , '2000-12-17 00:00:00', 800, NULL, 20);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7788, 'SCOTT','M' , 'analyst', 7566, '2002-12-09 00:00:00', 3000, NULL, 20);
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7876, 'ADAMS', 'M' ,'clerk', 7788, '2002-01-12 00:00:00', 1100, NULL, 20 );
INSERT INTO [Employee] ([employeeID], [empName], [gender], [jobDescription], [managerID],	[hireDate], 	[salary], 	[commission], 	[departmentID]) VALUES (7934, 'MILLER','M' , 'clerk', 7782, '2002-01-23  00:00:00', 1300, NULL, 10 );

INSERT INTO [Project] ([projectNo], [projectName],[projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (101, 'MKTG CAMPAIGN ', '2000-01-01 00:00:00', '2004-12-31 00:00:00', 25000, 30);
INSERT INTO [Project] ([projectNo], [projectName], [projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (102, 'NEW PRODUCT ', '2000-01-01 00:00:00', '2008-12-31 00:00:00', 50000, 30);
INSERT INTO [Project] ([projectNo], [projectName],[projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (103, 'PROCESS REENGINEERING ', '2012-01-01 00:00:00', '2014-12-31 00:00:00', 45000, 40);
INSERT INTO [Project] ([projectNo], [projectName], [projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (104, 'REWARDS PROGRAM ', '2011-01-01 00:00:00', '2013-12-31 00:00:00', 75000, 30);
INSERT INTO [Project] ([projectNo], [projectName],[projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (105, 'IT AUDITING ', '2013-02-13 00:00:00', '2014-11-25 00:00:00', 65000, 10);
INSERT INTO [Project] ([projectNo], [projectName], [projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (106, 'DATA CENTER ', '2013-01-20 00:00:00', '2016-12-17 00:00:00', 68000, 20);
INSERT INTO [Project] ([projectNo], [projectName],[projectStartDate], [projectEndDate], [cost], [departmentID] ) VALUES (107, 'SECURITY MANAGEMENT ', '2014-03-15 00:00:00', '2018-10-25 00:00:00', 95000, 40);




INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (101, 7698, 20, '2000-02-11 00:00:00', '2003-11-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (101, 7654, 25, '2000-03-21 00:00:00', '2003-08-20 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (101, 7900, 20, '2001-04-10 00:00:00', '2002-07-15 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (102, 7782, 20, '2000-01-10 00:00:00', '2004-03-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (102, 7499, 25, '2001-05-18 00:00:00', '2006-06-17 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (102, 7369, 35, '2002-12-04 00:00:00', '2008-11-25 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (103, 7566, 20, '2012-02-12 00:00:00', '2012-11-21 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (103, 7844, 20, '2013-01-18 00:00:00', '2014-12-20 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (103, 7934, 10, '2012-11-26 00:00:00', '2013-03-17 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (104, 7566, 20, '2011-02-12 00:00:00', '2012-10-20 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (104, 7876, 10, '2011-04-19 00:00:00', '2013-11-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (104, 7654, 15, '2012-01-21 00:00:00', '2013-12-25 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (105, 7521, 20, '2013-02-11 00:00:00', '2014-11-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (105, 7876, 10, '2013-03-21 00:00:00', '2013-12-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (105, 7499, 10, '2013-02-16 00:00:00', '2014-11-25 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (106, 7900, 20, '2013-02-21 00:00:00', '2016-10-20 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (106, 7698, 10, '2013-11-12 00:00:00', '2015-03-28 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (106, 7902, 15, '2014-01-10 00:00:00', '2016-11-25 00:00:00');

INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (107, 7521, 20, '2015-02-21 00:00:00', '2017-11-28 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (107, 7788, 10, '2014-03-17 00:00:00', '2018-07-25 00:00:00');
INSERT INTO [Project_Assignment] ([projectNo], [employeeID],  [allocatedHours], [startDate], [endDate]) VALUES (107, 7902, 15, '2015-04-11 00:00:00', '2018-10-25 00:00:00');

INSERT INTO [Salary_Grade] ([gradeID], [minSalary], [maxSalary]) VALUES (1, 700, 1200);
INSERT INTO [Salary_Grade] ([gradeID], [minSalary], [maxSalary]) VALUES (2, 1201, 1400);
INSERT INTO [Salary_Grade] ([gradeID], [minSalary], [maxSalary]) VALUES (3, 1401, 2000);
INSERT INTO [Salary_Grade] ([gradeID], [minSalary], [maxSalary]) VALUES (4, 2001, 3000);
INSERT INTO [Salary_Grade] ([gradeID], [minSalary], [maxSalary]) VALUES (5, 3001, 9999);


