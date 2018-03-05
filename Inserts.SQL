/*Creation of Database*/

/*TODO: INSERTIONS TO THE TABLES*/

(0, 'User_A', 'Surname_A', CAST('1995-01-21' AS Date), 'UserA@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(1, 'User_B', 'Surname_B', CAST('1994-02-22' AS Date), 'UserB@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(2, 'User_C', 'Surname_C', CAST('1993-03-24' AS Date), 'UserC@upfinder.edu', CAST('2016-04-01' AS Date), 1),
(3, 'User_D', 'Surname_D', CAST('1992-04-27' AS Date), 'UserD@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(5, 'User_F', 'Surname_F', CAST('1990-06-01' AS Date), 'UserF@upfinder.edu', CAST('2017-04-01' AS Date), 1),
(6, 'User_G', 'Surname_G', CAST('1989-07-03' AS Date), 'UserG@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(7, 'User_H', 'Surname_H', CAST('1988-08-08' AS Date), 'UserH@upfinder.edu', CAST('2012-04-01' AS Date), 1),
(8, 'User_I', 'Surname_I', CAST('1987-09-11' AS Date), 'UserI@upfinder.edu', CAST('2000-04-01' AS Date), 1),
(9, 'User_J', 'Surname_J', CAST('1977-10-13' AS Date), 'UserJ@upfinder.edu', CAST('2002-04-01' AS Date), 1),
(10, 'User_K', 'Surname_K', CAST('1976-11-19' AS Date), 'UserK@upfinder.edu', CAST('2002-04-01' AS Date), 1),
(11, 'User_L', 'Surname_L', CAST('1975-12-19' AS Date), 'UserL@upfinder.edu', CAST('1999-04-01' AS Date), 1),
(12, 'User_M', 'Surname_M', CAST('1974-12-14' AS Date), 'UserM@upfinder.edu', CAST('2018-04-01' AS Date), 1);

INSERT INTO Students (UserID, Degree, Course, LvlOfAccess) VALUES
/*No em queden clars els atributs d'aquesta talua. Un estudiant pot tenir diversos degree, aleshores aquí pot aparèixer dos cops un estudiant pero amb diferent degree?*/
(0, 'EngInf', '', 1),
(1, 'EngInf', '', 1),
(2, 'EngInf', '', 1),
(3, 'EngInf', '', 1),
(4, 'EngSistAudio', '', 1),
(5, 'EngSistAudio', '', 1),
(6, 'EngBio', '', 1);

INSERT INTO WorkingPeriods (PeriodID, StartingDate, EndingDate) VALUES
(0, '2002-04-13', '2003-11-01'),
(1, '2001-06-30', '2004-12-11'),
(2, '2004-10-11', '2007-02-17'),
(3, '2006-10-22', '2007-03-27'),
(4, '2007-05-03', '2010-06-12'),
(5, '2013-11-14', '2017-04-08');

INSERT INTO Employees (UserID, Salary, PeriodID) VALUES
(8, 2000, 2),
(9, 1000, 1),
(10, 1500, 3),
(11, 2000, 4),
(12, 2500, 5);

INSERT INTO PDIs (UserID, Course, Department, LvlOfAccess, IsMemberOfGovTeam) VALUES
/*Mateix dubte taula students*/
(8, '', '', , 0),
(9, '', '', , 1),
(10, '', '', , 1);