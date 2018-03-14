/***MINIMUM REQUIERMENTS***/
delimiter //
CREATE PROCEDURE createUser (IN id INT, IN name VARCHAR(20), IN surname VARCHAR(20), IN birthday DATE, IN email VARCHAR(40), IN startingdate DATE, IN isactive BOOL)
BEGIN
	INSERT INTO Users (UserID, Name, Surname, BirthDate, Email, StartingDate, IsActive) VALUES (id, name, surname, birthday, email, startingdate, isactive)
	ON DUPLICATE KEY UPDATE UserID = id, Name = name, Surname = surname, BirthDate = birthday, Email = email, StartingDate = startingdate, IsActive = isactive;
END; //

delimiter //
CREATE PROCEDURE createStudent (IN studentid INT, IN userid INT, IN lvlofaccess VARCHAR(20))
BEGIN
	INSERT INTO Students (StudentID, UserID, LvlOfAccess) VALUES (studentid, userid, lvlofaccess)
	ON DUPLICATE KEY UPDATE StudentID = studentid, UserID = userid, LvlOfAccess = lvlofaccess;
END; //

delimiter //
CREATE PROCEDURE createEmployee (IN employeeid INT, IN userid INT, IN salary INT)
BEGIN
	INSERT INTO Employees (EmployeeID, UserID, Salary) VALUES (employeeid, userid, salary)
	ON DUPLICATE KEY UPDATE EmployeeID = employeeid, UserID = userid, Salary = salary;
END; //

delimiter //
CREATE PROCEDURE createTeacher (IN pdiid INT, IN employeeid INT, IN departmentid INT, IN officeid INT, IN budgetid INT, IN govteam BOOLEAN, IN lvlofacces VARCHAR(20), IN permanent BOOLEAN)
BEGIN
	INSERT INTO PDIs (pdiID, EmployeeID, DepartmentID, OfficeID, BudgetID, MemberOfGovTeam, LvlOfAccess, Permanent) VALUES (pdiid, employeeid, departmentid, officeid, budgetid, govteam, lvlofaccess, permanent)
	ON DUPLICATE KEY UPDATE pdiID = pdiid, EmployeeID = employeeid, DepartmentID = departmentid, OfficeID = officeid, BudgetID = budgetid, MemberOfGovTeam = govteam, LvlOfAccess = lvlofaccess, Permanent = permanent;
END; //

delimiter //
CREATE PROCEDURE createPas (IN pasid INT, IN employeeid INT, IN systemid INT)
BEGIN
	INSERT INTO PASs (pasID, EmployeeID, SystemID) VALUES (pasid, employeeid, systemid)
	ON DUPLICATE KEY UPDATE pasID = pasid, EmployeeID = employeeid, SystemID = systemid;
END; //

delimiter //
CREATE PROCEDURE deleteUser (IN id INT)
BEGIN
	DELETE FROM Users WHERE Users.UserID = id;
END; //

delimiter //
CREATE PROCEDURE createDegree (IN degreeid INT, IN userid INT, IN name VARCHAR(45))
BEGIN
	INSERT INTO Degrees (DegreeID, UserID, Name) VALUES (degreeid, userid, name)
	ON DUPLICATE KEY UPDATE DegreeID = degreeid, UserID = userid, Name = name;
END; //

delimiter //
CREATE PROCEDURE createCourse (IN courseid INT, IN name VARCHAR(40), IN startdate DATE, IN enddate DATE, IN ects INT)
BEGIN
	INSERT INTO Courses (CourseID, Name, StartingDate, EndingDate, ECTS) VALUES (courseid, name, startdate, enddate, ects)
	ON DUPLICATE KEY UPDATE CourseID = courseid, Name = name, StartingDate = startdate, EndingDate = enddate, ECTS = ects;
END; //

delimiter //
CREATE PROCEDURE deleteDegree (IN degreeid INT)
BEGIN
	DELETE FROM Degrees WHERE Degrees.DegreeID = degreeid;
END; //

delimiter //
CREATE PROCEDURE deleteCourse (IN courseid INT)
BEGIN
	DELETE FROM Courses WHERE Courses.CourseID = courseid;
END; //

delimiter //
CREATE PROCEDURE deleteUserFromCourse (IN userid INT, IN courseToRemoveFrom INT)
BEGIN
	DELETE FROM doing WHERE doing.CourseID = courseToRemoveFrom AND doing.UserID = userid;
END; //

delimiter //
CREATE PROCEDURE addUserToCourse (IN courseid INT, IN userid INT, IN mark INT)
BEGIN
    INSERT INTO doing (CourseID, UserID, Mark) VALUES (courseid , userid, mark)
    ON DUPLICATE KEY UPDATE CourseID = courseid, UserID = userid, Mark = mark;
END; //

delimiter //
CREATE PROCEDURE addUserToDegree (IN degreeid INT, IN userid INT)
BEGIN
	INSERT INTO enrolledTo (DegreeID, UserID) VALUES (degreeid, userid)
	ON DUPLICATE KEY UPDATE DegreeID = degreeid, UserID = userid;
