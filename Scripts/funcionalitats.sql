/*1. The creation of different users (e.g.: students, teachers, other employees, etc.):*/
delimiter //
CREATE PROCEDURE createUser (IN id INT, IN name VARCHAR(20), IN surname VARCHAR(20), IN birthday DATE, IN email VARCHAR(40), IN startingdate DATE, IN isactive BOOL)
BEGIN
	INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES (id, name, surname, birthday, email, startingdate, isactive)
	ON DUPLICATE KEY UPDATE UserID = id, Name = name, Surname = surname, BirthDate = birthday, Email = email, StartingDate = startingdate, IsActive = isactive;
END //

delimiter //
CREATE PROCEDURE createStudent (IN studentid INT, IN userid INT, IN lvlofaccess VARCHAR(20))
BEGIN
	INSERT INTO Students (StudentID, UserID, LvlOfAccess) VALUES (studentid, userid, lvlofaccess)
	ON DUPLICATE KEY UPDATE StudentID = studentid, UserID = userid, LvlOfAccess = lvlofaccess;
END //

delimiter //
CREATE PROCEDURE createEmployee (IN employeeid INT, IN userid INT, IN salary INT)
BEGIN
	INSERT INTO Employees (EmployeeID, UserID, Salary) VALUES (employeeid, userid, salary)
	ON DUPLICATE KEY UPDATE EmployeeID = employeeid, UserID = userid, Salary = salary;
END //

delimiter //
CREATE PROCEDURE createTeacher (IN pdiid INT, IN employeeid INT, IN departmentid INT, IN officeid INT, IN budgetid INT, IN govteam BOOLEAN, IN lvlofacces VARCHAR(20), IN permanent BOOLEAN)
BEGIN
	INSERT INTO PDIs (pdiID, EmployeeID, DepartmentID, OfficeID, BudgetID, MemberOfGovTeam, LvlOfAccess, Permanent) VALUES (pdiid, employeeid, departmentid, officeid, budgetid, govteam, lvlofaccess, permanent)
	ON DUPLICATE KEY UPDATE pdiID = pdiid, EmployeeID = employeeid, DepartmentID = departmentid, OfficeID = officeid, BudgetID = budgetid, MemberOfGovTeam = govteam, LvlOfAccess = lvlofaccess, Permanent = permanent;
END //

delimiter //
CREATE PROCEDURE createPas (IN pasid INT, IN employeeid INT, IN systemid INT)
BEGIN
	INSERT INTO PASs (pasID, EmployeeID, SystemID) VALUES (pasid, employeeid, systemid)
	ON DUPLICATE KEY UPDATE pasID = pasid, EmployeeID = employeeid, SystemID = systemid;
END //

delimiter //
CREATE PROCEDURE deleteUser (IN id INT)
BEGIN
	DELETE FROM Users WHERE Users.UserID = id;
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
CREATE PROCEDURE createDegree (IN degreeid INT, IN userid INT)
BEGIN
	INSERT INTO Degrees (DegreeID, UserID) VALUES (degreeid, userid)
	ON DUPLICATE KEY UPDATE DegreeID = degreeid, UserID = userid;
END //

delimiter //
CREATE PROCEDURE createCourse (IN courseid INT, IN name VARCHAR(40), IN startdate DATE, IN enddate DATE, IN ects INT)
BEGIN
	INSERT INTO Courses (CourseID, Name, StartingDate, EndingDate, ECTS) VALUES (courseid, name, startdate, enddate, ects)
	ON DUPLICATE KEY UPDATE CourseID = courseid, Name = name, StartingDate = startdate, EndingDate = enddate, ECTS = ects;
END //

delimiter //
CREATE PROCEDURE deleteDegree (IN degreeid INT)
BEGIN
	DELETE FROM Degrees WHERE Degrees.DegreeID = degreeid;
END //

delimiter //
CREATE PROCEDURE deleteCourse (IN courseid INT)
BEGIN
	DELETE FROM Courses WHERE Courses.CourseID = courseid;
END //

