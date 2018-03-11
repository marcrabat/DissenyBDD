/*VISTES*/
/*Retorna noms d'usuaris, cursos i notes*/
CREATE VIEW `PDIteach` AS
SELECT U.Name, U.Surname, U.UserID, C.Name AS Course 
FROM USERS AS U INNER JOIN teach AS T ON U.UserID = T.UserID
INNER JOIN Courses AS C ON T.CourseID = C.CourseID
;

/*Retorna PDIs i cursos que imparteixen*/
CREATE VIEW `StudentDoingMark` AS
SELECT U.Name, U.Surname, U.UserID, C.Name AS Course, Mark
FROM USERS AS U INNER JOIN doing AS D ON U.UserID = D.UserID
INNER JOIN Courses AS C ON D.CourseID = C.CourseID
;


/*PA Eliminar usuaris*/
/*Elimina un usuari per ID de totes les taules*/
DELIMITER $$

CREATE PROCEDURE DeleteUser (
Id int
)
BEGIN

DELETE FROM Users where UserID = Id;
DELETE FROM enrolledTo where UserID = Id;
DELETE FROM BookingHours where UserID = Id;
DELETE FROM Degrees where UserID = Id;
DELETE FROM Employees where UserID = Id;
DELETE FROM PDIs where UserID = Id;
DELETE FROM PASs where UserID = Id;
DELETE FROM Students where UserID = Id;
DELETE FROM doing where UserID = Id;
DELETE FROM teach where UserID = Id;
DELETE FROM contractedIn where UserID = Id;
DELETE FROM doResearchIn where UserID = Id;
DELETE FROM take where UserID = Id;

END

/*Exemple
call deleteuser(114130);
*/


/*PA per assignar notes*/
DELIMITER $$

CREATE PROCEDURE AssignMark (
IdUser int,
nota int,
assignatura varchar(40)
)
BEGIN

UPDATE doing INNER JOIN courses
ON doing.courseID = courses.CourseID SET
Mark = nota
WHERE IdUser = UserID AND courses.Name = assignatura;

END

/*EXEMPLE: Posa un 9 a càlcul al user 114130. Només ho fa si existeix l'usuari, l'assignatura i l'usuari l'està cursant*/
/*
call AssignMark(114130, 9, 'Calcul');
*/

