-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lola-blankets_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lola-blankets_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lola-blankets_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `lola-blankets_db` ;

-- -----------------------------------------------------
-- Table `lola-blankets_db`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`product` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `sku` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `cost` DECIMAL UNSIGNED NOT NULL,
  `price` DECIMAL UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sku_UNIQUE` (`sku` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location_section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location_section` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location_section` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`section_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location_warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location_warehouse` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location_warehouse` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `warehouse_name_UNIQUE` (`warehouse_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location_aisle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location_aisle` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location_aisle` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aisle_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `aisle_name_UNIQUE` (`aisle_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location_level` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location_level` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `level_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `level_name_UNIQUE` (`level_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location_bay`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location_bay` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location_bay` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bay_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`location` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`location` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_location_location_warehouse` INT UNSIGNED NOT NULL,
  `fk_location_location_section` INT UNSIGNED NULL,
  `fk_location_location_aisle` INT UNSIGNED NULL,
  `fk_location_location_bay` INT UNSIGNED NULL,
  `fk_location_location_level` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_location_aisle1_idx` (`fk_location_location_aisle` ASC) VISIBLE,
  INDEX `fk_location_location_section1_idx` (`fk_location_location_section` ASC) VISIBLE,
  INDEX `fk_location_location_bay1_idx` (`fk_location_location_bay` ASC) VISIBLE,
  INDEX `fk_location_location_level1_idx` (`fk_location_location_level` ASC) VISIBLE,
  INDEX `fk_location_location_warehouse1_idx` (`fk_location_location_warehouse` ASC) VISIBLE,
  CONSTRAINT `fk_location_location_aisle`
    FOREIGN KEY (`fk_location_location_aisle`)
    REFERENCES `lola-blankets_db`.`location_aisle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_section1`
    FOREIGN KEY (`fk_location_location_section`)
    REFERENCES `lola-blankets_db`.`location_section` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_bay`
    FOREIGN KEY (`fk_location_location_bay`)
    REFERENCES `lola-blankets_db`.`location_bay` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_level`
    FOREIGN KEY (`fk_location_location_level`)
    REFERENCES `lola-blankets_db`.`location_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_warehouse`
    FOREIGN KEY (`fk_location_location_warehouse`)
    REFERENCES `lola-blankets_db`.`location_warehouse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`product_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`product_location` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`product_location` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_product_location_product` INT UNSIGNED NOT NULL,
  `fk_product_location_location` INT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_location_location1_idx` (`fk_product_location_location` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`fk_product_location_product`)
    REFERENCES `lola-blankets_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_location_location1`
    FOREIGN KEY (`fk_product_location_location`)
    REFERENCES `lola-blankets_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blankets_db`.`inventory_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blankets_db`.`inventory_transaction` ;

CREATE TABLE IF NOT EXISTS `lola-blankets_db`.`inventory_transaction` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_transactions_product` INT UNSIGNED NOT NULL,
  `fk_inventory_transaction_location_from` INT UNSIGNED NULL,
  `fk_inventory_transaction_location_to` INT UNSIGNED NULL,
  `transaction_date` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `transaction_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transaction_product_idx` (`fk_transactions_product` ASC) VISIBLE,
  INDEX `fk_inventory_transaction_location1_idx` (`fk_inventory_transaction_location_from` ASC) VISIBLE,
  INDEX `fk_inventory_transaction_location_to_idx` (`fk_inventory_transaction_location_to` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_product`
    FOREIGN KEY (`fk_transactions_product`)
    REFERENCES `lola-blankets_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transaction_location_from`
    FOREIGN KEY (`fk_inventory_transaction_location_from`)
    REFERENCES `lola-blankets_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transaction_location_to`
    FOREIGN KEY (`fk_inventory_transaction_location_to`)
    REFERENCES `lola-blankets_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;