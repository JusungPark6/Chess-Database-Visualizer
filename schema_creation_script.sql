-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db` DEFAULT CHARACTER SET utf8 ;
USE `db` ;

-- -----------------------------------------------------
-- Table `db`.`Game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`Game` (
  `game_id` INT NOT NULL,
  `white` VARCHAR(100) NOT NULL,
  `black` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`game_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`Players` (
  `player_id` INT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE INDEX `player_id_UNIQUE` (`player_id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`Game_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`Game_Details` (
  `game_id` INT NOT NULL,
  `winner` VARCHAR(45) NULL,
  `result` VARCHAR(45) NULL,
  `time_control` VARCHAR(45) NULL,
  `move_count` INT NOT NULL,
  `moves` VARCHAR(1000) NULL,
  PRIMARY KEY (`game_id`),
  CONSTRAINT `game_id`
    FOREIGN KEY (`game_id`)
    REFERENCES `db`.`Game` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
