-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lola-blanketsV2_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lola-blanketsV2_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lola-blanketsV2_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `lola-blanketsV2_db` ;

-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`product` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`product` (
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
-- Table `lola-blanketsV2_db`.`location_section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location_section` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location_section` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`section_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`location_warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location_warehouse` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location_warehouse` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `warehouse_name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `warehouse_name_UNIQUE` (`warehouse_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`location_aisle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location_aisle` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location_aisle` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aisle_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `aisle_name_UNIQUE` (`aisle_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`location_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location_level` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location_level` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `level_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `level_name_UNIQUE` (`level_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`location_bay`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location_bay` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location_bay` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bay_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`location` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`location` (
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
    REFERENCES `lola-blanketsV2_db`.`location_aisle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_section1`
    FOREIGN KEY (`fk_location_location_section`)
    REFERENCES `lola-blanketsV2_db`.`location_section` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_bay`
    FOREIGN KEY (`fk_location_location_bay`)
    REFERENCES `lola-blanketsV2_db`.`location_bay` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_level`
    FOREIGN KEY (`fk_location_location_level`)
    REFERENCES `lola-blanketsV2_db`.`location_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_location_warehouse`
    FOREIGN KEY (`fk_location_location_warehouse`)
    REFERENCES `lola-blanketsV2_db`.`location_warehouse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`product_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`product_location` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`product_location` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_product_location_product` INT UNSIGNED NOT NULL,
  `fk_product_location_location` INT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_location_location1_idx` (`fk_product_location_location` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`fk_product_location_product`)
    REFERENCES `lola-blanketsV2_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_location_location1`
    FOREIGN KEY (`fk_product_location_location`)
    REFERENCES `lola-blanketsV2_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`inventory_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`inventory_unit` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`inventory_unit` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_inventory_units_product` INT UNSIGNED NOT NULL,
  `fk_inventory_units_location` INT UNSIGNED NOT NULL,
  `unit_id` INT UNSIGNED NOT NULL,
  `quantity_marked` INT UNSIGNED NOT NULL DEFAULT 0,
  `quantity_total` INT UNSIGNED NOT NULL,
  `date_received` TIMESTAMP NOT NULL,
  `quantity_available` INT GENERATED ALWAYS AS ((quantity_total - quantity_marked)) STORED,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unit_id_UNIQUE` (`unit_id` ASC) VISIBLE,
  INDEX `fk_inventory_units_product1_idx` (`fk_inventory_units_product` ASC) VISIBLE,
  INDEX `fk_inventory_units_location1_idx` (`fk_inventory_units_location` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_units_product1`
    FOREIGN KEY (`fk_inventory_units_product`)
    REFERENCES `lola-blanketsV2_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_units_location1`
    FOREIGN KEY (`fk_inventory_units_location`)
    REFERENCES `lola-blanketsV2_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`inventory_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`inventory_transaction` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`inventory_transaction` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_transactions_product` INT UNSIGNED NOT NULL,
  `fk_inventory_transaction_inventory_unit` INT UNSIGNED NOT NULL,
  `fk_inventory_transaction_location_from` INT UNSIGNED NULL,
  `fk_inventory_transaction_location_to` INT UNSIGNED NULL,
  `transaction_date` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `transaction_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transaction_product_idx` (`fk_transactions_product` ASC) VISIBLE,
  INDEX `fk_inventory_transaction_location1_idx` (`fk_inventory_transaction_location_from` ASC) VISIBLE,
  INDEX `fk_inventory_transaction_location_to_idx` (`fk_inventory_transaction_location_to` ASC) VISIBLE,
  INDEX `fk_inventory_transaction_inventory_unit1_idx` (`fk_inventory_transaction_inventory_unit` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_product`
    FOREIGN KEY (`fk_transactions_product`)
    REFERENCES `lola-blanketsV2_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transaction_location_from`
    FOREIGN KEY (`fk_inventory_transaction_location_from`)
    REFERENCES `lola-blanketsV2_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transaction_location_to`
    FOREIGN KEY (`fk_inventory_transaction_location_to`)
    REFERENCES `lola-blanketsV2_db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transaction_inventory_unit1`
    FOREIGN KEY (`fk_inventory_transaction_inventory_unit`)
    REFERENCES `lola-blanketsV2_db`.`inventory_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`customer` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`customer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`orders` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_orders_customer` INT UNSIGNED NOT NULL,
  `order_number` INT UNSIGNED NOT NULL,
  `order_date` TIMESTAMP NOT NULL,
  `order_status` ENUM('PENDING', 'BATCHED', 'SHIPPED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
  `priority` ENUM('STANDARD', 'SLOW', 'EXPRESS') NOT NULL DEFAULT 'STANDARD',
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_date` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_customers1_idx` (`fk_orders_customer` ASC) VISIBLE,
  UNIQUE INDEX `order_number_UNIQUE` (`order_number` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`fk_orders_customer`)
    REFERENCES `lola-blanketsV2_db`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`batch_sheet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`batch_sheet` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`batch_sheet` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `batch_number` INT UNSIGNED NOT NULL,
  `batch_type` ENUM('SINGLES', 'MIXED', 'WHOLESALE') NOT NULL,
  `total_items` INT UNSIGNED NOT NULL,
  `total_locations` INT UNSIGNED NOT NULL,
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_date` TIMESTAMP NULL,
  `status` ENUM('PENDING', 'IN-SYSTEM', 'PRINTED', 'COMPLETED') NOT NULL DEFAULT 'PENDING',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `batch_number_UNIQUE` (`batch_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`order_item` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`order_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_order_items_order` INT UNSIGNED NOT NULL,
  `fk_order_items_product` INT UNSIGNED NOT NULL,
  `quantity_ordered` INT UNSIGNED NOT NULL,
  `quantity_fulfilled` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_order_items_orders1_idx` (`fk_order_items_order` ASC) VISIBLE,
  INDEX `fk_order_items_product1_idx` (`fk_order_items_product` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`fk_order_items_order`)
    REFERENCES `lola-blanketsV2_db`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_product1`
    FOREIGN KEY (`fk_order_items_product`)
    REFERENCES `lola-blanketsV2_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`order_item_allocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`order_item_allocation` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`order_item_allocation` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_order_item_allocation_order_item` INT UNSIGNED NOT NULL,
  `fk_order_item_allocation_inventory_unit` INT UNSIGNED NOT NULL,
  `quantity_allocated` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_item_allocations_order_items1_idx` (`fk_order_item_allocation_order_item` ASC) VISIBLE,
  INDEX `fk_order_item_allocations_inventory_units1_idx` (`fk_order_item_allocation_inventory_unit` ASC) VISIBLE,
  CONSTRAINT `fk_order_item_allocations_order_items1`
    FOREIGN KEY (`fk_order_item_allocation_order_item`)
    REFERENCES `lola-blanketsV2_db`.`order_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_allocations_inventory_units1`
    FOREIGN KEY (`fk_order_item_allocation_inventory_unit`)
    REFERENCES `lola-blanketsV2_db`.`inventory_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lola-blanketsV2_db`.`batch_sheet_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lola-blanketsV2_db`.`batch_sheet_item` ;

CREATE TABLE IF NOT EXISTS `lola-blanketsV2_db`.`batch_sheet_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_batch_sheet_item_order_item_allocation` INT UNSIGNED NOT NULL,
  `fk_batch_sheet_item_batch_sheet` INT UNSIGNED NOT NULL,
  `quantity_to_pick` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_batch_sheet_items_order_item_allocations1_idx` (`fk_batch_sheet_item_order_item_allocation` ASC) VISIBLE,
  INDEX `fk_batch_sheet_items_batch_sheets1_idx` (`fk_batch_sheet_item_batch_sheet` ASC) VISIBLE,
  CONSTRAINT `fk_batch_sheet_items_order_item_allocations1`
    FOREIGN KEY (`fk_batch_sheet_item_order_item_allocation`)
    REFERENCES `lola-blanketsV2_db`.`order_item_allocation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_sheet_items_batch_sheets1`
    FOREIGN KEY (`fk_batch_sheet_item_batch_sheet`)
    REFERENCES `lola-blanketsV2_db`.`batch_sheet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
