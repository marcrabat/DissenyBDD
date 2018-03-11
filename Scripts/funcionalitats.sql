/*PART 1*/

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

/*(a) Add and remove users.*/

delimiter //
CREATE PROCEDURE deletestudent(IN id INT)
BEGIN
delete from Students where Students.UserID = id;
END //
delimiter ;


/*(b) Upload materials (e.g.: presentations, documents, assignments, etc.) and
administrate the permissions different users have on those documents (who
can upload/read what, deadlines, etc.).*/


/*(c) Assign grades to students (within a course).*/