END; //

delimiter //
CREATE PROCEDURE deleteUserFromDegree (IN userid INT, IN degreeToRemoveFrom INT)
BEGIN
	DELETE FROM enrolledTo WHERE enrolledTo.DegreeID = degreeToRemoveFrom AND enrolledTo.UserID = userid;
END; //

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
END; //

delimiter //
CREATE PROCEDURE changePermissionForUser (IN userid INT, IN newPermission VARCHAR(20))
BEGIN
	IF userid IN (SELECT PDIs.pdiID FROM PDIs WHERE PDIs.pdiID = userid) THEN
		UPDATE PDIs SET LvlOfAccess = newPermission WHERE PDIs.pdiID = userid;
	ELSEIF userid IN (SELECT Students.StudentID FROM Students WHERE Students.StudentID = userid) THEN
		UPDATE Students SET LvlOfAccess = newPermission WHERE Students.StudentID = userid;
	END IF;
END; //

delimiter //
CREATE PROCEDURE addGrade (IN courseid INT, IN userid INT, IN mark INT)
BEGIN
    INSERT INTO doing (CourseID, UserID, Mark) VALUES (courseid , userid, mark)
    ON DUPLICATE KEY UPDATE Mark = mark;
END; //

delimiter //
CREATE PROCEDURE createSpace (IN spaceid INT, IN capacity INT, IN location VARCHAR(20), IN systemid INT)
BEGIN
	INSERT INTO Spaces (SpaceID, Capacity, Location, SystemID) VALUES (spaceid, capacity, location, systemid)
	ON DUPLICATE KEY UPDATE SpaceID = spaceid, Capacity = capacity, Location = location, SystemID = systemid;
END; //

delimiter //
CREATE PROCEDURE createClassroom (IN classroomid INT, IN spaceid INT, IN kind VARCHAR(20))
BEGIN
	INSERT INTO Classrooms (ClassroomID, SpaceID, Kind) VALUES (classroomid, spaceid, kind)
	ON DUPLICATE KEY UPDATE ClassroomID = classroomid, SpaceID = spaceid, Kind = kind;
END; //

delimiter //
CREATE PROCEDURE assignCourseToClassroom (IN courseid INT, IN classroomid INT, IN starttime DATE, IN endtime DATE)
BEGIN
	INSERT INTO areDoneIN (CourseID, ClassroomID, StartTime, EndTime) VALUES (courseid, classroomid, starttime, endtime)
	ON DUPLICATE KEY UPDATE CourseID = courseid, ClassroomID = classroomid, StartTime = starttime, EndTime = endtime;
END; //

delimiter //
CREATE PROCEDURE createOffice (IN officeid INT, IN spaceid INT)
BEGIN
	INSERT INTO Offices (OfficeID, SpaceID) VALUES (officeid, spaceid)
	ON DUPLICATE KEY UPDATE OfficeID = officeid, SpaceID = spaceid;
END; //

delimiter //
CREATE PROCEDURE assignOfficeToPdi (IN pdiid INT, IN officeid INT)
BEGIN
	UPDATE PDIs SET OfficeID = officeid WHERE PDIs.pdiID = pdiid;
END; //

delimiter //
CREATE PROCEDURE assignOfficeToDepartment (IN departmentid INT, IN officeid INT)
BEGIN
	UPDATE Departments SET OfficeID = officeid WHERE Departments.DepartmentID = departmentid;
END; //

delimiter //
CREATE PROCEDURE createLibraryWorkingArea (IN libid INT, IN spaceid INT)
BEGIN
	INSERT INTO LibraryWorkingAreas (LibraryWorkingAreaID, SpaceID) VALUES (libid, spaceid)
	ON DUPLICATE KEY UPDATE LibraryWorkingAreaID = libid, SpaceID = spaceid;
END; //

delimiter //
CREATE PROCEDURE bookLibraryWorkingArea (IN userid INT, IN bookingid INT, IN startdate DATE, IN enddate DATE, IN libid INT)
BEGIN
	IF libid IN (SELECT LibraryWorkingAreas.LibraryWorkingAreaID FROM LibraryWorkingAreas) THEN
		INSERT INTO BookingHours (BookingId, UserID, StartingDate, EndingDate) VALUES (bookingid, userid, startdate, enddate)
		ON DUPLICATE KEY UPDATE BookingId = bookingid, UserID = userid, StartingDate = startdate, EndingDate = enddate;

		INSERT INTO have (BookingId, LibraryWorkingAreaID) VALUES (bookingid, libid)
		ON DUPLICATE KEY UPDATE BookingId = bookingid, LibraryWorkingAreaID = libid;
	END IF;
END; //

