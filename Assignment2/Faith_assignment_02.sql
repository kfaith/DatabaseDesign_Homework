-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema assignment_no2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema assignment_no2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `assignment_no2` DEFAULT CHARACTER SET utf8 ;
USE `assignment_no2` ;

-- -----------------------------------------------------
-- Table `assignment_no2`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`courses` (
  `id` INT NOT NULL auto_increment,
  `course_name` VARCHAR(255) NOT NULL,
  `course_number` INT NOT NULL,
  `major` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `course_name_UNIQUE` (`course_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`sections` (
  `id` INT NOT NULL auto_increment,
  `course_id` INT NOT NULL,
  `section_number` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `course_id_fk_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `course_id_fk`
    FOREIGN KEY (`course_id`)
    REFERENCES `assignment_no2`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`users` (
  `id` INT NOT NULL auto_increment,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`instructor_ranks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`instructor_ranks` (
  `id` INT NOT NUL auto_incrementL,
  `rank_name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rank_name_UNIQUE` (`rank_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`students` (
  `id` INT NOT NULL auto_increment,
  `user_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `assignment_no2`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`instructors` (
  `id` INT NOT NULL auto_increment,
  `user_id` INT NOT NULL,
  `rank_id` INT NOT NULL,
  `salary` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `rank_id_fk_idx` (`rank_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk1`
    FOREIGN KEY (`user_id`)
    REFERENCES `assignment_no2`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rank_id_fk`
    FOREIGN KEY (`rank_id`)
    REFERENCES `assignment_no2`.`instructor_ranks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`student_enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`student_enrollments` (
  `id` INT NOT NULL auto_increment,
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `section_id_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `student_id_fk`
    FOREIGN KEY (`student_id`)
    REFERENCES `assignment_no2`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `section_id_fk1`
    FOREIGN KEY (`section_id`)
    REFERENCES `assignment_no2`.`sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`instructor_assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`instructor_assignments` (
  `id` INT NOT NULL auto_increment,
  `instructor_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `instructor_id_fk_idx` (`instructor_id` ASC) VISIBLE,
  INDEX `section_id_fk_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `instructor_id_fk`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `assignment_no2`.`instructors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `section_id_fk3`
    FOREIGN KEY (`section_id`)
    REFERENCES `assignment_no2`.`sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`buildings` (
  `id` INT NOT NULL auto_increment,
  `building_name` VARCHAR(255) NOT NULL,
  `abbreviation` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `building_name_UNIQUE` (`building_name` ASC) VISIBLE,
  UNIQUE INDEX `abbreviation_UNIQUE` (`abbreviation` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`rooms` (
  `id` INT NOT NULL auto_increment,
  `building_id` INT NOT NULL,
  `room_number` INT NOT NULL,
  `capacity` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `building_id_fk_idx` (`building_id` ASC) VISIBLE,
  CONSTRAINT `building_id_fk`
    FOREIGN KEY (`building_id`)
    REFERENCES `assignment_no2`.`buildings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment_no2`.`class_time_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment_no2`.`class_time_location` (
  `id` INT NOT NULL auto_increment,
  `section_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `day_of_week` VARCHAR(3) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `section_id_fk_idx` (`section_id` ASC) VISIBLE,
  INDEX `room_id_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `section_id_fk2`
    FOREIGN KEY (`section_id`)
    REFERENCES `assignment_no2`.`sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `room_id_fk`
    FOREIGN KEY (`room_id`)
    REFERENCES `assignment_no2`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO courses VALUES ('1','COMPARCHITECT/OPERATINGSYS','3230','TEST','//TODO',current_timestamp,current_timestamp,'0');
INSERT INTO sections VALUES ('1','1','1',current_timestamp,current_timestamp,'0');
INSERT INTO users VALUES ('1','Lisa','Landgraf','landgraf@uwplatt.edu',current_timestamp,current_timestamp,'0');
INSERT INTO instructor_ranks VALUES ('1','professor emeritus',current_timestamp);
INSERT INTO students VALUES ('1','14',current_timestamp,current_timestamp,'0');
INSERT INTO instructors VALUES ('1','6','1','51713.15',current_timestamp,current_timestamp,'0');
INSERT INTO student_enrollments VALUES ('1','5','37',current_timestamp,current_timestamp,'0');
INSERT INTO instructor_assignments VALUES ('1','9','39',current_timestamp,current_timestamp,'0');
INSERT INTO buildings VALUES ('1','Ullrich Hall','ULR',current_timestamp,current_timestamp,'0');
INSERT INTO rooms VALUES ('1','2','215','10',current_timestamp,current_timestamp,'0');
INSERT INTO class_time_location VALUES ('1','7','9','14:00','14:50','MWF',current_timestamp,current_timestamp,'0');

select * from courses;
select * from sections;
select * from users;
select * from instructor_ranks;
select * from students;
select * from instructors;
select * from student_enrollments;
select * from instructor_assignments;
select * from buildings;
select * from rooms;
select * from class_time_location;



