-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Online_Store_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Online_Store_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Online_Store_1` DEFAULT CHARACTER SET utf8 ;
USE `Online_Store_1` ;

-- -----------------------------------------------------
-- Table `Online_Store_1`.`Publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Publishers` (
  `pub_id` CHAR(4) NOT NULL,
  `pub_name` VARCHAR(40) NULL,
  `city` VARCHAR(20) NULL,
  `state` CHAR(2) NULL,
  `country` VARCHAR(30) NULL,
  PRIMARY KEY (`pub_id`))
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Pub_Info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Pub_Info` (
  `pub_id` CHAR(4) NOT NULL,
  `lo` LONGBLOB NULL,
  `pr_info` TEXT NULL,
  INDEX `fk_pub_info_publishers_idx` (`pub_id` ASC) VISIBLE,
  PRIMARY KEY (`pub_id`),
  UNIQUE INDEX `publishers_pub_id_UNIQUE` (`pub_id` ASC) VISIBLE,
  CONSTRAINT `fk_pub_info_publishers`
    FOREIGN KEY (`pub_id`)
    REFERENCES `Online_Store_1`.`Publishers` (`pub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Jobs` (
  `job_id` INT(11) NOT NULL,
  `job_desc` VARCHAR(50) NOT NULL,
  `min_lvl` INT(11) NOT NULL,
  `max_lvl` INT(11) NOT NULL,
  PRIMARY KEY (`job_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Employee` (
  `emp_id` INT(11) NOT NULL,
  `fname` VARCHAR(20) NOT NULL,
  `minit` CHAR(1) NULL,
  `lname` VARCHAR(30) NOT NULL,
  `job_id` INT(11) NOT NULL,
  `job_lvl` INT(11) NULL,
  `pub_id` CHAR(4) NOT NULL,
  `hire_date` DATETIME NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `fk_employee_jobs1_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_employee_publishers1_idx` (`pub_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Online_Store_1`.`Jobs` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_publishers1`
    FOREIGN KEY (`pub_id`)
    REFERENCES `Online_Store_1`.`Publishers` (`pub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Titles` (
  `title_id` VARCHAR(6) NOT NULL,
  `title` VARCHAR(80) NOT NULL,
  `type` CHAR(12) NOT NULL,
  `pub_id` CHAR(4) NOT NULL,
  `price` DECIMAL(10,2) NULL,
  `advance` DECIMAL(10,2) NULL,
  `royalty` INT(11) NULL,
  `ytd_sales` INT(11) NULL,
  `notes` VARCHAR(200) NULL,
  `pubdate` DATETIME NOT NULL,
  PRIMARY KEY (`title_id`),
  INDEX `fk_Titles_Publishers1_idx` (`pub_id` ASC) VISIBLE,
  CONSTRAINT `fk_Titles_Publishers1`
    FOREIGN KEY (`pub_id`)
    REFERENCES `Online_Store_1`.`Publishers` (`pub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Roysched`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Roysched` (
  `title_id` VARCHAR(6) NOT NULL,
  `lorange` INT(11) NULL,
  `hirange` INT(11) NULL,
  `royalty` INT(11) NULL,
  INDEX `fk_Roysched_Titles1_idx` (`title_id` ASC) VISIBLE,
  CONSTRAINT `fk_Roysched_Titles1`
    FOREIGN KEY (`title_id`)
    REFERENCES `Online_Store_1`.`Titles` (`title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Authors` (
  `au_id` VARCHAR(11) NOT NULL,
  `au_lname` VARCHAR(40) NOT NULL,
  `au_fname` VARCHAR(20) NOT NULL,
  `phone` CHAR(12) NOT NULL,
  `address` VARCHAR(40) NULL,
  `city` VARCHAR(20) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  `contract` BIT(1) NOT NULL,
  PRIMARY KEY (`au_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Title_Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Title_Author` (
  `title_id` VARCHAR(6) NOT NULL,
  `au_id` VARCHAR(11) NOT NULL,
  `au_ord` INT(11) NULL,
  `royaltytyper` INT(11) NULL,
  INDEX `fk_Title_Author_Titles1_idx` (`title_id` ASC) VISIBLE,
  INDEX `fk_Title_Author_Authors1_idx` (`au_id` ASC) VISIBLE,
  PRIMARY KEY (`title_id`, `au_id`),
  CONSTRAINT `fk_Title_Author_Titles1`
    FOREIGN KEY (`title_id`)
    REFERENCES `Online_Store_1`.`Titles` (`title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Title_Author_Authors1`
    FOREIGN KEY (`au_id`)
    REFERENCES `Online_Store_1`.`Authors` (`au_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Stores` (
  `stor_id` CHAR(4) NOT NULL,
  `stor_name` VARCHAR(40) NULL,
  `stor_address` VARCHAR(40) NULL,
  `city` VARCHAR(20) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  PRIMARY KEY (`stor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Sales` (
  `stor_id` CHAR(4) NOT NULL,
  `order_num` VARCHAR(20) NOT NULL,
  `ord_date` DATETIME NOT NULL,
  `qty` INT(11) NOT NULL,
  `payterms` VARCHAR(12) NOT NULL,
  `title_id` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`stor_id`, `order_num`, `title_id`),
  INDEX `fk_Sales_Titles1_idx` (`title_id` ASC) VISIBLE,
  INDEX `fk_Sales_Stores1_idx` (`stor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_Titles1`
    FOREIGN KEY (`title_id`)
    REFERENCES `Online_Store_1`.`Titles` (`title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Stores1`
    FOREIGN KEY (`stor_id`)
    REFERENCES `Online_Store_1`.`Stores` (`stor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Discounts` (
  `discountype` VARCHAR(40) NOT NULL,
  `stor_id` CHAR(4) NOT NULL,
  `lowqty` SMALLINT(6) NULL,
  `highqty` SMALLINT(6) NULL,
  `discount` DECIMAL(4,2) NOT NULL,
  INDEX `fk_Discounts_Stores1_idx` (`stor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Discounts_Stores1`
    FOREIGN KEY (`stor_id`)
    REFERENCES `Online_Store_1`.`Stores` (`stor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Sales_Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Sales_Log` (
  `sales_log_id` INT(11) NOT NULL,
  `stor_id` CHAR(4) NOT NULL,
  `order_num` VARCHAR(20) NOT NULL,
  `title_id` VARCHAR(6) NOT NULL,
  `au_id` VARCHAR(11) NOT NULL,
  `log_date` DATETIME NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`sales_log_id`),
  INDEX `fk_Sales_Log_Sales1_idx` (`stor_id` ASC, `order_num` ASC, `title_id` ASC) VISIBLE,
  INDEX `fk_Sales_Log_Authors1_idx` (`au_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_Log_Sales1`
    FOREIGN KEY (`stor_id` , `order_num` , `title_id`)
    REFERENCES `Online_Store_1`.`Sales` (`stor_id` , `order_num` , `title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Log_Authors1`
    FOREIGN KEY (`au_id`)
    REFERENCES `Online_Store_1`.`Authors` (`au_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Store_1`.`Pub_Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Store_1`.`Pub_Menu` (
  `mnu_num` INT(11) NOT NULL,
  `mnu_master` INT(11) NULL,
  `mnu_name` VARCHAR(30) NULL,
  PRIMARY KEY (`mnu_num`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