delimiter //
CREATE PROCEDURE createMaterial (IN materialid INT, IN name VARCHAR(20), IN availability BOOLEAN, IN startdate DATE, IN enddate DATE, IN systemid INT)
BEGIN
	INSERT INTO UniversityMaterials (UniversityMaterialID, Name, Availability, StartingDate, EndingDate, SystemID) VALUES (materialid, name, availability, startdate, enddate, systemid)
	ON DUPLICATE KEY UPDATE UniversityMaterialID = materialid, Name = name, Availability = availability, StartingDate = startdate, EndingDate = enddate, SystemID = systemid;
END; //

delimiter //
CREATE PROCEDURE bookMaterial (IN userid INT, IN materialid INT, IN ordertotake INT)
BEGIN
	INSERT INTO take (UserID, UniversityMaterialID, OrderToTake) VALUES (userid, materialid, ordertotake)
	ON DUPLICATE KEY UPDATE UserID = userid, UniversityMaterialID = materialid, OrderToTake = OrderToTake;
END; //

/***Constraints solutions***/
delimiter //
CREATE TRIGGER checkTwoCoursesSameUpdate BEFORE UPDATE ON areDoneIn FOR EACH ROW
BEGIN

	IF new.StartTime IN (SELECT areDoneIn.StartTime FROM areDoneIn WHERE new.ClassroomID = areDoneIn.ClassroomID) THEN
		signal sqlstate '45000' set message_text = 'No pots afegir una classe en aquesta franja horaria i aula';
	END IF;
END; //

delimiter //
CREATE TRIGGER checkTwoCoursesSameInsert BEFORE INSERT ON areDoneIn FOR EACH ROW
BEGIN

	IF new.StartTime IN (SELECT areDoneIn.StartTime FROM areDoneIn WHERE new.ClassroomID = areDoneIn.ClassroomID) THEN
		signal sqlstate '45000' set message_text = 'No pots afegir una classe en aquesta franja horaria i aula';
	END IF;
END; //

delimiter //
CREATE TRIGGER checkTwoCoursesSameTimeForPdi BEFORE INSERT ON teach FOR EACH ROW
BEGIN
	DECLARE classTime DATETIME;

	IF EXISTS (SELECT areDoneIn.StartTime FROM areDoneIn JOIN teach WHERE areDoneIn.CourseID = teach.CourseID AND teach.UserID = new.UserID) THEN
		signal sqlstate '45000' set message_text = 'El PDI no pot tenir més de una classe a la mateixa hora';
	END IF;
END; //

delimiter //
CREATE TRIGGER bookNoLongerFourHours BEFORE INSERT ON BookingHours FOR EACH ROW
BEGIN
	DECLARE maxTime DATETIME;
	SET maxTime = ADDTIME(new.StartingDate, '4:00:00.00');

	IF new.EndingDate > maxTime THEN
		signal sqlstate '45000' set message_text = 'No pots reservar una aula per més de 4 hores';
	END IF;
END; //

delimiter //
CREATE PROCEDURE checkIfStudentPassDegree(IN userid INT)
BEGIN
	IF EXISTS (SELECT doing.Mark FROM Courses JOIN Degrees JOIN contain JOIN enrolledTo JOIN doing WHERE contain.DegreeID = Degrees.DegreeID AND enrolledTo.UserID = userid AND enrolledTo.DegreeID = Degrees.DegreeID AND doing.UserID = userid AND doing.CourseID = Courses.CourseID AND doing.Mark < 5) THEN
		signal sqlstate '01000' set message_text = 'Aquest estudiant no ha aprovat la carrera encara';
	ELSEIF EXISTS (SELECT Students.TFGMark FROM Students WHERE Students.TFGMark < 5 AND Students.UserID = userid) THEN
		signal sqlstate '01000' set message_text = 'Aquest estudiant no ha aprovat la carrera encara';
	ELSE
		signal sqlstate '01000' set message_text = 'Aquest estudiant ha aprovat la carrera';
	END IF;
END; //

delimiter //
CREATE PROCEDURE accessDepartmentBudget (in pdiid INT)
BEGIN
	DECLARE isMemGovTeam BOOLEAN;

	SET isMemGovTeam = (SELECT PDIs.MemberOfGovTeam FROM PDIs WHERE PDIs.pdiID = pdiid);

	IF isMemGovTeam THEN
		SELECT Budgets.AmountMoney FROM Budgets WHERE Budgets.BudgetID = (SELECT Departments.BudgetID FROM Departments WHERE Departments.DepartmentID = (SELECT PDIs.DepartmentID FROM PDIs WHERE PDIs.pdiID = pdiid));
	ELSE
		signal sqlstate '45000' set message_text = 'El PDI assenyalat no té accés al pressupost del seu departament';
	END IF;
END; //

/*delimiter //
CREATE TRIGGER bugdetDeptHigherSalaries ON UPDATE Departments FOR EACH ROW
BEGIN
END; //*/

/* delimiter //
CREATE TRIGGER budgetUniHigerSalaries ON UPPDATE UniversityLogic FOR EACH ROW
BEGIN
END; //*/

/*delimiter //
CREATE TRIGGER updateGrantToBudgets ON INSERT ResearchGrants FOR EACH ROW
BEGIN
END; //*/