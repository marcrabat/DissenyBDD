/*
The creation of different users (e.g.: students, teachers, other employees, etc.):
*/
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

INSERT INTO Offices (OfficeID, SpaceID) VALUES
(55001, 55001),
(55002, 55002),
(55003, 55003);

INSERT INTO LibraryWorkingAreas (LibraryWorkingAreaID, SpaceID) VALUES
(53001, 53001);

INSERT INTO Classrooms (ClassroomID, SpaceID, Kind) VALUES
(52001, 52001, 'Teoria'),
(54002, 54002, 'Seminari');

INSERT INTO Degrees (DegreeId, UserID, Name) VALUES
(222, 114125, 'Enginyeria Informàtica'),
(223, 114126, 'Enginyeria Telemàtica'),
(224, 114127, 'Enginyeria Biomèdica');

INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES
(114125, 'Profe_A', 'Profe_Surname_A', CAST('1964-01-21' AS Date), 'Profe_A@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(114126, 'Profe_B', 'Profe_Surname_B', CAST('1970-02-22' AS Date), 'Profe_B@upfinder.edu', CAST('2016-04-01' AS Date), 0),
(114127, 'Profe_C', 'Profe_Surname_C', CAST('1983-03-24' AS Date), 'Profe_C@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(114128, 'PAS_A', 'PAS_Surname_D', CAST('1972-04-27' AS Date), 'PAS_A@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114129, 'PAS_B', 'PAS_Surname_E', CAST('1981-05-29' AS Date), 'PAS_B@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114130, 'Student_A', 'Student_Surname_A', CAST('1990-06-01' AS Date), 'Student_A@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(114131, 'Student_B', 'Student_Surname_B', CAST('1989-07-03' AS Date), 'Student_B@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(114132, 'Student_C', 'Student_Surname_C', CAST('1988-08-08' AS Date), 'Student_C@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(114133, 'Student_D', 'Student_Surname_D', CAST('1987-09-11' AS Date), 'Student_D@upfinder.edu', CAST('2000-04-01' AS Date), 0),
(114134, 'Student_E', 'Student_Surname_E', CAST('1987-10-13' AS Date), 'Student_E@upfinder.edu', CAST('2002-04-01' AS Date), 0),
(114135, 'Student_F', 'Student_Surname_F', CAST('1986-11-19' AS Date), 'Student_F@upfinder.edu', CAST('2002-04-01' AS Date), 1),
(114136, 'Student_G', 'Student_Surname_G', CAST('1985-12-19' AS Date), 'Student_G@upfinder.edu', CAST('1999-04-01' AS Date), 1),
(114137, 'Student_H', 'Student_Surname_H', CAST('1984-12-14' AS Date), 'Student_H@upfinder.edu', CAST('2018-04-01' AS Date), 1);

INSERT INTO Employees (EmployeeID, UserID, Salary) VALUES
(114125, 114125, 2000),
(114126, 114126, 2000),
(114127, 114127, 2000),
(114128, 114128, 1500),
(114129, 114129, 1500);

INSERT INTO PASs (pasID, EmployeeID, SystemID) VALUES
(114128, 114128, 999),
(114129, 114129, 999);

INSERT INTO Students (StudentID, UserID, LvlOfAccess) VALUES
(114130, 114130, 'Read'),
(114131, 114131, 'Read'),
(114132, 114132, 'Read'),
(114133, 114133, 'Read'),
(114134, 114134, 'Read'),
(114135, 114135, 'Read'),
(114136, 114136, 'Read'),
(114137, 114137, 'Read');

INSERT INTO BookingHours (BookingId, UserID, StartingDate, EndingDate) VALUES
(777, 114130, '2018-03-12', '2018-03-13');

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

INSERT INTO CourseMaterials (CourseMaterialID, CourseID, Name, Format, Size) VALUES
(01, 404, 'Polinomis de Taylor', '.pdf', 16),
(02, 405, 'Espais Vectorials', '.docx', 32),
(03, 406, 'Electromagnetisme', '.txt', 4);

INSERT INTO ResearchProjects (ProjectId, Name) VALUES
(505, 'ComputerGraphicsResearch'),
(506, 'ComputerGraphicsResearchByDummies'),
(507, 'NotComputerGraphicsResearch');

INSERT INTO ResearchGrants (GrantId, Name, StartDate, EndDate, AmountMoney) VALUES
(707, 'OleTusHuevos', '2018-01-01', '2018-12-31', 1000);

INSERT INTO Publications (PublicationID, Title, ProjectId) VALUES
(808, 'WhyComputerGraphicsMakeMarcStupid', 505),
(809, 'WhyComputerGraphicsMakeMarcStupidToo', 506);

INSERT INTO Departments (DepartmentID, Name, BudgetID, OfficeID) VALUES
(303, 'Graphics', 001, 55001);

INSERT INTO PDIs (pdiID, EmployeeID, DepartmentID, OfficeID, BudgetID, MemberOfGovTeam, LvlOfAccess, Permanent) VALUES
(114125, 114125, 303, 55001, 001, 1, 'Upload', 1),
(114126, 114126, 303, 55002, 001, 0, 'Upload', 1),
(114127, 114127, 303, 55003, 001, 0, 'Upload', 1);

INSERT INTO TFGs (TFGID, TFGName, Mark, DegreeId, SupervisorId) VALUES
(101, 'MarcTreballa', 0, 222, 114125),
(102, 'MarcAhpavila', 0, 223, 114125),
(103, 'MarcFesFeina', 0, 223, 114125);

INSERT INTO UniversityMaterials (UniversityMaterialID, Name, Availability, StartingDate, EndingDate, SystemID) VALUES
(909, 'Computer', 0, '2018-03-11', '2018-03-12', 999);

INSERT INTO contain (DegreeId, CourseID) VALUES
(222, 404),
(223, 405),
(224, 406);

INSERT INTO doing (CourseID, UserID, Mark) VALUES
(404, 114130, 7),
(405, 114131, 8),
(406, 114132, 10);

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

INSERT INTO have (BookingId, LibraryWorkingAreaID) VALUES
(777, 53001);

INSERT INTO doResearchIn (UserID, ProjectId, IsPI) VALUES
(114125, 505, 1),
(114126, 506, 1),
(114127, 507, 1);

INSERT INTO areAssociated (GrantId, ProjectId) VALUES
(707, 505);

INSERT INTO areDoneIn (CourseId, ClassroomID, StartTime, EndTime) VALUES
(404, 52001, '2018-03-11', '2018-03-12'),
(405, 54002, '2018-03-12', '2018-03-13'),
(406, 52001, '2018-03-13', '2018-03-14');

INSERT INTO take (UserID, UniversityMaterialID, OrderToTake) VALUES
(114130, 909, 1);