/*PART 1*/
/*1. The creation of different users (e.g.: students, teachers, other employees, etc.):*/
delimiter //
CREATE PROCEDURE createUser(IN id INT, IN name VARCHAR(20), IN surname VARCHAR(20), IN birthday DATE, IN email VARCHAR(40), IN startingdate DATE, IN isactive BOOL)
BEGIN
	INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES (id, name, surname, birthday, email, startingdate, isactive)
	ON DUPLICATE KEY UPDATE UserID = id, Name = name, Surname = surname, BirthDate = birthday, Email = email, StartingDate = startingdate, IsActive = isactive;
END //

delimiter //
CREATE PROCEDURE createStudent(IN studentid INT, IN userid INT, IN lvlofaccess VARCHAR(20))
BEGIN
	INSERT INTO Students (StudentID, UserID, LvlOfAccess) VALUES (studentid, userid, lvlofaccess)
	ON DUPLICATE KEY UPDATE StudentID = studentid, UserID = userid, LvlOfAccess = lvlofaccess;
END //

delimiter //
CREATE PROCEDURE createEmployee(IN employeeid INT, IN userid INT, IN salary INT)
BEGIN
	INSERT INTO Employees (EmployeeID, UserID, Salary) VALUES (employeeid, userid, salary)
	ON DUPLICATE KEY UPDATE EmployeeID = employeeid, UserID = userid, Salary = salary;
END //

delimiter //
CREATE PROCEDURE createTeacher(IN pdiid INT, IN employeeid INT, IN departmentid INT, IN officeid INT, IN budgetid INT, IN govteam BOOLEAN, IN lvlofacces VARCHAR(20), IN permanent BOOLEAN)
BEGIN
	INSERT INTO PDIs (pdiID, EmployeeID, DepartmentID, OfficeID, BudgetID, MemberOfGovTeam, LvlOfAccess, Permanent) VALUES (pdiid, employeeid, departmentid, officeid, budgetid, govteam, lvlofaccess, permanent)
	ON DUPLICATE KEY UPDATE pdiID = pdiid, EmployeeID = employeeid, DepartmentID = departmentid, OfficeID = officeid, BudgetID = budgetid, MemberOfGovTeam = govteam, LvlOfAccess = lvlofaccess, Permanent = permanent;
END //

delimiter //
CREATE PROCEDURE createPas(IN pasid INT, IN employeeid INT, IN systemid INT)
BEGIN
	INSERT INTO PASs (pasID, EmployeeID, SystemID) VALUES (pasid, employeeid, systemid)
	ON DUPLICATE KEY UPDATE pasID = pasid, EmployeeID = employeeid, SystemID = systemid;
END //

/*(a) The database design should allow different searches on users, 
such as the list of courses taken by a student, 
the grades obtained during her studies or the
list of courses assigned a teacher.
*/

/*List of Courses Taken by a Student*/
CREATE VIEW `StudentsCourses` AS
SELECT U.UserID, U.Name AS Student, U.Surname, C.Name 
FROM Users U, Courses C, doing d 
WHERE U.UserID = d.UserID AND C.CourseID = d.CourseID;

/*Marks of student courses*/
CREATE VIEW `StudentsMarks` AS
SELECT U.UserID, U.Name AS Student, U.Surname, C.Name, d.Mark 
FROM Users U, Courses C, doing d 
WHERE U.UserID = d.UserID AND C.CourseID = d.CourseID;

/*List of Courses assigned to a teacher*/
CREATE VIEW `PDICourses` AS
SELECT U.Name, U.Surname, U.UserID, C.Name AS Course 
FROM Users AS U INNER JOIN teach AS T ON U.UserID = T.UserID
INNER JOIN Courses AS C ON T.CourseID = C.CourseID;

/*2. Create and manage degrees and courses. This part should at least provide the
following functionalities:*/
delimiter //
CREATE PROCEDURE createDegree(IN degreeid INT, IN userid INT)
BEGIN
	INSERT INTO Degrees (DegreeID, UserID) VALUES (degreeid, userid)
	ON DUPLICATE KEY UPDATE DegreeID = degreeid, UserID = userid;
END //

delimiter //
CREATE PROCEDURE createCourse(IN courseid INT, IN name VARCHAR(40), IN startdate DATE, IN enddate DATE, IN ects INT)
BEGIN
	INSERT INTO Courses (CourseID, Name, StartingDate, EndingDate, ECTS) VALUES (courseid, name, startdate, enddate, ects)
	ON DUPLICATE KEY UPDATE CourseID = courseid, Name = name, StartingDate = startdate, EndingDate = enddate, ECTS = ects;
END //

/*(a) Add and remove users.*/
delimiter //
CREATE PROCEDURE addUser(IN id INT, IN name VARCHAR(20), IN surname VARCHAR(20), IN birthday DATE, IN email VARCHAR(40), IN startingdate DATE, IN isactive BOOL)
BEGIN
	INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES (id, name, surname, birthday, email, startingdate, isactive)
	ON DUPLICATE KEY UPDATE UserID = id, Name = name, Surname = surname, BirthDate = birthday, Email = email, StartingDate = startingdate, IsActive = isactive;
END //

delimiter //
CREATE PROCEDURE deleteUser(IN id INT)
BEGIN
DELETE FROM Users WHERE Users.UserID = id;
END //

/*(b) Upload materials (e.g.: presentations, documents, assignments, etc.) and
administrate the permissions different users have on those documents (who
can upload/read what, deadlines, etc.).*/

/*(c) Assign grades to students (within a course).*/
delimiter //
CREATE PROCEDURE addGrade (IN courseid INT, IN userid INT, IN mark INT)
BEGIN
    INSERT INTO doing (CourseID, UserID, Mark) VALUES (courseid , userid, mark)
    ON DUPLICATE KEY UPDATE CourseID = courseid, UserID = userid, Mark = mark;
END //