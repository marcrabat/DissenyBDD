-- MySQL Script generated by MySQL Workbench
-- Tue Mar 13 15:35:57 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema UPFinder
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `UPFinder` ;

-- -----------------------------------------------------
-- Schema UPFinder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `UPFinder` ;
USE `UPFinder` ;

-- -----------------------------------------------------
-- Table `UPFinder`.`Budgets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Budgets` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Budgets` (
  `BudgetID` INT NOT NULL,
  `AmountMoney` FLOAT NOT NULL,
  PRIMARY KEY (`BudgetID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`UniversityLogic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`UniversityLogic` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`UniversityLogic` (
  `SystemID` INT NOT NULL,
  `Name` VARCHAR(40) NULL,
  `BudgetID` INT NOT NULL,
  PRIMARY KEY (`SystemID`),
  INDEX `fk_UniversityLogic_Budgets1_idx` (`BudgetID` ASC),
  CONSTRAINT `fk_UniversityLogic_Budgets1`
    FOREIGN KEY (`BudgetID`)
    REFERENCES `UPFinder`.`Budgets` (`BudgetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Spaces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Spaces` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Spaces` (
  `SpaceID` INT NOT NULL,
  `Capacity` INT NULL DEFAULT NULL,
  `Location` VARCHAR(20) NULL DEFAULT NULL,
  `SystemID` INT NOT NULL,
  PRIMARY KEY (`SpaceID`),
  INDEX `fk_Spaces_UniversityLogic1_idx` (`SystemID` ASC),
  CONSTRAINT `fk_Spaces_UniversityLogic1`
    FOREIGN KEY (`SystemID`)
    REFERENCES `UPFinder`.`UniversityLogic` (`SystemID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Offices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Offices` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Offices` (
  `OfficeID` INT NOT NULL,
  `SpaceID` INT NOT NULL,
  INDEX `fk_Offices_Spaces1_idx` (`SpaceID` ASC),
  PRIMARY KEY (`OfficeID`),
  CONSTRAINT `fk_Offices_Spaces1`
    FOREIGN KEY (`SpaceID`)
    REFERENCES `UPFinder`.`Spaces` (`SpaceID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`LibraryWorkingAreas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`LibraryWorkingAreas` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`LibraryWorkingAreas` (
  `LibraryWorkingAreaID` INT NOT NULL,
  `SpaceID` INT NOT NULL,
  INDEX `fk_LibraryWorkingAreas_Spaces1_idx` (`SpaceID` ASC),
  PRIMARY KEY (`LibraryWorkingAreaID`),
  CONSTRAINT `fk_LibraryWorkingAreas_Spaces1`
    FOREIGN KEY (`SpaceID`)
    REFERENCES `UPFinder`.`Spaces` (`SpaceID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Degrees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Degrees` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Degrees` (
  `DegreeId` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`DegreeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Users` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Users` (
  `UserID` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Surname` VARCHAR(20) NOT NULL,
  `BirthDate` DATE NULL DEFAULT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `StartingDate` DATE NULL DEFAULT NULL,
  `IsActive` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`));


-- -----------------------------------------------------
-- Table `UPFinder`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Employees` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Employees` (
  `EmployeeID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `Salary` INT NOT NULL,
  INDEX `fk_Employees_Users1_idx` (`UserID` ASC),
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `fk_Employees_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Users` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Departments` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Departments` (
  `DepartmentID` INT NOT NULL,
  `Name` VARCHAR(40) NULL,
  `BudgetID` INT NOT NULL,
  `OfficeID` INT NOT NULL,
  PRIMARY KEY (`DepartmentID`),
  INDEX `fk_Departments_Budgets1_idx` (`BudgetID` ASC),
  INDEX `fk_Departments_Offices1_idx` (`OfficeID` ASC),
  CONSTRAINT `fk_Departments_Budgets1`
    FOREIGN KEY (`BudgetID`)
    REFERENCES `UPFinder`.`Budgets` (`BudgetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departments_Offices1`
    FOREIGN KEY (`OfficeID`)
    REFERENCES `UPFinder`.`Offices` (`OfficeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`PDIs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`PDIs` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`PDIs` (
  `pdiID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `DepartmentID` INT NOT NULL,
  `OfficeID` INT NOT NULL,
  `BudgetID` INT NOT NULL,
  `MemberOfGovTeam` TINYINT(1) NOT NULL,
  `LvlOfAccess` VARCHAR(20) NULL DEFAULT 'Upload',
  `Permanent` TINYINT(1) NULL,
  INDEX `fk_PDIs_Employees1_idx` (`EmployeeID` ASC),
  PRIMARY KEY (`pdiID`),
  INDEX `fk_PDIs_Departments1_idx` (`DepartmentID` ASC),
  INDEX `fk_PDIs_Offices1_idx` (`OfficeID` ASC),
  INDEX `fk_PDIs_Budgets1_idx` (`BudgetID` ASC),
  CONSTRAINT `fk_PDIs_Employees1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `UPFinder`.`Employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PDIs_Departments1`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `UPFinder`.`Departments` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PDIs_Offices1`
    FOREIGN KEY (`OfficeID`)
    REFERENCES `UPFinder`.`Offices` (`OfficeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PDIs_Budgets1`
    FOREIGN KEY (`BudgetID`)
    REFERENCES `UPFinder`.`Budgets` (`BudgetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`TFGs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`TFGs` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`TFGs` (
  `TFGID` INT NOT NULL,
  `TFGName` VARCHAR(40) NULL,
  `Mark` INT NULL,
  `DegreeId` INT NOT NULL,
  `SupervisorId` INT NOT NULL,
  PRIMARY KEY (`TFGID`),
  INDEX `fk_TFGs_Degrees1_idx` (`DegreeId` ASC),
  INDEX `fk_TFGs_PDIs1_idx` (`SupervisorId` ASC),
  CONSTRAINT `fk_TFGs_Degrees1`
    FOREIGN KEY (`DegreeId`)
    REFERENCES `UPFinder`.`Degrees` (`DegreeId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TFGs_PDIs1`
    FOREIGN KEY (`SupervisorId`)
    REFERENCES `UPFinder`.`PDIs` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Courses` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Courses` (
  `CourseID` INT NOT NULL,
  `Name` VARCHAR(40) NULL,
  `StartingDate` DATE NULL,
  `EndingDate` DATE NULL,
  `ECTS` INT NULL,
  PRIMARY KEY (`CourseID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`contain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`contain` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`contain` (
  `DegreeId` INT NOT NULL,
  `CourseID` INT NOT NULL,
  PRIMARY KEY (`DegreeId`, `CourseID`),
  INDEX `fk_contain_Courses1_idx` (`CourseID` ASC),
  INDEX `fk_contain_Degrees1_idx` (`DegreeId` ASC),
  CONSTRAINT `fk_contain_Degrees1`
    FOREIGN KEY (`DegreeId`)
    REFERENCES `UPFinder`.`Degrees` (`DegreeId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contain_Courses1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `UPFinder`.`Courses` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Students` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Students` (
  `StudentID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `LvlOfAccess` VARCHAR(20) NULL DEFAULT 'Read',
  INDEX `fk_Students_Users1_idx` (`UserID` ASC),
  PRIMARY KEY (`StudentID`),
  CONSTRAINT `fk_Students_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Users` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`doing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`doing` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`doing` (
  `CourseID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `Mark` INT NULL,
  PRIMARY KEY (`CourseID`, `UserID`),
  INDEX `fk_doing_Courses1_idx` (`CourseID` ASC),
  INDEX `fk_doing_Students1_idx` (`UserID` ASC),
  CONSTRAINT `fk_doing_Courses1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `UPFinder`.`Courses` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doing_Students1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Students` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`CourseMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`CourseMaterials` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`CourseMaterials` (
  `CourseMaterialID` INT NOT NULL,
  `CourseID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Format` VARCHAR(45) NOT NULL,
  `Size` INT NULL,
  PRIMARY KEY (`CourseMaterialID`),
  INDEX `fk_CourseMaterials_Courses1_idx` (`CourseID` ASC),
  CONSTRAINT `fk_CourseMaterials_Courses1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `UPFinder`.`Courses` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`teach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`teach` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`teach` (
  `CourseID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`CourseID`, `UserID`),
  INDEX `fk_teach_Courses1_idx` (`CourseID` ASC),
  INDEX `fk_teach_PDIs1_idx` (`UserID` ASC),
  CONSTRAINT `fk_teach_Courses1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `UPFinder`.`Courses` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teach_PDIs1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`PDIs` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Classrooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Classrooms` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Classrooms` (
  `ClassroomID` INT NOT NULL,
  `SpaceID` INT NOT NULL,
  `Kind` VARCHAR(20) NULL DEFAULT NULL,
  INDEX `fk_Classrooms_Spaces1_idx` (`SpaceID` ASC),
  PRIMARY KEY (`ClassroomID`),
  CONSTRAINT `fk_Classrooms_Spaces1`
    FOREIGN KEY (`SpaceID`)
    REFERENCES `UPFinder`.`Spaces` (`SpaceID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`PASs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`PASs` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`PASs` (
  `pasID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `SystemID` INT NOT NULL,
  INDEX `fk_PASs_Employees1_idx` (`EmployeeID` ASC),
  INDEX `fk_PASs_UniversityLogic1_idx` (`SystemID` ASC),
  PRIMARY KEY (`pasID`),
  CONSTRAINT `fk_PASs_Employees1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `UPFinder`.`Employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PASs_UniversityLogic1`
    FOREIGN KEY (`SystemID`)
    REFERENCES `UPFinder`.`UniversityLogic` (`SystemID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`enrolledTo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`enrolledTo` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`enrolledTo` (
  `DegreeId` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`DegreeId`, `UserID`),
  INDEX `fk_enrolledTo_Degrees1_idx` (`DegreeId` ASC),
  INDEX `fk_enrolledTo_Students1_idx` (`UserID` ASC),
  CONSTRAINT `fk_enrolledTo_Degrees1`
    FOREIGN KEY (`DegreeId`)
    REFERENCES `UPFinder`.`Degrees` (`DegreeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrolledTo_Students1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Students` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`WorkingPeriods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`WorkingPeriods` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`WorkingPeriods` (
  `PeriodID` INT NOT NULL,
  `StartingDate` DATE NULL DEFAULT NULL,
  `EndingDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`PeriodID`));


-- -----------------------------------------------------
-- Table `UPFinder`.`contractedIn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`contractedIn` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`contractedIn` (
  `UserID` INT NOT NULL,
  `PeriodID` INT NOT NULL,
  PRIMARY KEY (`UserID`, `PeriodID`),
  INDEX `fk_contractedIn_WorkingPeriods1_idx` (`PeriodID` ASC),
  INDEX `fk_contractedIn_Employees1_idx` (`UserID` ASC),
  CONSTRAINT `fk_contractedIn_Employees1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Employees` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contractedIn_WorkingPeriods1`
    FOREIGN KEY (`PeriodID`)
    REFERENCES `UPFinder`.`WorkingPeriods` (`PeriodID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`BookingHours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`BookingHours` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`BookingHours` (
  `BookingId` INT NOT NULL,
  `UserID` INT NOT NULL,
  `StartingDate` DATE NOT NULL,
  `EndingDate` DATE NOT NULL,
  PRIMARY KEY (`BookingId`),
  INDEX `fk_BookingHours_Students1_idx` (`UserID` ASC),
  CONSTRAINT `fk_BookingHours_Students1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Students` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`have`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`have` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`have` (
  `BookingId` INT NOT NULL,
  `SpaceID` INT NOT NULL,
  PRIMARY KEY (`BookingId`, `SpaceID`),
  INDEX `fk_have_LibraryWorkingAreas1_idx` (`SpaceID` ASC),
  INDEX `fk_have_BookingHours1_idx` (`BookingId` ASC),
  CONSTRAINT `fk_have_BookingHours1`
    FOREIGN KEY (`BookingId`)
    REFERENCES `UPFinder`.`BookingHours` (`BookingId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_have_LibraryWorkingAreas1`
    FOREIGN KEY (`SpaceID`)
    REFERENCES `UPFinder`.`LibraryWorkingAreas` (`SpaceID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`ResearchProjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`ResearchProjects` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`ResearchProjects` (
  `ProjectId` INT NOT NULL,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`ProjectId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`doResearchIn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`doResearchIn` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`doResearchIn` (
  `UserID` INT NOT NULL,
  `ProjectId` INT NOT NULL,
  `IsPI` TINYINT(1) NOT NULL,
  PRIMARY KEY (`UserID`, `ProjectId`),
  INDEX `fk_doResearchIn_ResearchProjects1_idx` (`ProjectId` ASC),
  INDEX `fk_doResearchIn_PDIs1_idx` (`UserID` ASC),
  CONSTRAINT `fk_doResearchIn_PDIs1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`PDIs` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doResearchIn_ResearchProjects1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `UPFinder`.`ResearchProjects` (`ProjectId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `UPFinder`.`ResearchGrants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`ResearchGrants` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`ResearchGrants` (
  `GrantId` INT NOT NULL,
  `Name` VARCHAR(40) NOT NULL,
  `StartDate` DATE NULL,
  `EndDate` DATE NULL,
  `AmountMoney` FLOAT NULL,
  PRIMARY KEY (`GrantId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`areAssociated`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`areAssociated` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`areAssociated` (
  `GrantId` INT NOT NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`GrantId`, `ProjectId`),
  INDEX `fk_areAssociated_ResearchProjects1_idx` (`ProjectId` ASC),
  INDEX `fk_areAssociated_ResearchGrants1_idx` (`GrantId` ASC),
  CONSTRAINT `fk_areAssociated_ResearchGrants1`
    FOREIGN KEY (`GrantId`)
    REFERENCES `UPFinder`.`ResearchGrants` (`GrantId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_areAssociated_ResearchProjects1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `UPFinder`.`ResearchProjects` (`ProjectId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`areDoneIn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`areDoneIn` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`areDoneIn` (
  `CourseID` INT NOT NULL,
  `SpaceID` INT NOT NULL,
  `StartTime` DATE NULL,
  `EndTime` DATE NULL,
  PRIMARY KEY (`CourseID`, `SpaceID`),
  INDEX `fk_areDoneIn_Classrooms1_idx` (`SpaceID` ASC),
  INDEX `fk_areDoneIn_Courses1_idx` (`CourseID` ASC),
  CONSTRAINT `fk_areDoneIn_Courses1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `UPFinder`.`Courses` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_areDoneIn_Classrooms1`
    FOREIGN KEY (`SpaceID`)
    REFERENCES `UPFinder`.`Classrooms` (`SpaceID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`Publications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`Publications` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`Publications` (
  `PublicationID` INT NOT NULL,
  `Title` VARCHAR(40) NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`PublicationID`),
  INDEX `fk_Publications_ResearchProjects1_idx` (`ProjectId` ASC),
  CONSTRAINT `fk_Publications_ResearchProjects1`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `UPFinder`.`ResearchProjects` (`ProjectId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`UniversityMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`UniversityMaterials` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`UniversityMaterials` (
  `UniversityMaterialID` INT NOT NULL,
  `Name` VARCHAR(20) NULL,
  `Availability` TINYINT(1) NULL,
  `StartingDate` DATE NULL,
  `EndingDate` DATE NULL,
  `SystemID` INT NOT NULL,
  PRIMARY KEY (`UniversityMaterialID`),
  INDEX `fk_UniversityMaterials_UniversityLogic1_idx` (`SystemID` ASC),
  CONSTRAINT `fk_UniversityMaterials_UniversityLogic1`
    FOREIGN KEY (`SystemID`)
    REFERENCES `UPFinder`.`UniversityLogic` (`SystemID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UPFinder`.`take`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UPFinder`.`take` ;

CREATE TABLE IF NOT EXISTS `UPFinder`.`take` (
  `UserID` INT NOT NULL,
  `UniversityMaterialID` INT NOT NULL,
  `OrderToTake` INT NULL,
  PRIMARY KEY (`UserID`, `UniversityMaterialID`),
  INDEX `fk_take_UniversityMaterial1_idx` (`UniversityMaterialID` ASC),
  INDEX `fk_take_Students1_idx` (`UserID` ASC),
  CONSTRAINT `fk_take_Students1`
    FOREIGN KEY (`UserID`)
    REFERENCES `UPFinder`.`Students` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_take_UniversityMaterial1`
    FOREIGN KEY (`UniversityMaterialID`)
    REFERENCES `UPFinder`.`UniversityMaterials` (`UniversityMaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
