/*First of all we have to create our database*/
CREATE DATABASE UPFinder;
/*We have to move to the current database in order to create the relative tables*/
USE UPFinder;

/*CREATION of TABLES*/
CREATE TABLE Users(
UserID CHAR(8), /*UserID can contain at most 8 digits*/
Name CHAR(25) NOT NULL, /*We use char and not varchar because we consider that 25 chars are enough to represent any name*/
Surname CHAR(25) NOT NULL, /*Same*/
BirthDate CHAR(10), /*Following the format dd/mm/yyyy*/
Email CHAR(50) NOT NULL,
StartingDate CHAR(30),
IsActive BIT, /*The datatype is useful to do booleans (0, 1 or NULL*/
PRIMARY KEY(UserID));

/*
************* USEFUL COMMANDS ***************
show tables; (Having selected a database)
select columns from Table; | See the attributes of a table
drop table/database Table/Database; | Delete a table or a database.

*/