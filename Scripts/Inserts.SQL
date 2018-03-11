/*Inserts into the Database*/

INSERT INTO Budgets (BudgetID, AmountMoney) VALUES
(001, 200.00),
(002, 300.00),
(003, 400.00),
(004, 500.00),
(005, 600.00),
(006, 600.00),
(007, 600.00);


INSERT INTO UniversityLogic (SystemID, Name, BudgetID) VALUES
(999, 'UniversitatPompeuFabra', 007);

INSERT INTO Spaces (SpaceID, Capacity, Location, SystemID) VALUES
(52001, 40, 'Edifici52-Teoria', 999),
(54002, 40, 'Edifici54-Tallers', 999),
(55001, 10, 'Edifici55-Tanger', 999),
(55002, 10, 'Edifici55-Tanger', 999),
(55003, 10, 'Edifici55-Tanger', 999),
(53001, 5, 'Edifici53-Biblio', 999);

INSERT INTO Offices (SpaceID) VALUES
(55001),
(55002),
(55003);

INSERT INTO LibraryWorkingAreas (SpaceID) VALUES
(53001);

INSERT INTO BookingHours (BookingId, UserID, StartingDate, EndingDate) VALUES
(777, 114130, '2018-03-12', '2018-03-13');

INSERT INTO Classrooms (SpaceID) VALUES
(52001, 'Teoria'),
(54002, 'Seminari');

INSERT INTO Degrees (DegreeId, UserID) VALUES
(222, 114125),
(223, 114126),
(224, 114127);

INSERT INTO TFGs (TFGID, TFGName, Mark, DegreeId, SupervisorId) VALUES
(101, 'MarcTreballa', 0, 222, 114125),
(102, 'MarcAhpavila', 0, 223, 114125),
(103, 'MarcFesFeina', 0, 223, 114125);

INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES
(114125, 'Profe_A', 'Surname_A', CAST('1995-01-21' AS Date), 'UserA@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(114126, 'Profe_B', 'Surname_B', CAST('1994-02-22' AS Date), 'UserB@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(114127, 'Profe_C', 'Surname_C', CAST('1993-03-24' AS Date), 'UserC@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(114128, 'PAS_A', 'Surname_D', CAST('1992-04-27' AS Date), 'UserD@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114129, 'PAS_B', 'Surname_E', CAST('1991-05-29' AS Date), 'UserE@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114130, 'User_F', 'Surname_F', CAST('1990-06-01' AS Date), 'UserF@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114131, 'User_G', 'Surname_G', CAST('1989-07-03' AS Date), 'UserG@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(114132, 'User_H', 'Surname_H', CAST('1988-08-08' AS Date), 'UserH@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(114133, 'User_I', 'Surname_I', CAST('1987-09-11' AS Date), 'UserI@upfinder.edu', CAST('2000-04-01' AS Date), 1),
(114134, 'User_J', 'Surname_J', CAST('1977-10-13' AS Date), 'UserJ@upfinder.edu', CAST('2002-04-01' AS Date), 1),
(114135, 'User_K', 'Surname_K', CAST('1976-11-19' AS Date), 'UserK@upfinder.edu', CAST('2002-04-01' AS Date), 1),
(114136, 'User_L', 'Surname_L', CAST('1975-12-19' AS Date), 'UserL@upfinder.edu', CAST('1999-04-01' AS Date), 1),
(114137, 'User_M', 'Surname_M', CAST('1974-12-14' AS Date), 'UserM@upfinder.edu', CAST('2018-04-01' AS Date), 0);

INSERT INTO Employees (UserID, Salary) VALUES
(114125, 2000),
(114126, 2000),
(114127, 2000),
(114128, 1500),
(114129, 1500);

INSERT INTO PDIs (UserID, DepartmentID, SpaceID, BudgetID, MemberOfGovTeam, LvlOfAccess, Permanent) VALUES
(114125, 303, 55001, 001, 1, 1, 1),
(114126, 303, 55002, 001, 0, 1, 1),
(114127, 303, 55003, 001, 0, 1, 1);

INSERT INTO PASs (UserID, SystemID) VALUES
(114128, 999),
(114129, 999);

INSERT INTO Students (UserID, LvlOfAccess) VALUES
(114130, 0),
(114131, 0),
(114132, 0),
(114133, 0),
(114134, 0),
(114135, 0),
(114136, 0),
(114137, 0);

INSERT INTO WorkingPeriods (PeriodID, StartingDate, EndingDate) VALUES
(0, '2002-04-13', '2003-11-01'),
(1, '2001-06-30', '2004-12-11'),
(2, '2004-10-11', '2007-02-17'),
(3, '2006-10-22', '2007-03-27'),
(4, '2007-05-03', '2010-06-12'),
(5, '2013-11-14', '2017-04-08');

INSERT INTO Courses (CourseID, Name, StartingDate, EndingDate, ECTS) VALUES
(404, 'Càlcul', '2018-01-08', '2018-03-20', 8),
(405, 'Àlgebra', '2018-01-08', '2018-03-20', 8),
(406, 'Física', '2018-01-08', '2018-03-20', 8);

INSERT INTO CourseMaterials (CourseMaterialID, CourseID) VALUES
(01, 404),
(02, 405),
(01, 406);

INSERT INTO ResearchProjects (ProjectId, Name) VALUES
(505, 'ComputerGraphicsResearch'),
(506, 'ComputerGraphicsResearchByDummies'),
(507, 'NotComputerGraphicsResearch');

INSERT INTO ResearchGrants (GrantId, Name, StartDate, EndDate, AmountMoney) VALUES
(707, 'OleTusHuevos', '2018-01-01', '2018-12-31', 1000);

INSERT INTO Publications (PublcationID, Title, PorjectId) VALUES
(808, 'WhyComputerGraphicsMakeMarcStupid', 505),
(809, 'WhyComputerGraphicsMakeMarcStupidToo', 506);

INSERT INTO Departments (DepartmentID, Name, BudgetID, SpaceID) VALUES
(303, 'Graphics', 001, 55001);

INSERT INTO UniversityMaterials (UniversityMaterialID, Name, Availability, StartingDate, EndingDate, SystemID) VALUES
(909, 'Computer', 0, '2018-03-11', '2018-03-12', 999);

INSERT INTO contain (DegreeId, CourseID) VALUES
(222, 404),
(223, 405),
(224, 406);

INSERT INTO doing (CourseID, UserID, Mark) VALUES
(404, 114130, 7),
(405, 114131, 8),
(406, 114132, 0);

INSERT INTO teach (CourseID, UserID) VALUES
(404, 114125),
(405, 114126),
(406, 114127);

INSERT INTO enrolledTo (DegreeId, UserID) VALUES
(222, 114130),
(223, 114131),
(224, 114132);

INSERT INTO contractedIn (UserID, PeriodID) VALUES
(114128, 0),
(114129, 1);

INSERT INTO have (BookingId, SpaceID) VALUES
(777, 53001);

INSERT INTO doResearchIn (UserID, ProjectId, IsPI) VALUES
(114125, 505, 1),
(114126, 506, 1),
(114127, 507, 1);

INSERT INTO areAssociated (GrantId, ProjectId) VALUES
(707, 505);

INSERT INTO areDoneIn (CourseId, SpaceID, StartTime, EndTIme) VALUES
(404, 52001, '2018-03-11', '2018-03-12'),
(405, 54002, '2018-03-12', '2018-03-13'),
(406, 52001, '2018-03-13', '2018-03-14');

INSERT INTO take (UserID, UniversityMaterialID, Order) VALUES
(114130, 909, 1);