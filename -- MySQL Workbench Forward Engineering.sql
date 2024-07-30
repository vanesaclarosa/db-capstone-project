-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `tableNo` INT NOT NULL,
  PRIMARY KEY (`BookingID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `StaffID` INT NOT NULL,
  `EmployeeName` VARCHAR(100) NOT NULL,
  `EmployeeRole` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `MenuID` INT NOT NULL,
  `Cousine` VARCHAR(45) NOT NULL,
  `Starters` VARCHAR(45) NOT NULL,
  `Courses` INT NOT NULL,
  `Drink` VARCHAR(45) NOT NULL,
  `Dessert` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `AddressID` INT NOT NULL,
  `StreetName` VARCHAR(200) NOT NULL,
  `PostCode` INT NOT NULL,
  `Suburb` VARCHAR(45) NOT NULL,
  `State` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` INT NOT NULL,
  `CustomeName` VARCHAR(100) GENERATED ALWAYS AS () VIRTUAL,
  `AddressID` INT NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `Address_FK_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `Address_FK`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delivery` (
  `OrderId` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` VARCHAR(45) NOT NULL,
  `AddressId` INT NOT NULL,
  INDEX `Delivery_FK_idx` (`AddressId` ASC) VISIBLE,
  INDEX `OrderID_idx` (`OrderId` ASC) VISIBLE,
  CONSTRAINT `Delivery_FK`
    FOREIGN KEY (`AddressId`)
    REFERENCES `mydb`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderId`)
    REFERENCES `mydb`.`Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `OrderId` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuId` INT NOT NULL,
  `StaffId` INT NOT NULL,
  `DeliveryId` INT NOT NULL,
  `BookingId` INT NOT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `Staff_fk_idx` (`StaffId` ASC) VISIBLE,
  INDEX `Menu_fk_idx` (`MenuId` ASC) VISIBLE,
  INDEX `Customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `delivery_idx` (`DeliveryId` ASC) VISIBLE,
  INDEX `booking_fk_idx` (`BookingId` ASC) VISIBLE,
  CONSTRAINT `Staff_fk`
    FOREIGN KEY (`StaffId`)
    REFERENCES `mydb`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Menu_fk`
    FOREIGN KEY (`MenuId`)
    REFERENCES `mydb`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Delivery_Fk`
    FOREIGN KEY (`DeliveryId`)
    REFERENCES `mydb`.`Delivery` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `booking_fk`
    FOREIGN KEY (`BookingId`)
    REFERENCES `mydb`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;