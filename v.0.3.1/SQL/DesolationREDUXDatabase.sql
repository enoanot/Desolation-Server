-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema desolationredux
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema desolationredux
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `desolationredux` DEFAULT CHARACTER SET utf8 ;
USE `desolationredux` ;

-- -----------------------------------------------------
-- Table `desolationredux`.`world`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`world` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`world` (
  `uuid` BINARY(16) NOT NULL,
  `name` VARCHAR(45) NULL,
  `map` VARCHAR(45) NULL,
  `latitude` SMALLINT NULL,
  `longitude` SMALLINT NULL,
  `state` SMALLINT NULL,
  `ip` VARCHAR(16) NULL,
  `port` SMALLINT NULL,
  `password` VARCHAR(64) NULL,
  `mods` TEXT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`clan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`clan` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`clan` (
  `uuid` BINARY(16) NOT NULL,
  `name` VARCHAR(45) NULL,
  `founder_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `fk_clan_player1_idx` (`founder_uuid` ASC),
  CONSTRAINT `fk_clan_player1`
    FOREIGN KEY (`founder_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`player` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`player` (
  `uuid` BINARY(16) NOT NULL,
  `steamid` BIGINT NOT NULL,
  `battleyeid` VARCHAR(32) NULL,
  `firstlogin` TIMESTAMP NULL,
  `firstnick` VARCHAR(45) NULL,
  `lastlogin` TIMESTAMP NULL,
  `lastnick` VARCHAR(45) NULL,
  `lastlogout` TIMESTAMP NULL,
  `bancount` INT NULL DEFAULT 0,
  `banreason` VARCHAR(100) NULL,
  `banbegindate` TIMESTAMP NULL,
  `banenddate` TIMESTAMP NULL,
  `mainclan_uuid` BINARY(16) NULL,
  `aikills` INT NULL DEFAULT 0,
  `nonaikills` INT NULL DEFAULT 0,
  `deaths` INT NULL DEFAULT 0,
  `playtime` TIMESTAMP NULL,
  `targetworld_uuid` BINARY(16) NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC),
  UNIQUE INDEX `steamid_UNIQUE` (`steamid` ASC),
  INDEX `fk_player_clan1_idx` (`mainclan_uuid` ASC),
  INDEX `fk_player_world1_idx` (`targetworld_uuid` ASC),
  CONSTRAINT `fk_player_clan1`
    FOREIGN KEY (`mainclan_uuid`)
    REFERENCES `desolationredux`.`clan` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_world1`
    FOREIGN KEY (`targetworld_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`persistent_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`persistent_variables` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`persistent_variables` (
  `uuid` BINARY(16) NOT NULL,
  `persistentvariables` TEXT NULL,
  PRIMARY KEY (`uuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`object` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`object` (
  `uuid` BINARY(16) NOT NULL,
  `classname` VARCHAR(45) NOT NULL,
  `priority` INT NOT NULL,
  `timelastused` TIMESTAMP NOT NULL,
  `timecreated` TIMESTAMP NULL,
  `type` TINYINT(1) NULL DEFAULT 1,
  `accesscode` VARCHAR(45) NULL,
  `locked` TINYINT(1) NULL DEFAULT 0,
  `player_uuid` BINARY(16) NULL,
  `hitpoints` TEXT NULL,
  `damage` FLOAT NULL DEFAULT 0,
  `fuel` FLOAT NULL DEFAULT 1,
  `fuelcargo` FLOAT NULL DEFAULT 0,
  `repaircargo` FLOAT NULL DEFAULT 0,
  `items` TEXT NULL,
  `magazinesturret` TEXT NULL,
  `variables` TEXT NULL,
  `animationstate` TEXT NULL,
  `textures` TEXT NULL,
  `direction` FLOAT NULL DEFAULT 0,
  `positiontype` TINYINT(1) NULL DEFAULT 0,
  `positionx` FLOAT NULL DEFAULT 0,
  `positiony` FLOAT NULL DEFAULT 0,
  `positionz` FLOAT NULL DEFAULT 0,
  `positionadvanced` TEXT NULL,
  `reservedone` TEXT NULL,
  `reservedtwo` TEXT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC),
  INDEX `fk_objects_player1_idx` (`player_uuid` ASC),
  CONSTRAINT `fk_objects_player1`
    FOREIGN KEY (`player_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`charactershareables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`charactershareables` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`charactershareables` (
  `uuid` BINARY(16) NOT NULL,
  `classname` VARCHAR(45) NOT NULL,
  `hitpoints` TEXT NULL,
  `variables` TEXT NULL,
  `persistent_variables_uuid` BINARY(16) NOT NULL,
  `textures` TEXT NULL,
  `gear` TEXT NULL,
  `currentweapon` VARCHAR(45) NULL,
  `object_uuid` BINARY(16) NULL,
  PRIMARY KEY (`uuid`),
  INDEX `fk_charactershareables_death_persistant_variables_uuid_idx` (`persistent_variables_uuid` ASC),
  INDEX `fk_charactershareables_object1_idx` (`object_uuid` ASC),
  CONSTRAINT `fk_charactershareables_death_persistant_variables`
    FOREIGN KEY (`persistent_variables_uuid`)
    REFERENCES `desolationredux`.`persistent_variables` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_charactershareables_object1`
    FOREIGN KEY (`object_uuid`)
    REFERENCES `desolationredux`.`object` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`character`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`character` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`character` (
  `uuid` BINARY(16) NOT NULL,
  `animationstate` VARCHAR(128) NULL,
  `direction` FLOAT NULL DEFAULT 0,
  `positiontype` TINYINT(1) NULL DEFAULT 0,
  `positionx` FLOAT NULL DEFAULT 0,
  `positiony` FLOAT NULL DEFAULT 0,
  `positionz` FLOAT NULL DEFAULT 0,
  `charactershareables_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC),
  INDEX `playershareables_uuid_idx` (`charactershareables_uuid` ASC),
  CONSTRAINT `fk_character_charactershareables`
    FOREIGN KEY (`charactershareables_uuid`)
    REFERENCES `desolationredux`.`charactershareables` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`world_is_linked_to_world`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`world_is_linked_to_world` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`world_is_linked_to_world` (
  `world_uuid1` BINARY(16) NOT NULL,
  `world_uuid2` BINARY(16) NOT NULL,
  PRIMARY KEY (`world_uuid1`, `world_uuid2`),
  INDEX `world_uuid2_idx` (`world_uuid2` ASC),
  INDEX `world_uuid1_idx` (`world_uuid1` ASC),
  CONSTRAINT `fk_world_is_linked_to_world_worlds1`
    FOREIGN KEY (`world_uuid1`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_world_is_linked_to_world_worlds2`
    FOREIGN KEY (`world_uuid2`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`killinfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`killinfo` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`killinfo` (
  `uuid` BINARY(16) NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `attacker_uuid` BINARY(16) NULL,
  `type` VARCHAR(45) NULL,
  `weapon` VARCHAR(45) NULL,
  `distance` FLOAT NULL,
  PRIMARY KEY (`uuid`),
  INDEX `fk_killinfo_user1_idx` (`attacker_uuid` ASC),
  CONSTRAINT `fk_killinfo_user1`
    FOREIGN KEY (`attacker_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`world_has_objects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`world_has_objects` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`world_has_objects` (
  `world_uuid` BINARY(16) NOT NULL,
  `object_uuid` BINARY(16) NOT NULL,
  `killinfo_uuid` BINARY(16) NULL,
  `parentobject_uuid` BINARY(16) NULL,
  PRIMARY KEY (`world_uuid`, `object_uuid`),
  INDEX `fk_object_uuid_idx` (`object_uuid` ASC),
  INDEX `fk_world_uuid_idx` (`world_uuid` ASC),
  INDEX `fk_killinfo_uuid_idx` (`killinfo_uuid` ASC),
  INDEX `fk_parentobjects_uuid_idx` (`parentobject_uuid` ASC),
  CONSTRAINT `fk_worlds_has_objects_world`
    FOREIGN KEY (`world_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worlds_has_objects_object`
    FOREIGN KEY (`object_uuid`)
    REFERENCES `desolationredux`.`object` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worlds_has_objects_killinfo`
    FOREIGN KEY (`killinfo_uuid`)
    REFERENCES `desolationredux`.`killinfo` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worlds_has_objects_parentobject`
    FOREIGN KEY (`parentobject_uuid`)
    REFERENCES `desolationredux`.`object` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`player_on_world_has_character`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`player_on_world_has_character` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`player_on_world_has_character` (
  `player_uuid` BINARY(16) NOT NULL,
  `world_uuid` BINARY(16) NOT NULL,
  `character_uuid` BINARY(16) NOT NULL,
  `killinfo_uuid` BINARY(16) NULL,
  PRIMARY KEY (`player_uuid`, `world_uuid`, `character_uuid`),
  INDEX `character_uuid_idx` (`character_uuid` ASC),
  INDEX `world_uuid_idx` (`world_uuid` ASC),
  INDEX `player_uuid_idx` (`player_uuid` ASC),
  INDEX `killinfo_uuid_idx` (`killinfo_uuid` ASC),
  CONSTRAINT `fk_player_on_world_has_character_world`
    FOREIGN KEY (`world_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_on_world_has_character_character`
    FOREIGN KEY (`character_uuid`)
    REFERENCES `desolationredux`.`character` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_on_world_has_character_player`
    FOREIGN KEY (`player_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_on_world_has_character_killinfo`
    FOREIGN KEY (`killinfo_uuid`)
    REFERENCES `desolationredux`.`killinfo` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`player_on_world_has_persistent_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`player_on_world_has_persistent_variables` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`player_on_world_has_persistent_variables` (
  `player_uuid` BINARY(16) NOT NULL,
  `world_uuid` BINARY(16) NOT NULL,
  `persistent_variables_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`player_uuid`, `world_uuid`, `persistent_variables_uuid`),
  INDEX `fk_death_persistant_variables_uuid_idx` (`persistent_variables_uuid` ASC),
  INDEX `fk_player_uuid_idx` (`player_uuid` ASC),
  INDEX `fk_world_uuid_idx` (`world_uuid` ASC),
  CONSTRAINT `fk_p_o_w_has_death_persistant_variables_player`
    FOREIGN KEY (`player_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_p_o_w_has_death_persistant_variables_death_persistant_var`
    FOREIGN KEY (`persistent_variables_uuid`)
    REFERENCES `desolationredux`.`persistent_variables` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_p_o_w_has_death_persistant_variables_worlds`
    FOREIGN KEY (`world_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`whitelist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`whitelist` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`whitelist` (
  `world_uuid` BINARY(16) NOT NULL,
  `player_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`world_uuid`, `player_uuid`),
  INDEX `player_uuid_idx` (`player_uuid` ASC),
  INDEX `world_uuid_idx` (`world_uuid` ASC),
  CONSTRAINT `fk_whitelist_world`
    FOREIGN KEY (`world_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wwhitelist_player`
    FOREIGN KEY (`player_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`clan_memeber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`clan_memeber` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`clan_memeber` (
  `clan_uuid` BINARY(16) NOT NULL,
  `player_uuid` BINARY(16) NOT NULL,
  `rank` INT NULL,
  `comment` VARCHAR(120) NULL,
  PRIMARY KEY (`clan_uuid`, `player_uuid`),
  INDEX `fk_clan_memebers_player1_idx` (`player_uuid` ASC),
  CONSTRAINT `fk_clan_memebers_clan1`
    FOREIGN KEY (`clan_uuid`)
    REFERENCES `desolationredux`.`clan` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clan_memebers_player1`
    FOREIGN KEY (`player_uuid`)
    REFERENCES `desolationredux`.`player` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`world_has_persistent_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`world_has_persistent_variables` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`world_has_persistent_variables` (
  `world_uuid` BINARY(16) NOT NULL,
  `persistent_variables_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`world_uuid`, `persistent_variables_uuid`),
  INDEX `fk_world_has_variables_persistent_variables1_idx` (`persistent_variables_uuid` ASC),
  CONSTRAINT `fk_world_has_variables_world1`
    FOREIGN KEY (`world_uuid`)
    REFERENCES `desolationredux`.`world` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_world_has_variables_persistent_variables1`
    FOREIGN KEY (`persistent_variables_uuid`)
    REFERENCES `desolationredux`.`persistent_variables` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desolationredux`.`clan_has_persistent_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desolationredux`.`clan_has_persistent_variables` ;

CREATE TABLE IF NOT EXISTS `desolationredux`.`clan_has_persistent_variables` (
  `clan_uuid` BINARY(16) NOT NULL,
  `persistent_variables_uuid` BINARY(16) NOT NULL,
  PRIMARY KEY (`clan_uuid`, `persistent_variables_uuid`),
  INDEX `fk_clan_has_persistent_variables_persistent_variables1_idx` (`persistent_variables_uuid` ASC),
  CONSTRAINT `fk_clan_has_persistent_variables_clan1`
    FOREIGN KEY (`clan_uuid`)
    REFERENCES `desolationredux`.`clan` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clan_has_persistent_variables_persistent_variables1`
    FOREIGN KEY (`persistent_variables_uuid`)
    REFERENCES `desolationredux`.`persistent_variables` (`uuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `desolationredux` ;

-- -----------------------------------------------------
-- View `desolationredux`.`characterview`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `desolationredux`.`characterview` ;
USE `desolationredux`;
CREATE  OR REPLACE VIEW `characterview` AS
SELECT `character`.`uuid` as `character_uuid`, `animationstate`, `direction`, `positiontype`, `positionx`, `positiony`, `positionz`, 
    `character`.`charactershareables_uuid`, `classname`, `hitpoints`, `variables`, `textures`, `gear`, `currentweapon`, 
    `charactershareables`.`persistent_variables_uuid`, `persistentvariables`, `object_uuid`
FROM `character`
INNER JOIN `charactershareables`
ON `character`.`charactershareables_uuid` = `charactershareables`.`uuid`
INNER JOIN `persistent_variables`
ON `charactershareables`.`persistent_variables_uuid` = `persistent_variables`.`uuid`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
