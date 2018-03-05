/*Creation of Database*/

/*First of all we have to create our database*/
CREATE DATABASE IF NOT EXISTS UPFinder;

/*We have to move to the current database in order to create the relative tables*/
USE UPFinder;

/*CREATION of TABLES*/
CREATE TABLE IF NOT EXISTS Users (
	UserID INT(8), /*UserID can contain at most 8 digits*/
	Name CHAR(25) NOT NULL, /*We use char and not varchar because we consider that 25 chars are enough to represent any name*/
	Surname CHAR(25) NOT NULL, /*Same*/
	BirthDate CHAR(10), /*Following the format dd/mm/yyyy*/
	Email CHAR(50) NOT NULL,
	StartingDate CHAR(30), /*TODO: Here we have to decide if putting the date or maybe an attribute like StartedAs*/
	IsActive BIT, /*The datatype is useful to do booleans (0, 1 or NULL*/
	PRIMARY KEY(UserID));

/*https://stackoverflow.com/questions/3579079/how-can-you-represent-inheritance-in-a-database*/
CREATE TABLE IF NOT EXISTS Students(
	UserID INT(8),
	Degree CHAR(20) NOT NULL,
	Course CHAR(20),
	LvlOfAccess INT DEFAULT 1, /*TODO: We can assume that the acces for the students is 1, then we can have a table with the levels of acces...*/
	FOREIGN KEY (UserID) REFERENCES Users(UserID));

CREATE TABLE IF NOT EXISTS WorkingPeriods( 
	PeriodID INT,
	StartingDate CHAR(10),
	EndingDate CHAR(10),
	PRIMARY KEY (PeriodID)
	);

CREATE TABLE IF NOT EXISTS Employees(
	UserID INT(8),
	Salary INT NOT NULL,
	PeriodID INT, /*TODO: The times a person is hired*/
	FOREIGN KEY (UserID) REFERENCES Users(UserID),
	FOREIGN KEY (PeriodID) REFERENCES WorkingPeriods(PeriodID));

/*TODO: Check this table*/


CREATE TABLE IF NOT EXISTS PDIs(
	UserID INT(8),
	Course CHAR(20),
	Department CHAR(30),
	LvlOfAccess INT DEFAULT 2, /**/
	IsMemberOfGovTeam BIT,
	FOREIGN KEY (UserID) REFERENCES Employees(UserID));

CREATE TABLE IF NOT EXISTS PASs(
	UserID INT(8),
	WorksIn char(30),
	FOREIGN KEY (UserID) REFERENCES Employees(UserID));


CREATE TABLE IF NOT EXISTS Spaces(
	SpaceID INT(8),
	Capacity INT(8),
	Location CHAR(30),
	PRIMARY KEY (SpaceID));


CREATE TABLE IF NOT EXISTS Classrooms(
	SpaceID INT(8),
	Kind CHAR(20),	/*Potser el kind podria ser un ID referenciant a una taula amb els tipus. De moment ho poso com ho tenim en el ER*/
	FOREIGN KEY (SpaceID) REFERENCES Spaces(SpaceID));



/*
************* USEFUL COMMANDS ***************
show tables; (Having selected a database)
show columns from Table; | See the attributes of a table
drop table/database Table/Database; | Delete a table or a database.

*/