/*(a) Add and remove users.*/
delimiter //
CREATE PROCEDURE deleteUserFromCourse (IN userid INT, IN courseToRemoveFrom INT)
BEGIN
	DELETE FROM doing WHERE doing.CourseID = courseToRemoveFrom AND doing.UserID = userid;
END //

delimiter //
CREATE PROCEDURE addUserToCourse (IN courseid INT, IN userid INT, IN mark INT)
BEGIN
    INSERT INTO doing (CourseID, UserID, Mark) VALUES (courseid , userid, mark)
    ON DUPLICATE KEY UPDATE CourseID = courseid, UserID = userid, Mark = mark;
END //

delimiter //
CREATE PROCEDURE addUserToDegree (IN degreeid INT, IN userid INT)
BEGIN
	INSERT INTO enrolledTo (DegreeID, UserID) VALUES (degreeid, userid)
	ON DUPLICATE KEY UPDATE DegreeID = degreeid, UserID = userid;
END //

delimiter //
CREATE PROCEDURE deleteUserFromDegree (IN userid INT, IN degreeToRemoveFrom INT)
BEGIN
	DELETE FROM enrolledTo WHERE enrolledTo.DegreeID = degreeToRemoveFrom AND enrolledTo.UserID = userid;
END //

/*(b) Upload materials (e.g.: presentations, documents, assignments, etc.) and
administrate the permissions different users have on those documents (who
can upload/read what, deadlines, etc.).*/

delimiter //
CREATE PROCEDURE uploadMaterial (IN userid INT, IN materialid INT, IN courseid INT, IN name VARCHAR(45), IN format VARCHAR(45), IN size INT)
BEGIN
	IF userid IN (SELECT PDIs.pdiID FROM PDIs WHERE PDIs.pdiID = userid AND PDIs.LvlOfAccess = 'Upload') THEN
		INSERT INTO CourseMaterials (CourseMaterialID, CourseID, Name, Format, Size) VALUES (materialid, courseid, name, format, size)
		ON DUPLICATE KEY UPDATE CourseMaterialID = materialid, CourseID = courseid, Name = name, Format = format, Size = size;
	ELSEIF userid IN (SELECT Students.StudentID FROM Students WHERE Students.StudentID = userid AND Students.LvlOfAccess = 'Upload') THEN
		INSERT INTO CourseMaterials (CourseMaterialID, CourseID, Name, Format, Size) VALUES (materialid, courseid, name, format, size)
		ON DUPLICATE KEY UPDATE CourseMaterialID = materialid, CourseID = courseid, Name = name, Format = format, Size = size;
	END IF;
END //

delimiter //
CREATE PROCEDURE changePermissionForUser (IN userid INT, IN newPermission VARCHAR(20))
BEGIN
	IF userid IN (SELECT PDIs.pdiID FROM PDIs WHERE PDIs.pdiID = userid) THEN
		UPDATE PDIs SET LvlOfAccess = newPermission WHERE PDIs.pdiID = userid;
	ELSEIF userid IN (SELECT Students.StudentID FROM Students WHERE Students.StudentID = userid) THEN
		UPDATE Students SET LvlOfAccess = newPermission WHERE Students.StudentID = userid;
	END IF;
END //

/*(c) Assign grades to students (within a course).*/
delimiter //
CREATE PROCEDURE addGrade (IN courseid INT, IN userid INT, IN mark INT)
BEGIN
    INSERT INTO doing (CourseID, UserID, Mark) VALUES (courseid , userid, mark)
    ON DUPLICATE KEY UPDATE Mark = mark;
END //

/*3. Management of physical spaces and material:*/

/*(a) Classrooms (regular rooms, seminar rooms, computer labs, etc.) and a way
to reserve/assign them.*/

/*(b) Offices and other spaces.*/

/*(c) Material loan: books, computers, films, etc..*/

/*4. Budget management:*/

/*(a) The database must represent the amount of money associated with (a) each
department and (b) the university.*/

/*(b) Each PDI must have access to its personal budget, which corresponds to the
amount of money obtained through grants.*/

/*(c) The database must store the information related to research grants and the
different research projects.*/