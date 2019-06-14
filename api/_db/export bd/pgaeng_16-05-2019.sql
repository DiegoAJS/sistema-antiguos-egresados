-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-05-2019 a las 17:20:54
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pgaeng`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_appointment` (IN `_operation` INT, IN `_appointment_id` INT, IN `_person_id` INT, IN `_appointment` VARCHAR(120), IN `_profession` TEXT, IN `_specialty` TEXT, IN `_career_direction` VARCHAR(120))  BEGIN

CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_appointment(person_id, appointment, profession, specialty, career_direction)
		SELECT * FROM (SELECT _person_id, _appointment, _profession, _specialty, _career_direction) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_appointment WHERE person_id = _person_id AND appointment= _appointment
                                                        AND career_direction=_career_direction) LIMIT 1;
        
        IF EXISTS(SELECT appointment_id FROM table_appointment WHERE person_id = _person_id AND appointment= _appointment
                                                        AND career_direction=_career_direction) THEN
			SELECT appointment_id FROM table_appointment WHERE person_id = _person_id AND appointment= _appointment
                                                        AND career_direction=_career_direction LIMIT 1; 
		END IF;
        
	WHEN 2 THEN
		SELECT * FROM table_appointment WHERE appointment_id= _appointment_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_appointment  
        SET person_id = _person_id, 
            appointment = _appointment,
            profession = _profession,
            specialty = _specialty,
            career_direction = _career_direction, 
            updated= now()
        WHERE appointment_id= _appointment_id LIMIT 1;
        SELECT appointment_id FROM table_appointment 
									WHERE appointment_id= _appointment_id LIMIT 1; 
                                    
	WHEN 4 THEN 
		DELETE FROM table_appointment WHERE appointment_id= _appointment_id LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_appointment;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_control` (IN `_operation` INT, IN `_control_id` INT, IN `_student_record_id` INT, IN `_type_id` INT, IN `_value_control` BOOLEAN)  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_control(student_record_id, type_id, value_control)
		SELECT * FROM (SELECT  _student_record_id,_type_id,_value_control) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_control WHERE student_record_id = _student_record_id AND type_id=_type_id) LIMIT 1; 
        IF EXISTS(SELECT control_id FROM table_control WHERE student_record_id = _student_record_id AND type_id=_type_id) THEN
			SELECT control_id FROM table_control WHERE student_record_id = _student_record_id AND type_id=_type_id LIMIT 1; 
		END IF;
	WHEN 2 THEN
		SELECT * FROM table_control WHERE control_id=_control_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_control
        SET student_record_id=_student_record_id, 
			type_id=_type_id,
            value_control=_value_control,
			updated = now()
        WHERE control_id=_control_id  LIMIT 1;
        SELECT control_id FROM table_control WHERE control_id=_control_id LIMIT 1;  
        
	WHEN 4 THEN 
		DELETE FROM table_control WHERE control_id=_control_id LIMIT 1;  
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_control;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_defense_court` (IN `_operation` INT, IN `_defense_court_id` INT, IN `_student_record_id` INT, IN `_person_student_id` INT, IN `_person_teacher_id_1` INT, IN `_person_teacher_id_2` INT, IN `_person_teacher_id_3` INT, IN `_defensed` DATETIME, IN `_place_defense` VARCHAR(255), IN `_note` TEXT)  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_defense_court(student_record_id, person_student_id, person_teacher_id_1, person_teacher_id_2, person_teacher_id_3,  defensed, place_defense, note)
		SELECT * FROM (SELECT  _student_record_id,_person_student_id,_person_teacher_id_1,_person_teacher_id_2,_person_teacher_id_3,_defensed,_place_defense,_note) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_defense_court WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id) LIMIT 1; 
        IF EXISTS(SELECT * FROM table_defense_court WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id) THEN
			SELECT defense_court_id FROM table_defense_court WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id LIMIT 1; 
		END IF;
	WHEN 2 THEN
		SELECT * FROM table_defense_court WHERE defense_court_id=_defense_court_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_defense_court
        SET student_record_id=_student_record_id, 
			person_student_id=_person_student_id, 
            person_teacher_id_1=_person_teacher_id_1, 
            person_teacher_id_2=_person_teacher_id_2, 
            person_teacher_id_3=_person_teacher_id_3,
            defensed=_defensed, 
            place_defense=_place_defense, 
            note=_note, 
		    updated = now()
        WHERE defense_court_id=_defense_court_id LIMIT 1;
        SELECT defense_court_id FROM table_defense_court WHERE defense_court_id=_defense_court_id LIMIT 1;  
        
	WHEN 4 THEN 
		DELETE FROM table_defense_court WHERE defense_court_id=_defense_court_id LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_defense_court;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_payment_history` (IN `_operation` INT, IN `_payment_history_id` INT, IN `_student_record_id` INT, IN `_payment` DECIMAL, IN `_payment_code` VARCHAR(16), IN `_name_bank` VARCHAR(26))  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_payment_history(student_record_id, payment, payment_code,name_bank)
		SELECT * FROM (SELECT  _student_record_id, _payment, _payment_code, _name_bank) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_payment_history WHERE student_record_id=_student_record_id AND payment_code=_payment_code AND name_bank=_name_bank) LIMIT 1; 
        IF EXISTS(SELECT payment_history_id FROM table_payment_history WHERE student_record_id=_student_record_id AND payment_code=_payment_code AND name_bank=_name_bank) THEN
			SELECT payment_history_id FROM table_payment_history WHERE student_record_id=_student_record_id AND payment_code=_payment_code AND name_bank=_name_bank LIMIT 1; 
		END IF;
	WHEN 2 THEN
		SELECT * FROM table_payment_history WHERE payment_history_id=_payment_history_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_payment_history
        SET student_record_id = _student_record_id, 
			payment = _payment,
            payment_code = _payment_code,
            name_bank = _name_bank,
            updated = now()
        WHERE payment_history_id=_payment_history_id LIMIT 1;
        SELECT payment_history_id FROM table_payment_history WHERE payment_history_id=_payment_history_id LIMIT 1;  
        
	WHEN 4 THEN 
		DELETE FROM table_payment_history WHERE payment_history_id=_payment_history_id LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_payment_history WHERE student_record_id=_student_record_id;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_person` (IN `_operation` INT, IN `_person_id` INT, IN `_first_name` VARCHAR(255), IN `_last_name` VARCHAR(255), IN `_ci` VARCHAR(120), IN `_email` VARCHAR(120), IN `_cellphone` VARCHAR(16), IN `_telephone` VARCHAR(16), IN `_city` VARCHAR(120), IN `_address` VARCHAR(120), IN `_passwords` VARCHAR(120))  BEGIN

 CASE _operation
	/* I N S E R T A R */
	WHEN 1 THEN 
		IF NOT EXISTS(SELECT person_id FROM table_person WHERE table_person.ci = _ci) THEN
			INSERT INTO table_person(first_name, last_name, ci, email, cellphone, telephone, city, address, passwords) VALUE (_first_name, _last_name, _ci, _email, _cellphone, _telephone, _city, _address, _passwords);
            SELECT *, true AS "status", "Correcto registro CREADO" AS msg FROM table_person WHERE table_person.ci=_ci LIMIT 1;
		ELSE
			SELECT false AS "status", "Error de registro ya existe el CI" AS msg;
		END IF;
	
    /* L E E R */
	WHEN 2 THEN
		IF EXISTS(SELECT * FROM table_person WHERE person_id=_person_id AND deleted IS NULL) THEN
			SELECT *, true AS "status", "Correcto registro LEIDO"AS msg FROM table_person WHERE table_person.person_id=_person_id LIMIT 1;
		ELSE
			SELECT false AS "status", "Error registro no existe" AS msg;
        END IF;
	
    /* A C T  U A L I Z A R */
	WHEN 3 THEN
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id AND table_person.deleted IS NULL) THEN
			UPDATE table_person
			SET first_name = _first_name, 
				last_name = _last_name,
				ci = _ci,
				email = _email,
				cellphone = _cellphone,
				telephone = _telephone,
				city = _city,
				address = _address, 
				passwords = _passwords, 
				updated = NOW()
			WHERE table_person.person_id = _person_id LIMIT 1;
            SELECT *, true AS "status", "Correcto registro ACTUALIZADO" AS msg FROM table_person WHERE table_person.person_id = _person_id  LIMIT 1; 
        ELSE
			SELECT false AS "status", "Error registro no existe" AS msg;
        END IF;
        
    /* E L I  M I N  A R */ 
	WHEN 4 THEN 
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id AND table_person.deleted IS NULL) THEN
			UPDATE table_person SET deleted = NOW()  WHERE table_person.person_id = _person_id LIMIT 1;
            SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
        ELSE
			SELECT false AS "status", "Error registro no existe o esta eliminado" AS msg;
        END IF;
    
    /* D E S E L I M I N A R*/
	WHEN 5 THEN 
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id AND table_person.deleted IS NOT NULL) THEN
			UPDATE table_person SET deleted = NULL  WHERE table_person.person_id = _person_id LIMIT 1;
            SELECT true AS "status", "Correcto registro HABILITADO" AS msg;
        ELSE
			SELECT false AS "status", "Error registro no existe" AS msg;
        END IF;
    
    /* LISTA DE TODO*/
    WHEN 6 THEN
		SELECT * FROM table_person;
	
    /* LISTA DE LOS NO ELIMINADOS*/
	WHEN 7 THEN 
		SELECT * FROM table_person WHERE table_person.deleted IS NULL;
        
    /* LO G I N */
    WHEN 8 THEN
		IF EXISTS(select table_person.id from table_person WHERE  ci = _ci AND passwords = _passwords AND table_person.deleted IS NULL) THEN
			select person_id,first_name, last_name,ci, email,true AS "status","Correcto LOGIN" AS msg from table_person WHERE  ci = _ci AND passwords = _passwords LIMIT 1;
		ELSE 
			SELECT FALSE AS "status", "Error NO LOGIN" AS msg;
		END IF;
    
    /* C A R  G O S */
    WHEN 9 THEN
		IF EXISTS(select b.appointment from table_person a INNER JOIN table_appointment b on a.person_id = b.person_id WHERE b.person_id=_person_id AND a.deleted IS NULL AND b.deleted IS NULL) THEN
			select b.appointment from table_person a INNER JOIN table_appointment b on a.person_id = b.person_id WHERE b.person_id=_person_id;
		ELSE 
			SELECT FALSE AS "status", "Error sin cargo" AS msg;
		END IF;
        
	/* T U T O R - E S T U D I A N T E S*/
	WHEN 10 THEN
		IF EXISTS(select a.* from table_person a INNER JOIN table_tutor_assignment b on a.person_id = b.person_tutor_id WHERE b.person_tutor_id=_person_id AND a.deleted IS NULL AND b.deleted IS NULL) THEN
			select a.* from table_person a INNER JOIN table_tutor_assignment b on a.person_id = b.person_tutor_id WHERE b.person_tutor_id=_person_id;
		ELSE 
			SELECT FALSE AS "status", "Error sin estudiante" AS msg;
		END IF;        
	END CASE; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_program` (IN `_operation` INT, IN `_program_version_id` INT, IN `_program_version` VARCHAR(120), IN `_state` VARCHAR(120), IN `_grade` VARCHAR(120), IN `_cost` DECIMAL, IN `_startd` DATETIME, IN `_finishd` DATETIME)  BEGIN

 CASE _operation 
	WHEN 1 THEN 
	IF NOT EXISTS(SELECT program_version_id FROM table_program_version WHERE program_version = _program_version AND grade= _grade) THEN
		INSERT INTO table_program_version(program_version, state,grade, cost, startd, finishd) VALUE (_program_version, _state, _grade, _cost, _startd, _finishd); 
		SELECT *,TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_program_version  WHERE table_program_version.program_version = _program_version AND table_program_version.grade= _grade LIMIT 1; 
	ELSE 
		SELECT FALSE AS "status", "Error registro ya existe " AS msg ;
	END IF;
	
	WHEN 2 THEN
	IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id) THEN
		SELECT *,TRUE AS "status", "Correcto registro LEIDO" AS msg FROM table_program_version  WHERE program_version_id= _program_version_id LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
        
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id) THEN
		UPDATE table_program_version
			SET program_version = _program_version, 
				state = _state,
				grade = _grade,
				cost = _cost,
				startd = _startd, 
				finishd = _finishd,
				updated= now()
			WHERE program_version_id= _program_version_id LIMIT 1;
        SELECT *,TRUE AS "status", "Correcto registro ACTUALIZADO" AS msg FROM table_program_version WHERE program_version_id= _program_version_id LIMIT 1; 
    ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;
		                                    
	WHEN 4 THEN 
	IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id) THEN
		DELETE FROM table_program_version WHERE program_version_id= _program_version_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro ELIMINADO" AS msg;
    ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;
    
	WHEN 5 THEN
		SELECT * FROM table_program_version;
	END CASE; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_student_record` (IN `_operation` INT, IN `_student_record_id` INT, IN `_person_student_id` INT, IN `_program_version_id` INT, IN `_career` VARCHAR(120), IN `_cu` VARCHAR(15), IN `_tuition` DECIMAL, IN `_type_register` VARCHAR(120), IN `_state` VARCHAR(120))  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_student_record(person_student_id, program_version_id, career, cu, tuition, type_register, state)
		SELECT * FROM (SELECT _person_student_id, _program_version_id, _career, _cu, _tuition, _type_register, _state) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_student_record WHERE person_student_id = _person_student_id AND program_version_id=_program_version_id AND career=_career) LIMIT 1;         
        IF EXISTS(SELECT * FROM table_student_record WHERE person_student_id = _person_student_id  AND program_version_id=_program_version_id AND career=_career) THEN
			SELECT student_record_id FROM table_student_record WHERE person_student_id = _person_student_id 
																AND program_version_id=_program_version_id  
                                                                AND career=_career LIMIT 1; 
		END IF;
	WHEN 2 THEN
		SELECT * FROM table_student_record WHERE student_record_id=_student_record_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_student_record
        SET person_student_id = _person_student_id,   
			program_version_id = _program_version_id,
            career = _career,
            cu = _cu,
            tuition = _tuition,
            type_register=_type_register,
            state = _state, 
            updated = now()
        WHERE student_record_id=_student_record_id LIMIT 1;
        SELECT student_record_id FROM table_student_record WHERE student_record_id=_student_record_id;  
        
	WHEN 4 THEN 
		DELETE FROM table_student_record WHERE student_record_id=_student_record_id LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_student_record;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_tracing` (IN `_operation` INT, IN `_tracing_id` INT, IN `_student_record_id` INT, IN `_person_student_id` INT, IN `_person_tutor_id` INT, IN `_detail` VARCHAR(511), IN `_documents_attached` VARCHAR(127))  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_tracing(student_record_id, person_student_id, person_tutor_id, detail, documents_attached)
		VALUE ( _student_record_id,_person_student_id,_person_tutor_id,_detail,_documents_attached);
        SELECT LAST_INSERT_ID() AS id FROM table_tracing;
	WHEN 2 THEN
		SELECT * FROM table_tracing WHERE tracing_id=_tracing_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_tracing
        SET student_record_id=_student_record_id,
			person_student_id=_person_student_id,
            person_tutor_id=_person_tutor_id,
            detail=_detail, 
            documents_attached=_documents_attached,
            updated = now()
        WHERE tracing_id=_tracing_id  LIMIT 1;
        SELECT tracing_id FROM table_tracing WHERE tracing_id=_tracing_id ;  
        
	WHEN 4 THEN 
		DELETE FROM table_tracing WHERE tracing_id=_tracing_id LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
        
	WHEN 5 THEN
		SELECT * FROM table_tracing WHERE student_record_id = _student_record_id
										AND person_student_id=_person_student_id;
	WHEN 6 THEN
		SELECT * FROM table_tracing WHERE student_record_id = _student_record_id
										AND person_tutor_id=_person_tutor_id;
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_tutor_assignment` (IN `_operation` INT, IN `_tutor_assignment_id` INT, IN `_student_record_id` INT, IN `_person_student_id` INT, IN `_person_tutor_id` INT, IN `_finishd` DATETIME)  BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_tutor_assignment(student_record_id, person_student_id, person_tutor_id, finishd)
		SELECT * FROM (SELECT  _student_record_id, _person_student_id, _person_tutor_id, _finishd) AS tmp
		WHERE NOT EXISTS (SELECT * FROM table_tutor_assignment WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id AND person_tutor_id=_person_tutor_id) LIMIT 1; 
        IF EXISTS(SELECT tutor_assignment_id FROM table_tutor_assignment WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id AND person_tutor_id=_person_tutor_id) THEN
			SELECT tutor_assignment_id FROM table_tutor_assignment WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id AND person_tutor_id=_person_tutor_id LIMIT 1; 
		END IF;
	WHEN 2 THEN
		SELECT * FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
        
	WHEN 3 THEN 
		UPDATE table_tutor_assignment
        SET student_record_id= _student_record_id, 
			person_student_id=_person_student_id,
            person_tutor_id=_person_tutor_id,
            finishd=_finishd, 
            updated = now()
        WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
        SELECT tutor_assignment_id FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id;  
        
	WHEN 4 THEN 
		DELETE FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id  LIMIT 1;
        SELECT "Eliminado exitoso" AS msg;
	WHEN 5 THEN
		SELECT * FROM table_tutor_assignment;
    
	END CASE; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crud_table_type` (IN `_operation` INT, IN `_type_id` INT, IN `_name_type` VARCHAR(255), IN `_label_type` VARCHAR(255), IN `_foreign_type_id` INT)  BEGIN

 CASE _operation 
	WHEN 1 THEN 
        IF NOT EXISTS(SELECT * FROM table_type WHERE name_type= _name_type AND label_type=_label_type) THEN
			INSERT INTO table_type(name_type, label_type, foreign_type_id) VALUE (_name_type, _label_type, _foreign_type_id);
            SELECT *, true AS "status", "Correcto registro CREADO" AS msg FROM table_type WHERE name_type= _name_type AND label_type=_label_type LIMIT 1;
		ELSE 
			SELECT false AS "status", "Error de registro ya existente" AS msg;
		END IF;
	
    WHEN 2 THEN
    IF EXISTS(SELECT * FROM table_type WHERE type_id=_type_id AND deleted IS NULL) THEN
		SELECT *, true AS "status", "Correcto registro LEIDO" AS msg FROM table_type WHERE type_id=_type_id LIMIT 1;
	ELSE 
		SELECT false AS "status", "Error no existe registro" AS msg;
	END IF;
	
    WHEN 3 THEN 
	IF EXISTS (SELECT * FROM table_type WHERE type_id=t_ype_id AND deleted IS NULL) THEN
		UPDATE table_type
			SET name_type= _name_type, 
				label_type=_label_type,
				foreign_type_id=_foreign_type_id,
				updated = NOW()
			WHERE table_type.type_id = _type_id LIMIT 1;
		SELECT *,true AS "status", "Correcto registro EDITADO" AS msg FROM table_type WHERE type_id=t_ype_id;
        ELSE 
			SELECT false AS "status", "Error no existe registro" AS msg;
	END IF;
	
    WHEN 4 THEN 
    IF EXISTS (SELECT * FROM table_type WHERE type_id=_type_id AND deleted IS NULL) THEN
		UPDATE table_type SET deleted = NOW() WHERE table_type.type_id = _type_id LIMIT 1;
        SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE 
		SELECT false AS "status", "Error no existe registro" AS msg;
    END IF; 
    
	WHEN 5 THEN
    IF EXISTS (SELECT * FROM table_type WHERE type_id=_type_id AND deleted IS NOT NULL) THEN
		UPDATE table_type SET deleted = NULL WHERE table_type.type_id = _type_id LIMIT 1;
        SELECT true AS "status", "Correcto registro HABILITADO" AS msg;
	ELSE 
		SELECT false AS "status", "Error no existe registro" AS msg;
	END IF;
    
    WHEN 6 THEN 
		SELECT * FROM table_type;
	
    WHEN 7 THEN 
		SELECT * FROM table_type WHERE deleted IS NULL;
	
    WHEN 8 THEN 
		SELECT * FROM table_type WHERE label_type=_label_type AND deleted IS NOT NULL;
	
    WHEN 9 THEN 
		SELECT * FROM table_type WHERE foreign_type_id=_foreign_type_id AND deleted IS NOT NULL;
        
    END CASE; 

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_appointment`
--

CREATE TABLE `table_appointment` (
  `appointment_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `appointment` varchar(120) DEFAULT NULL,
  `profession` text,
  `specialty` text,
  `career_direction` varchar(120) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `table_appointment`
--

INSERT INTO `table_appointment` (`appointment_id`, `person_id`, `appointment`, `profession`, `specialty`, `career_direction`, `created`, `updated`, `deleted`) VALUES
(1, 1, 'ROOT', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(2, 2, 'Coordinador', 'Licenciatura en Ingeniería En Ciencias En Computación', 'Network, Inteligencia Artificial', 'Dirección de carrera de ingeniería en telecomunicaciones', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(3, 3, 'Coordinador', 'Licenciatura en Ingeniería Química', NULL, 'Dirección  de la carrera de ingeniería química', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(4, 4, 'Coordinador', 'Licenciatura en Ingeniería Industrial', NULL, 'Dirección  de carrera ingeniería industrial', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(5, 5, 'Coordinador', 'Licenciatura en Ingeniería Ambiental ', 'Desarrollo de Software', 'Dirección  de carrera de ingeniería ambiental', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(6, 6, 'Coordinador', 'Licenciatura en Ingeniería Mecánica', NULL, 'Dirección  de la carrera de ingeniería mecánica', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(7, 7, 'Coordinador', 'Licenciatura en Ingeniería Eléctronica', NULL, 'Dirección  de las carreras de ingeniería electrónica e ingeniería mecatrónica', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(8, 8, 'Coordinador', 'Licenciatura en Ingeniería Electromecánica', NULL, 'Dirección de carrera de ingeniería electromecánica', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(9, 9, 'Coordinador', 'Técnico Superior en Informática', NULL, 'Dirección de carrera de informática T.S.', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(10, 10, 'Coordinador', 'Licenciatura en Ingeniería Química', NULL, 'Dirección de carrera de química industrial T.S', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(11, 11, 'Coordinador', 'Licenciatura en Ingeniería de Telecomunicaciones', NULL, 'Dirección de carrera de ingeniería en telecomunicaciones', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(12, 12, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Robotica', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(13, 13, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(14, 14, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Robotica', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(15, 15, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(16, 16, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Seguridad de la informacion', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(17, 17, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(18, 18, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(19, 19, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Network, Inteligencia Artificial', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(20, 20, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(21, 21, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Sistemas Integrados', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(22, 22, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Dispositivos moviles', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(23, 23, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'Desarrollo de Software', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(24, 24, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', 'UX y diseño', 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(25, 25, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', NULL, 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(26, 26, 'Tutor', 'Licenciatura en Ingeniería de Sistemas', NULL, 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la comput', '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_control`
--

CREATE TABLE `table_control` (
  `control_id` int(11) NOT NULL,
  `student_record_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `value_control` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_defense_court`
--

CREATE TABLE `table_defense_court` (
  `defense_court_id` int(11) NOT NULL,
  `student_record_id` int(11) NOT NULL,
  `person_student_id` int(11) NOT NULL,
  `person_teacher_id_1` int(11) NOT NULL,
  `person_teacher_id_2` int(11) NOT NULL,
  `person_teacher_id_3` int(11) NOT NULL,
  `defensed` datetime DEFAULT NULL,
  `place_defense` varchar(255) DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_payment_history`
--

CREATE TABLE `table_payment_history` (
  `payment_history_id` int(11) NOT NULL,
  `student_record_id` int(11) NOT NULL,
  `payment` decimal(10,0) NOT NULL,
  `payment_code` varchar(16) DEFAULT NULL,
  `name_bank` varchar(26) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_person`
--

CREATE TABLE `table_person` (
  `person_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `ci` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `cellphone` varchar(16) DEFAULT NULL,
  `telephone` varchar(16) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `passwords` varchar(120) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `table_person`
--

INSERT INTO `table_person` (`person_id`, `first_name`, `last_name`, `ci`, `email`, `cellphone`, `telephone`, `city`, `address`, `passwords`, `created`, `updated`, `deleted`) VALUES
(1, 'Jamil', 'Bogan', '319275097', 'santiago.dietrich@example.net', '399.380.5699', '1-117-477-8224', 'Jonesview', '8167 Hillary Court\nNorth Kirstinmouth, VT 55643-5736', '6436a7dca26cdcc68d2632dc4932e331cf563aa3', '2006-04-02 03:45:05', '2011-12-24 00:29:26', '2019-05-14 17:15:50'),
(2, 'Drake', 'Wisozk', '819287492', 'bayer.augustus@example.org', '1-691-770-8355x9', '09772092351', 'Ernestburgh', '29880 Anderson Bypass\nMitchelstad, SC 77950-7975', 'fe3b54f7b8b6d80d62d23e31528ab0485df3426b', '2013-03-10 04:44:01', '1992-05-17 03:10:10', NULL),
(3, 'Lessie', 'Walsh', '459927337', 'zoila.jacobs@example.com', '1-293-564-7581x9', '(612)464-2844x07', 'Joeberg', '433 Russell Mountains\nStantonhaven, TX 43996', 'f1eb5548b71468b9d0f725d3be22f6e77c033811', '2013-07-04 09:40:44', '1989-05-13 13:52:11', NULL),
(4, 'Frank', 'Fritsch', '1449538690', 'cali43@example.net', '1-648-531-7270', '03282335873', 'New Daynatown', '498 Matilde Track Suite 412\nKshlerinview, CT 85941', 'd3388fcaf674fc7e6a3a578a4c99cda1774a411f', '1973-02-23 01:20:52', '1976-03-13 16:25:29', NULL),
(5, 'Michael', 'Flatley', '994206392', 'aferry@example.com', '+06(9)4820576882', '03393139474', 'Magdalenabury', '2609 Delia Ferry Suite 415\nLake Mortimer, MS 56094-4194', 'ef5f8996e741994be95b9bd3ef87018dcdce648b', '1993-02-18 02:54:24', '1989-08-14 15:44:41', NULL),
(6, 'Bill', 'Stokes', '1426448763', 'julie95@example.org', '090.816.2470x072', '+48(7)6311614637', 'New Bethel', '065 Johan Inlet\nWest Hermann, ME 52066', '0260d7677b9f763c2a5481ae71dde1f1faa381d4', '1989-12-01 05:24:22', '1977-01-12 14:16:55', NULL),
(7, 'Omer', 'Wehner', '69731803', 'reilly.katharina@example.net', '078.544.0540x948', '255-119-6155x081', 'Nicolasbury', '670 Streich Landing\nMarleyview, KS 93329', '9618191e4ab753d0381ef62f6bebe1fcdad00af8', '1996-05-16 09:34:24', '2009-12-10 10:36:22', NULL),
(8, 'Everette', 'Kirlin', '1285953798', 'mosciski.perry@example.com', '06881106458', '(868)251-7434', 'Medhurstville', '8799 Abel Street\nLake Uriel, WY 37175', '6fa89a577bc48bf1b40df7394acdc8fa24e368e5', '2012-03-10 14:36:38', '2009-08-21 09:31:45', NULL),
(9, 'Enid', 'Kertzmann', '1301024473', 'nitzsche.danial@example.net', '(547)444-2662', '604.617.6254x829', 'South Constantin', '4508 Nienow Light Apt. 946\nNorth Loraine, OR 88966-1440', '19b99df05a50861e2d62a9bf079a35126bde2b33', '1976-04-20 23:29:16', '2001-01-06 16:25:19', NULL),
(10, 'Eloise', 'Graham', '658271104', 'jenifer47@example.com', '211-625-4658x434', '1-873-577-0860x8', 'Evansview', '317 Verna Neck Apt. 493\nNorth Trycia, CA 22251', '8faa78b950cf62a9fb89a31cb75578ea33fc3e6b', '1986-08-10 00:30:13', '2001-09-24 15:27:51', NULL),
(11, 'Brook', 'Willms', '1275499758', 'gabrielle60@example.net', '(101)241-6096x11', '(691)820-7975x06', 'Gutkowskiland', '9266 Rex Port\nEast Cornellton, TN 23553', '75316e537252e98fc731be680874cb242ce72d8c', '2000-05-23 19:23:02', '1971-12-21 12:31:28', NULL),
(12, 'Daphney', 'Botsford', '611908229', 'ecummerata@example.net', '1-639-468-9465x7', '327-633-1788x209', 'West Vivianne', '15022 Beer Path\nNew Maynard, NJ 19561', '55645189d1e2eba8f4261ec706d9113e1ed9e3da', '1987-01-07 11:42:25', '2014-06-30 04:38:29', NULL),
(13, 'Kara', 'Beatty', '869740228', 'jeanette92@example.org', '+50(7)2194574213', '900-955-9497', 'East Genesis', '7418 Hyatt Isle\nAnastaciochester, NH 51080', '842e9306ebc2a1dbfd5f88a9065368351ed5c1f9', '1988-12-22 02:54:26', '1993-03-17 04:39:45', NULL),
(14, 'Kathlyn', 'Williamson', '1348675190', 'gisselle60@example.net', '618.685.1919', '158.339.0918x222', 'North Rebeca', '0343 Hoppe Summit\nCassandreville, WY 69754-8005', 'd48df96f1a50dcc36e140088e7e3047bf31a20a9', '1992-01-07 03:13:04', '2012-08-27 13:50:50', NULL),
(15, 'Francisco', 'Morar', '1359650258', 'maryjane20@example.com', '959.728.8319', '05369215967', 'Botsfordchester', '601 Rice Heights\nEast Sharon, NJ 64982-9462', 'eab6bacbea07ed7708b1b1fcb93d4dc186af0277', '1997-10-02 07:02:36', '1973-02-25 13:30:59', NULL),
(16, 'Reagan', 'Schamberger', '38225321', 'xconnelly@example.org', '1-119-701-3696', '1-410-786-4870', 'Roweton', '32960 Jammie Path Apt. 290\nEast Nikkoton, ID 80140-2469', 'db3bc65f2e0f6a48274aaa999d4d4554819f394b', '1986-03-10 14:42:02', '1976-05-14 11:17:41', NULL),
(17, 'Tiana', 'D\'Amore', '892195914', 'fking@example.org', '(845)527-7616x22', '080.035.6603x788', 'North Murphyfurt', '2726 Yost Estate Apt. 357\nPort Arno, VA 76394', 'dcdebafe1d1ae579fee789d27e59f66718d8b1fa', '2000-04-22 12:43:19', '1977-03-08 05:10:29', NULL),
(18, 'Jarrett', 'Sawayn', '1432388470', 'aniyah.hintz@example.net', '+89(7)3608229947', '297.654.7041x161', 'East Lauriestad', '697 Heller Mills Suite 532\nPort Marilouton, NE 78536', '6770b905cb1d5949bfc08fa55ae9c754177d0fe8', '1995-04-03 06:07:02', '2008-04-13 05:41:37', NULL),
(19, 'Rosella', 'Crooks', '1511555462', 'andy82@example.com', '219-877-1019x099', '1-931-069-0280x7', 'Busterbury', '92607 Trevor Extensions\nTerryhaven, KY 63027', 'ea62395869666b550c19a8b8574c5577d61858de', '2010-02-05 05:39:21', '2008-08-16 07:14:07', NULL),
(20, 'Alfonzo', 'Schneider', '728320871', 'johnston.saige@example.net', '543-811-9178x636', '117-779-6799x681', 'East Colby', '3493 Kara Dam\nEast Barrett, AL 44105-4784', 'e6d494dae1f770094730e77d88ce5160bcbe062f', '1972-05-01 10:31:31', '1974-01-18 22:10:19', NULL),
(21, 'Robyn', 'Daugherty', '294235579', 'jones.charles@example.net', '302.622.2730', '+83(8)2009747378', 'North Tremaine', '5972 Arthur Curve Apt. 428\nLillaville, IN 41763-6853', '7b67e2a58e85b98122ca633d0e1f109416946ab4', '1982-02-28 14:43:51', '2004-06-09 04:31:29', NULL),
(22, 'Brianne', 'Lynch', '924575097', 'fschulist@example.org', '1-566-869-1804x9', '464.670.7455', 'West Johanfort', '1897 Auer Mission Suite 880\nSchmelerstad, CA 37019-4882', 'f1c5ff259febdd48190f5e5665b2b9f015b8b60e', '1974-03-30 17:48:50', '2009-08-04 11:12:40', NULL),
(23, 'Rosalia', 'Muller', '1116275', 'hartmann.icie@example.net', '08773934728', '1-354-281-5579x7', 'Feeneystad', '26949 Christiansen Branch Apt. 009\nNew Alexane, TN 77797-3495', '6646eaaacb6240a7b4bab2d0c4918448218fc9bc', '2000-08-03 08:56:43', '1984-07-11 12:38:35', NULL),
(24, 'Glenda', 'D\'Amore', '1281451585', 'ray14@example.org', '870.113.5739x275', '(721)449-8001x32', 'Port Patrickberg', '5246 Rodrick Ranch\nSouth Medashire, WI 79836', '9c08656c264d46a6795f642e7741b1ac646c7c98', '1971-05-17 15:08:05', '1982-10-30 16:04:38', NULL),
(25, 'Samantha', 'Kuvalis', '446167291', 'tiara70@example.net', '(303)846-6638x30', '107-087-5324x964', 'New Abagail', '6712 Addison View Suite 350\nTobymouth, NY 16221', 'e3984897624cddad8d3b2651e7b7c63d314c6bea', '2015-08-10 15:49:21', '1983-12-10 15:29:14', NULL),
(26, 'Florencio', 'Schmidt', '1318343603', 'jones.tamia@example.org', '(883)940-7915x21', '(148)220-3702x96', 'McGlynnfurt', '786 Heathcote Plaza Apt. 239\nSouth Zoeyview, ND 32139', '828cc8b6bc09c9c410cb8816b79ff2e6f8897107', '2017-11-02 20:21:18', '2001-10-22 23:10:59', NULL),
(27, 'Jared', 'Predovic', '885352711', 'alek.hermiston@example.net', '(861)316-8758', '188-998-2296x676', 'Port Abelardo', '358 Denesik Lock\nWest Maude, DC 09333', 'dbf3ed235f98c778c81136b37cbb52526a640f3e', '1998-11-23 14:53:59', '2010-05-12 07:26:36', NULL),
(28, 'Davion', 'Rice', '1012861603', 'koss.vernice@example.net', '1-151-157-0287', '02029483749', 'Lake Vern', '25932 Weimann Pines Apt. 832\nNorth Alexis, MA 26134-8152', 'c95207c5990cb9a2570f63ff8a81388064467ace', '1982-10-31 10:50:01', '2001-11-26 02:37:21', NULL),
(29, 'Granville', 'Murray', '1316626424', 'ruth.davis@example.org', '(562)299-9347x00', '1-254-441-1670x8', 'New Erna', '12188 Jenkins Port\nAntoniettastad, WV 97758-0167', '3fe638a479ab27ae969b087d9f5330862352a577', '1978-03-30 17:02:09', '1992-06-06 21:36:56', NULL),
(30, 'Vicente', 'Cole', '57155975', 'maia.rodriguez@example.com', '1-347-937-9684x3', '233.058.0647x736', 'South Virginia', '8266 Burley Skyway\nSchummhaven, TX 64768', '9e2e59e504e83316b4cde2dabd5be95ac6c28994', '1985-09-06 12:43:19', '2009-10-27 11:46:05', NULL),
(31, 'Tanner', 'Dooley', '186358146', 'dooley.tracey@example.org', '+34(7)2767012714', '616.974.5113', 'Enoschester', '026 Chyna Fort Suite 625\nGailberg, CA 63174-4811', '466341fecbbfe4ef79a21f2eae38cad7bf22b29e', '1990-09-13 05:24:00', '1980-01-11 11:01:24', NULL),
(32, 'Velma', 'Koelpin', '354554581', 'leonor10@example.com', '(139)748-0551x56', '+21(0)3720202956', 'East Ali', '4021 Wehner Drive\nEast Bria, DE 83432-6459', 'd1c44c22cab1b1938b735bd58eae026638b3ec59', '1972-08-31 00:33:14', '2011-01-27 14:42:52', NULL),
(33, 'Molly', 'Schmitt', '631409930', 'schowalter.cyrus@example.com', '(875)456-0873', '1-529-439-5809', 'East Rey', '510 Bogisich Stream\nSouth Leraland, IN 78260-4197', 'deb1ddf05517f4157a4568528f7b7269ca639461', '2010-06-24 03:26:00', '1998-03-12 17:43:52', NULL),
(34, 'Melisa', 'Ebert', '1387970541', 'shaina.smitham@example.org', '501.891.3613x703', '192-071-2971x960', 'New Arielleburgh', '44417 Daniel Orchard Suite 458\nKadefurt, KY 95980-0754', '79454a2593501706224fc45462672e346e7ff087', '2005-08-01 19:19:12', '1971-10-25 12:25:49', NULL),
(35, 'Skyla', 'Daniel', '1535203651', 'hintz.aracely@example.net', '784-695-9891x929', '(750)295-2361x49', 'Torphyburgh', '6767 Scotty Ranch\nNew Judgetown, ID 61322-4790', 'e60d07a47b4d89dbbc9a61b95820beaaf52dc9a8', '2014-05-17 21:54:22', '2013-03-26 19:27:50', NULL),
(36, 'Flo', 'Marvin', '824136198', 'smitham.ted@example.org', '559-307-3737x967', '02809200168', 'South Emieport', '245 Liam Plains\nPort Aglae, TN 27858-1077', 'b8b465e5a91fce107e22b9f0abb26c1f932d8f44', '1975-01-18 17:39:10', '2017-06-25 23:09:44', NULL),
(37, 'Lilly', 'Bosco', '1251128524', 'rstehr@example.com', '1-387-424-5155x2', '(047)001-2237', 'Mayertville', '168 Halvorson Dam\nImaberg, OH 19459-9414', '9c8e64039aec8f8b714cf82bbd9252ba100036a6', '2005-11-03 23:30:16', '1989-06-14 19:36:53', NULL),
(38, 'Isobel', 'Lemke', '25077156', 'antonetta00@example.com', '(579)163-3032x78', '1-080-037-5502x6', 'Port Carmen', '60525 Dortha Ville\nSouth Nikki, TX 15113', 'b894424ac17c414bf695bf2a411aed525b3556ce', '1971-10-23 13:54:59', '2004-10-11 14:27:43', NULL),
(39, 'Rupert', 'Balistreri', '479111297', 'schamberger.keshaun@example.net', '+47(7)0703034021', '914-179-5577x378', 'North Kyraview', '402 Monahan Park\nCandidomouth, HI 75666', '81e147cf03378656fcce2e24297beb368c832813', '1992-06-20 11:08:26', '1979-11-26 02:51:24', NULL),
(40, 'Meredith', 'Hoeger', '906631035', 'sister.dibbert@example.net', '173-130-0968', '384-471-7440x698', 'Jacyntheberg', '55038 Koelpin Extension\nEast Felipahaven, MD 20731', '47b6393b9dfec4a96d44a683f7c180a2dc02d01e', '2017-09-10 09:37:03', '1986-04-14 15:57:16', NULL),
(41, 'Fernando', 'Kiehn', '1326291494', 'jherzog@example.net', '1-111-301-0113', '221-727-1338', 'North Ashtonfurt', '60148 Muller Vista Suite 103\nAudreyborough, HI 87994-6042', 'ac5a106e6b201301307a4af98a69bed912f036ef', '1977-05-01 10:48:18', '2018-12-26 06:17:32', NULL),
(42, 'Nick', 'Bergstrom', '1131756410', 'tessie.reynolds@example.org', '(176)561-0265x85', '(587)524-9570', 'North Hailee', '365 Gerhold Island Apt. 230\nAlyssonshire, AK 06380', '370f26261e35dafeac9eba05bf88be37451aa83c', '1978-04-06 03:05:41', '2005-10-10 03:29:42', NULL),
(43, 'Teagan', 'Bahringer', '838081179', 'shanny.schroeder@example.com', '1-289-924-4891', '516.354.8443x781', 'Arleneview', '1276 Rau Rue Suite 830\nStrosinberg, MD 15514', '872882da8cc49baa95a23a22961e09790f6ec6f1', '2007-09-28 16:40:01', '1977-07-02 16:39:57', NULL),
(44, 'Jerald', 'Gerlach', '611862898', 'otis74@example.com', '(941)078-5117', '530.530.9669', 'Port Audreyhaven', '41911 O\'Keefe Creek\nNorth Juwanstad, MA 95809-2089', '6c7fd4c53ee010c91bfb2c6fb61ad3b770468c17', '2016-04-29 02:32:15', '1984-05-17 15:32:43', NULL),
(45, 'Ramona', 'Harris', '981089156', 'brandyn20@example.net', '772-759-4305x708', '110.851.3472x377', 'Khalidmouth', '159 Damion Trafficway Apt. 041\nCletusbury, TN 16994', 'a99c5db93f5ed9c885c749a60decab9641548ed5', '1978-04-11 01:36:19', '2009-08-17 01:20:04', NULL),
(46, 'Dejuan', 'Feeney', '321863885', 'soledad.casper@example.net', '921.692.2948x567', '1-016-609-5264x8', 'South Ernie', '485 Bogisich Shores Suite 817\nNorth Destanyborough, OR 87224', '2dc0256b6797269b629ac63b8ee28172865b9957', '1978-03-25 23:30:33', '1992-10-21 17:03:28', NULL),
(47, 'Oma', 'Ward', '445703317', 'lenore39@example.com', '(834)703-2737', '708.355.5220x274', 'Kileyburgh', '517 Imani Overpass Apt. 795\nJuliaburgh, FL 25966', '4960013eface90398494571f483e43523a92121e', '1977-07-15 12:25:26', '1987-02-06 08:25:28', NULL),
(48, 'Jaylin', 'Abernathy', '491171249', 'ywaters@example.com', '(204)666-2158x74', '528-224-9951', 'East Reneeside', '8368 Imelda Camp\nWest Alexa, OK 31288-3263', '24e24e0f2317e4250f5e6665c1f58b7d4846d1f4', '2018-11-13 19:59:59', '1987-11-08 08:29:31', NULL),
(49, 'Nikki', 'Towne', '1101407974', 'meda.hahn@example.com', '788.324.0625x115', '(159)703-1277x04', 'Grahamview', '688 Johnson Run Apt. 088\nLindsayhaven, VA 67619-1816', '9e3880c1242e09837ff8126a6d514675be598610', '2000-11-07 03:49:13', '1980-03-11 17:12:12', NULL),
(50, 'Makenna', 'Gerlach', '760384303', 'cgerhold@example.org', '(592)200-4713x71', '08343700530', 'Gleasonport', '5616 Camryn Haven Suite 681\nEast Emmetside, ND 35648-1127', '9eedbd102ef469fb0f6b5afe882a8a4ac888e0fa', '2018-01-30 04:38:54', '2018-01-11 04:04:19', NULL),
(51, 'Mozelle', 'Bins', '1003535590', 'karolann.hackett@example.net', '(084)944-2263x77', '903.928.8008x551', 'Shaynemouth', '3039 Russel Meadows Apt. 536\nLockmanshire, IA 81326-6766', '5991aaaf08dd7a0b5bf66acc6b7fe40dfe271ae1', '1999-07-02 22:31:01', '1982-08-14 17:01:04', NULL),
(52, 'Timothy', 'Armstrong', '760220014', 'stanford.schaden@example.net', '150.008.4247x296', '+18(6)7373432546', 'Taramouth', '8429 Walsh Prairie\nAdamsburgh, KS 70490', '9dc32f726e791a604253a22725b60fc1efef359f', '2005-12-15 20:00:06', '1977-12-12 12:36:47', NULL),
(53, 'Nicolas', 'Wisozk', '308535479', 'jenifer23@example.org', '1-438-669-0374x9', '1-154-757-4781x1', 'Greenport', '0597 Kelsie Expressway\nLake Lavern, MD 03602-5269', 'b6541f908b6a34c547416cf56fdb6ac5dc62a4ff', '2013-05-12 03:28:46', '2018-06-18 17:13:27', NULL),
(54, 'Wallace', 'Beatty', '931772785', 'hickle.jayden@example.com', '1-551-084-9299x2', '(161)106-6441x87', 'Port Scarlettberg', '0978 Noe Roads\nAbelburgh, SD 79716-1951', '2a0bfd6b9c3c8b29f19e7a76e60ee0bf0736785b', '1983-09-04 21:35:19', '1980-09-24 05:20:53', NULL),
(55, 'Chris', 'Williamson', '407801180', 'wehner.tony@example.org', '(599)023-1433', '472.560.4780', 'Lefflerville', '0257 Lemke Field Apt. 957\nPort Ora, NJ 82453', '1caa0d205df3ce0008536537ab71d0bb5e677998', '2005-03-01 08:37:32', '1994-04-01 09:35:27', NULL),
(56, 'Randal', 'Herzog', '1220005902', 'alyce09@example.org', '897-819-2759', '880.528.8538x501', 'South Rodrick', '173 Stephon Flat\nNew Hiltonmouth, KY 94010', '8585113e3c6336231b669c3d8040a079a8ccf680', '1971-04-28 09:17:57', '2016-06-30 04:25:33', NULL),
(57, 'Jamar', 'Osinski', '1373217110', 'randy.kessler@example.org', '1-558-776-1101x9', '853.442.2604', 'East Taliaview', '2668 Stoltenberg Curve Apt. 673\nSawaynshire, SC 14734', '4c4d538c32f305ab155d5edcd1f052f3292a326b', '1983-11-17 13:05:38', '1980-09-07 08:33:17', NULL),
(58, 'Shany', 'Parisian', '102580476', 'lbartell@example.org', '1-931-197-5250x8', '+53(9)1510352168', 'Port Columbusland', '0349 Baumbach Shoals Suite 434\nSouth Augusta, IN 38558', '9fde96950361dd3bda1ba738d6761c4ea01efd6f', '1970-12-09 16:58:30', '1999-04-05 11:54:18', NULL),
(59, 'Fermin', 'Leuschke', '1118255280', 'hkeebler@example.com', '1-470-768-8766', '487.007.3695x979', 'New Maxwellmouth', '021 Roselyn Village Suite 930\nSouth Camronport, AK 68470', '4a919c2b811ccd1fb2bc10f60f93001995a5b5fc', '1986-02-18 15:54:14', '1977-05-16 20:24:19', NULL),
(60, 'Daren', 'Weimann', '1189921508', 'phyatt@example.com', '916-405-4193x113', '280.855.9328x009', 'South Suzanne', '712 Sadie Rapid\nRowanhaven, OK 46614-3682', '973ac1a6a36ed58ea72d17c523d1175a57937e80', '1987-08-06 15:10:11', '2009-10-03 19:22:18', NULL),
(61, 'Kacey', 'Jenkins', '17745440', 'kjacobs@example.org', '1-751-256-5883', '1-003-017-7542x2', 'New Della', '7155 Nella Hollow\nNew Sethshire, VA 18929-4044', '9d027ff2e29e7686c878702e63f82c02b44c6c32', '1986-12-07 23:28:22', '1983-09-09 13:21:58', NULL),
(62, 'Odessa', 'Koss', '882981306', 'kari.becker@example.net', '534.247.3275x712', '1-672-685-8683x6', 'North Hattieton', '0436 Bosco Turnpike Suite 557\nLake Jaylan, SC 74417-5726', '660d279c6eddcbc71274fb38a32e8a7ae8c3c121', '2017-01-27 20:06:47', '1971-01-17 10:08:14', NULL),
(63, 'Morton', 'Spinka', '1127266302', 'tom63@example.net', '1-855-820-1943', '748.371.7299x437', 'North Marlen', '29367 Armstrong Square\nWest Brennantown, KS 12586-0238', '3becfa0449329d53f7313974bdfc5577bb7b9c2e', '2012-03-04 18:29:56', '2013-10-02 10:46:21', NULL),
(64, 'Summer', 'Block', '1426413473', 'ibrahim75@example.com', '503.106.3150x789', '337.713.3592', 'Tressaview', '6673 Alena Bypass Suite 823\nMartinafurt, MA 19936', 'dd336f2c18f1806cfe08aca67df291bfadbdf5f6', '1993-10-21 03:23:02', '1977-05-29 08:41:53', NULL),
(65, 'Barrett', 'Jones', '723151575', 'russel.d\'angelo@example.org', '+56(2)3351773446', '07002659623', 'Jasthaven', '626 Dooley Plain\nSouth Geovannyland, HI 53621', 'ea6edaf09f40e415e0abe257236a176d53a4556e', '1995-02-19 06:17:45', '1974-11-19 00:44:19', NULL),
(66, 'Eriberto', 'Halvorson', '1317328664', 'toy.victor@example.net', '08426235711', '265.561.1421x980', 'Wisokyborough', '2307 Dooley Divide Apt. 288\nNorth Dejah, CA 77933-7529', 'f3b22afd034de387bf750068bc4aac5c834458bd', '1991-03-04 06:46:26', '1981-04-09 22:00:38', NULL),
(67, 'Bette', 'Skiles', '468575611', 'vwolf@example.net', '1-732-779-9765x6', '1-116-264-8593', 'Dachbury', '1775 Lane Corner Apt. 628\nValentineborough, DE 03353', 'f639e43419d8ba114e4b95784c20d0a421902628', '1994-12-17 02:48:23', '1981-02-09 12:23:29', NULL),
(68, 'Andy', 'Graham', '585808131', 'dorcas.robel@example.com', '1-863-138-0831x8', '+00(1)5659593960', 'North Herminiotown', '06466 Liam Drives\nLaishastad, NY 19944', '4f04f2392f990ed2f30266204e2e68247cf76c0e', '1995-02-03 19:00:43', '1993-04-13 20:29:56', NULL),
(69, 'Deshawn', 'Ritchie', '685795369', 'eula95@example.org', '1-289-824-0633x5', '(359)984-4104x44', 'Ethelbury', '35764 Mohammad River Suite 185\nPort Jayme, NM 02515', 'ec872cb0d92121093d589c1f1336ae0b87da7881', '1999-04-09 01:14:27', '2007-09-18 11:38:47', NULL),
(70, 'Valerie', 'Wilderman', '655396196', 'delfina.lind@example.com', '(046)782-3051', '799.200.6505x762', 'North Kiannaberg', '551 Barrows Burgs\nAllanberg, CO 70903-8873', '1237f1878cf3d2ea42a526f0af248a30d9faa63f', '2000-08-13 23:11:55', '1974-10-06 06:09:54', NULL),
(71, 'Cierra', 'Bartoletti', '298343418', 'anna96@example.org', '(612)452-0371x60', '04264225338', 'O\'Keefechester', '8327 Schroeder Grove\nWest Letahaven, KS 78228-7126', 'bf5e7548d5398a57fba989f13823afabc83cbeb7', '2017-01-29 12:47:41', '1973-09-17 14:52:40', NULL),
(72, 'Corbin', 'Bechtelar', '426421828', 'ryan.karl@example.net', '815-559-9598', '1-304-194-5139x9', 'Cassinstad', '5684 Declan Square Suite 727\nNew Diamond, ME 39205-4816', '471650b2ce6c8a80a5fee2df5f55aca085d2b9e7', '1991-11-11 05:00:33', '1996-06-19 01:00:30', NULL),
(73, 'Daron', 'Wisoky', '1288675540', 'glover.amelia@example.org', '1-677-312-9712x2', '722.911.8393x172', 'Port Lewisville', '459 Ledner Mill Suite 611\nNew Zulabury, HI 84745-8725', '01cf666067b1b2d85a62f3eeb82ab52795698bf7', '1992-09-30 12:05:45', '1977-03-28 16:37:44', NULL),
(74, 'Casimer', 'Lueilwitz', '1239851785', 'renner.rosemarie@example.net', '(254)398-8500', '1-782-275-4556', 'West Rebekahland', '5910 Fleta Expressway\nLake Alvinaport, WV 85471', 'f6db11b0de0928582b75486367130fb13f6e153a', '1980-01-24 15:01:32', '1999-08-23 03:56:39', NULL),
(75, 'Lennie', 'Smith', '81011183', 'gerlach.thalia@example.org', '1-693-631-3596', '295-864-9216x772', 'New Stevefurt', '615 Bernita Place Suite 488\nEast Bettyeton, MO 65790-3830', 'bd1163bb7f519c4cee93753b1efc655c55d22e88', '1983-04-17 01:29:18', '2005-11-07 02:48:14', NULL),
(76, 'Grant', 'Kozey', '403891862', 'mariane.vonrueden@example.com', '1-036-147-2517', '1-232-161-8018x6', 'West Anitashire', '088 Schimmel Shores Apt. 170\nWest Budside, WY 66495', '8279aa8de3c154253d6d6e6affb7a8680d070ce5', '1986-10-06 18:16:09', '2019-02-16 17:16:05', NULL),
(77, 'Foster', 'Olson', '389621584', 'fannie16@example.net', '1-853-614-6532', '(309)823-5586', 'New Mekhi', '72469 Leannon Way Apt. 891\nKayaville, CA 44999', 'a48f715902b51137338c78092f7705acb823c0d6', '2012-11-04 10:23:54', '1998-11-08 02:50:22', NULL),
(78, 'Felipa', 'Prohaska', '841870310', 'o\'kon.jordane@example.com', '654.621.7512x513', '04202943738', 'Sadyeborough', '484 Klocko Orchard Apt. 246\nEnidstad, NC 07227', '746430fe4643fc9a96f643de24cf8e1ccd458e4d', '2001-05-31 04:44:30', '1986-11-17 00:43:19', NULL),
(79, 'Landen', 'Windler', '308964665', 'spadberg@example.com', '1-590-836-7827x5', '1-186-545-7219', 'West Cordie', '60389 Kub Well Suite 599\nSouth Shaniyafort, WA 34216-6141', 'f772a63fac7a1cbe9be001f0f39ec0b2446c6f75', '2012-05-15 13:05:34', '1986-03-27 00:00:47', NULL),
(80, 'Hassan', 'Mann', '517439774', 'rolfson.nyah@example.org', '581.576.4706', '742.637.4072', 'South Glen', '4424 Ayla Lodge\nKayleyside, OK 49764', '957ed40973f94cf84af2c74dcc25302b84250921', '1996-10-09 14:50:46', '1973-08-13 09:57:36', NULL),
(81, 'Cortney', 'Hammes', '718988255', 'brooklyn.casper@example.net', '587-052-1570x659', '(529)275-2249x35', 'Yundtborough', '60720 Larkin Vista\nGutmannstad, AZ 88308-9024', 'e6d1ebe4b4a3b68b561e30e31848a57f0a0b1bde', '2018-10-02 12:36:49', '1989-01-19 18:40:18', NULL),
(82, 'Roxane', 'Rolfson', '719746015', 'thoppe@example.net', '084.449.9816', '(758)529-5009x15', 'North Germanberg', '981 Russel Walks\nWest Ernestinebury, KY 59135', '666d8758c9aec49e0872f29512efa3c16eeeb736', '1981-07-09 03:49:55', '1989-10-04 16:53:42', NULL),
(83, 'Luisa', 'Boehm', '1129820921', 'legros.joan@example.com', '+26(6)1207019176', '(074)092-0490x07', 'Laurianneview', '28895 Viviane Route\nAmaribury, MI 33473', 'abfcdcc13a4a871a86d744293ac6a7fef463ec2a', '1989-10-01 02:22:27', '2009-07-22 15:32:41', NULL),
(84, 'Chaya', 'Champlin', '446936745', 'aaliyah08@example.com', '(536)908-3519x34', '1-920-403-0039x8', 'West Bridgette', '60577 Kohler Island\nRodgerton, NM 00662', '63c87d7a52b63c99d1cac105d983ef4ea065f3c1', '1976-06-20 02:01:44', '2003-08-18 15:32:44', NULL),
(85, 'Carissa', 'Turner', '156791542', 'alesch@example.net', '09896020137', '(721)310-7287x65', 'West Percyport', '7953 Bernhard Ridge Suite 784\nAbshiretown, MN 13497', '261e58973b540a0ccaea5a223f5b9a36c86eab73', '1986-11-04 19:11:32', '1971-12-21 12:53:45', NULL),
(86, 'Kamille', 'Stracke', '1482582947', 'eryn12@example.net', '+81(8)2061627140', '725-108-0517', 'South Derrickmouth', '6607 Dina Lock\nSouth Abbigail, MD 50332-6236', 'a6f0ad9249756f0ee2ef9894307d154411cb1962', '2003-03-28 00:21:24', '1993-08-11 01:51:12', NULL),
(87, 'Mallie', 'Sawayn', '509552255', 'elza52@example.net', '1-718-897-8488x9', '05732965339', 'West Brycen', '0908 Abbott Square Apt. 738\nJammieshire, NH 68089', 'c4b564fa24329fad23cb7b5e716dd1f48dabdddb', '2004-01-14 01:05:13', '1979-07-28 04:44:10', NULL),
(88, 'Constance', 'Ratke', '1426632220', 'herta66@example.com', '569.957.7556x809', '554.860.0000', 'Noemieton', '727 Kayden Way\nCorkeryview, MS 90846', '7bd9b85f0b77d7cb8f077c210bee5e6e3bbe3706', '1990-06-19 17:11:48', '1985-03-13 20:52:50', NULL),
(89, 'Verda', 'Schroeder', '81208661', 'sbraun@example.net', '1-006-872-7761x6', '(113)557-2359x86', 'Lake Othafort', '503 Crist Islands\nEast Yadira, CT 85249-7947', '3f4d6f17a44532ae95a61456b4218737c91ffffb', '1994-09-04 15:05:26', '1974-05-04 13:29:42', NULL),
(90, 'Gavin', 'Lemke', '524280265', 'mitchel34@example.net', '00855458686', '325.898.1696x517', 'Port Octaviamouth', '360 Kuhlman Lock Apt. 910\nWest Ezequiel, VA 39501', '28ed3a650458cb9bf5965b8805112033aa6abec8', '1979-09-08 00:56:46', '1982-05-01 03:11:07', NULL),
(91, 'Rickey', 'Herman', '503657630', 'feeney.walter@example.com', '(789)877-6967', '+36(2)3857208025', 'Johnnyville', '9167 Franecki Circle\nBoyerview, MS 86748-8375', 'b82e3fc162d8d06184e2a6d2409776409e31f2d1', '1994-11-01 08:58:17', '2003-07-26 10:15:11', NULL),
(92, 'Freddie', 'Nienow', '90063521', 'alverta.rohan@example.org', '04740937558', '327.087.7539', 'North Nova', '77499 Schimmel Stravenue Apt. 995\nPollichmouth, OK 05500-8108', 'b7732363bf879f64145318ac3a6b34a288488b57', '1986-06-17 21:05:12', '2005-10-15 07:21:18', NULL),
(93, 'Deanna', 'Davis', '793760267', 'gerhard.sanford@example.com', '1-741-134-1387x0', '549.825.2904', 'Port Julianne', '3169 Rice Burgs Suite 636\nBoehmburgh, NY 76366', '2993f356fa0a480c691ed189ae8236debb9dffcf', '1976-03-05 19:44:27', '1995-02-15 18:38:32', NULL),
(94, 'Kelli', 'Graham', '297946228', 'qgerlach@example.net', '1-633-490-7179x1', '1-832-513-1405x7', 'Jacobsonborough', '1201 Reanna Hollow Apt. 564\nPort Kailyn, FL 06497', 'faee4fd22fe0cb69a5f5b7a6d6be906d55dae04e', '1979-04-05 10:51:15', '1971-05-31 19:19:18', NULL),
(95, 'Kayleigh', 'Nitzsche', '591632095', 'nyah.klein@example.org', '(254)619-2668', '784.866.3540', 'West Kaelaberg', '59590 Marvin Via Apt. 733\nNew Dante, WY 55071-7453', 'c5065d0e012f95c586809e6fce752dce06f2cf5e', '1992-12-05 17:57:44', '2018-10-07 08:56:21', NULL),
(96, 'Rowan', 'Bergnaum', '1012872481', 'rita.hagenes@example.net', '912-639-6412', '1-346-886-4049x5', 'Millerchester', '3016 Thurman Heights Apt. 982\nVioletteside, MD 81723-5836', 'fda0d955d49c90964b2e9a7cadc5f06d608d9b0c', '1970-11-26 06:51:49', '1977-03-01 16:13:54', NULL),
(97, 'Baby', 'Leannon', '287273110', 'kelsie72@example.net', '+74(4)3644814310', '962.344.4046x818', 'Damianfurt', '528 Barton Plaza Apt. 336\nNitzschebury, OK 20444', '355a40c95d52703d59b52371acc04f436115c11a', '2005-10-19 19:03:21', '2007-05-11 07:57:41', NULL),
(98, 'Whitney', 'Jakubowski', '1176952222', 'mozelle07@example.com', '(491)733-8676', '1-185-767-4718', 'Claudinechester', '1891 Reilly Lock\nNorth Sydneyfort, WV 91105', 'db612e0aecdc9d77d15c41e19deb74431ba380fb', '1979-09-23 22:49:47', '2006-05-23 19:27:12', NULL),
(99, 'Torrey', 'Walker', '315085310', 'dahlia45@example.net', '341-667-5978x178', '(201)181-2935x06', 'Port Rodrick', '798 Zulauf Cape\nSeanfurt, NM 43502-0473', '2ac3323371442499fd4ad41c1e242202a85a4c15', '1976-10-10 06:48:30', '2007-10-13 10:36:05', NULL),
(100, 'Gisselle', 'Champlin', '156326534', 'jessica.satterfield@example.org', '1-019-084-5472x7', '(474)191-7022', 'New Bridget', '90447 Lawrence Mountain\nJosueton, MS 15947-3362', '0e3788134ac661a63fb05cc972b57fabb30984c8', '1985-10-12 14:44:46', '2009-07-21 15:08:08', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_program_version`
--

CREATE TABLE `table_program_version` (
  `program_version_id` int(11) NOT NULL,
  `program_version` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `grade` varchar(120) DEFAULT NULL,
  `cost` decimal(10,0) NOT NULL,
  `startd` datetime DEFAULT NULL,
  `finishd` datetime DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `table_program_version`
--

INSERT INTO `table_program_version` (`program_version_id`, `program_version`, `state`, `grade`, `cost`, `startd`, `finishd`, `created`, `updated`, `deleted`) VALUES
(1, '1/2010', 'Concluido', 'Licenciatura', '10450', '2010-01-22 08:59:29', '2010-07-22 18:00:57', '2010-01-22 08:59:29', '2010-01-22 08:59:29', NULL),
(2, '1/2010', 'Concluido', 'Tecnico superior', '5570', '2010-01-22 08:59:29', '2010-07-22 18:00:57', '2010-01-22 08:59:29', '2010-01-22 08:59:29', NULL),
(3, '2/2010', 'Concluido', 'Licenciatura', '10450', '2010-07-22 08:59:29', '2010-12-15 18:00:57', '2010-07-22 08:59:29', '2010-07-22 08:59:29', NULL),
(4, '2/2010', 'Concluido', 'Tecnico superior', '5570', '2010-07-22 08:59:29', '2010-12-15 18:00:57', '2010-07-22 08:59:29', '2010-07-22 08:59:29', NULL),
(5, '1/2011', 'Concluido', 'Licenciatura', '10450', '2011-01-22 08:59:29', '2011-07-22 18:00:57', '2011-01-22 08:59:29', '2011-01-22 08:59:29', NULL),
(6, '1/2011', 'Concluido', 'Tecnico superior', '5570', '2011-01-22 08:59:29', '2011-07-22 18:00:57', '2011-01-22 08:59:29', '2011-01-22 08:59:29', NULL),
(7, '2/2011', 'Concluido', 'Licenciatura', '10450', '2011-07-22 08:59:29', '2011-12-15 18:00:57', '2011-07-22 08:59:29', '2011-07-22 08:59:29', NULL),
(8, '2/2011', 'Concluido', 'Tecnico superior', '5570', '2011-07-22 08:59:29', '2011-12-15 18:00:57', '2011-07-22 08:59:29', '2011-07-22 08:59:29', NULL),
(9, '1/2012', 'Concluido', 'Licenciatura', '10450', '2012-01-22 08:59:29', '2012-07-22 18:00:57', '2012-01-22 08:59:29', '2012-01-22 08:59:29', NULL),
(10, '1/2012', 'Concluido', 'Tecnico superior', '5570', '2012-01-22 08:59:29', '2012-07-22 18:00:57', '2012-01-22 08:59:29', '2012-01-22 08:59:29', NULL),
(11, '2/2012', 'Concluido', 'Licenciatura', '10450', '2012-07-22 08:59:29', '2012-12-15 18:00:57', '2012-07-22 08:59:29', '2012-07-22 08:59:29', NULL),
(12, '2/2012', 'Concluido', 'Tecnico superior', '5570', '2012-07-22 08:59:29', '2012-12-15 18:00:57', '2012-07-22 08:59:29', '2012-07-22 08:59:29', NULL),
(13, '1/2013', 'Concluido', 'Licenciatura', '10450', '2013-01-22 08:59:29', '2013-07-22 18:00:57', '2013-01-22 08:59:29', '2013-01-22 08:59:29', NULL),
(14, '1/2013', 'Concluido', 'Tecnico superior', '5570', '2013-01-22 08:59:29', '2013-07-22 18:00:57', '2013-01-22 08:59:29', '2013-01-22 08:59:29', NULL),
(15, '2/2013', 'Concluido', 'Licenciatura', '10450', '2013-07-22 08:59:29', '2013-12-15 18:00:57', '2013-07-22 08:59:29', '2013-07-22 08:59:29', NULL),
(16, '2/2013', 'Concluido', 'Tecnico superior', '5570', '2013-07-22 08:59:29', '2013-12-15 18:00:57', '2013-07-22 08:59:29', '2013-07-22 08:59:29', NULL),
(17, '1/2014', 'Concluido', 'Licenciatura', '10450', '2014-01-22 08:59:29', '2014-07-22 18:00:57', '2014-01-22 08:59:29', '2014-01-22 08:59:29', NULL),
(18, '1/2014', 'Concluido', 'Tecnico superior', '5570', '2014-01-22 08:59:29', '2014-07-22 18:00:57', '2014-01-22 08:59:29', '2014-01-22 08:59:29', NULL),
(19, '2/2014', 'Concluido', 'Licenciatura', '10450', '2014-07-22 08:59:29', '2014-12-15 18:00:57', '2014-07-22 08:59:29', '2014-07-22 08:59:29', NULL),
(20, '2/2014', 'Concluido', 'Tecnico superior', '5570', '2014-07-22 08:59:29', '2014-12-15 18:00:57', '2014-07-22 08:59:29', '2014-07-22 08:59:29', NULL),
(21, '1/2015', 'Concluido', 'Licenciatura', '10450', '2015-01-22 08:59:29', '2015-07-22 18:00:57', '2015-01-22 08:59:29', '2015-01-22 08:59:29', NULL),
(22, '1/2015', 'Concluido', 'Tecnico superior', '5570', '2015-01-22 08:59:29', '2015-07-22 18:00:57', '2015-01-22 08:59:29', '2015-01-22 08:59:29', NULL),
(23, '2/2015', 'Concluido', 'Licenciatura', '10450', '2015-07-22 08:59:29', '2015-12-15 18:00:57', '2015-07-22 08:59:29', '2015-07-22 08:59:29', NULL),
(24, '2/2015', 'Concluido', 'Tecnico superior', '5570', '2015-07-22 08:59:29', '2015-12-15 18:00:57', '2015-07-22 08:59:29', '2015-07-22 08:59:29', NULL),
(25, '1/2016', 'Concluido', 'Licenciatura', '10450', '2016-01-22 08:59:29', '2016-07-22 18:00:57', '2016-01-22 08:59:29', '2016-01-22 08:59:29', NULL),
(26, '1/2016', 'Concluido', 'Tecnico superior', '5570', '2016-01-22 08:59:29', '2016-07-22 18:00:57', '2016-01-22 08:59:29', '2016-01-22 08:59:29', NULL),
(27, '2/2016', 'Concluido', 'Licenciatura', '10450', '2016-07-22 08:59:29', '2016-12-15 18:00:57', '2016-07-22 08:59:29', '2016-07-22 08:59:29', NULL),
(28, '2/2016', 'Concluido', 'Tecnico superior', '5570', '2016-07-22 08:59:29', '2016-12-15 18:00:57', '2016-07-22 08:59:29', '2016-07-22 08:59:29', NULL),
(29, '1/2017', 'Concluido', 'Licenciatura', '10450', '2017-01-22 08:59:29', '2017-07-22 18:00:57', '2017-01-22 08:59:29', '2017-01-22 08:59:29', NULL),
(30, '1/2017', 'Concluido', 'Tecnico superior', '5570', '2017-01-22 08:59:29', '2017-07-22 18:00:57', '2017-01-22 08:59:29', '2017-01-22 08:59:29', NULL),
(31, '2/2017', 'Concluido', 'Licenciatura', '10450', '2017-07-22 08:59:29', '2017-12-15 18:00:57', '2017-07-22 08:59:29', '2017-07-22 08:59:29', NULL),
(32, '2/2017', 'Concluido', 'Tecnico superior', '5570', '2017-07-22 08:59:29', '2017-12-15 18:00:57', '2017-07-22 08:59:29', '2017-07-22 08:59:29', NULL),
(33, '1/2018', 'Concluido', 'Licenciatura', '10450', '2018-01-22 08:59:29', '2018-07-22 18:00:57', '2018-01-22 08:59:29', '2018-01-22 08:59:29', NULL),
(34, '1/2018', 'Concluido', 'Tecnico superior', '5570', '2018-01-22 08:59:29', '2018-07-22 18:00:57', '2018-01-22 08:59:29', '2018-01-22 08:59:29', NULL),
(35, '2/2018', 'Concluido', 'Licenciatura', '10450', '2018-07-22 08:59:29', '2018-12-15 18:00:57', '2018-07-22 08:59:29', '2018-07-22 08:59:29', NULL),
(36, '2/2018', 'Concluido', 'Tecnico superior', '5570', '2018-07-22 08:59:29', '2018-12-15 18:00:57', '2018-07-22 08:59:29', '2018-07-22 08:59:29', NULL),
(37, '1/2019', 'Vigente', 'Licencitura', '10450', '2019-01-15 08:59:29', '2019-07-12 18:00:57', '2019-01-12 08:59:29', '2019-01-12 08:59:29', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_student_record`
--

CREATE TABLE `table_student_record` (
  `student_record_id` int(11) NOT NULL,
  `person_student_id` int(11) NOT NULL,
  `program_version_id` int(11) NOT NULL,
  `career` varchar(120) NOT NULL,
  `cu` varchar(15) NOT NULL,
  `tuition` decimal(10,0) DEFAULT NULL,
  `on_account` decimal(10,0) DEFAULT '0',
  `type_register` varchar(120) NOT NULL,
  `state` varchar(120) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_tracing`
--

CREATE TABLE `table_tracing` (
  `tracing_id` int(11) NOT NULL,
  `student_record_id` int(11) NOT NULL,
  `person_student_id` int(11) NOT NULL,
  `person_tutor_id` int(11) NOT NULL,
  `detail` varchar(511) DEFAULT NULL,
  `documents_attached` varchar(127) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_tutor_assignment`
--

CREATE TABLE `table_tutor_assignment` (
  `tutor_assignment_id` int(11) NOT NULL,
  `student_record_id` int(11) NOT NULL,
  `person_student_id` int(11) NOT NULL,
  `person_tutor_id` int(11) NOT NULL,
  `finishd` datetime DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `table_type`
--

CREATE TABLE `table_type` (
  `type_id` int(11) NOT NULL,
  `name_type` varchar(255) NOT NULL,
  `label_type` varchar(255) NOT NULL,
  `foreign_type_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `table_type`
--

INSERT INTO `table_type` (`type_id`, `name_type`, `label_type`, `foreign_type_id`, `created`, `updated`, `deleted`) VALUES
(1, 'ROOT', 'appointment', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(2, 'Coordinador', 'appointment', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(3, 'Administracion', 'appointment', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(4, 'Tutor', 'appointment', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(5, 'Dirección  de las carreras de ing. De sistemas, animación digital, tecnologías de la información y ciencias de la computación', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(6, 'Dirección de carrera de ingeniería en telecomunicaciones', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(7, 'Dirección  de la carrera de ingeniería química', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(8, 'Dirección  de carrera ingeniería industrial', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(9, 'Dirección  de carrera de ingeniería ambiental', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(10, 'Dirección  de la carrera de ingeniería mecánica', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(11, 'Dirección  de las carreras de ingeniería electrónica e ingeniería mecatrónica', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(12, 'Dirección de carrera de ingeniería electromecánica', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(13, 'Dirección de carrera de informática T.S.', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(14, 'Dirección de carrera de química industrial T.S.', 'career_direction', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(15, 'Licenciatura en Ingeniería de Sistemas', 'profession', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(16, 'Licenciatura en Ingeniería En Ciencias En Computación ', 'profession', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(17, 'Licenciatura en Ingeniería En Tecnologías de Información y Seguridad ', 'profession', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(18, 'Licenciatura en Ingeniería en Diseño y Animación Digital ', 'profession', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(19, 'Licenciatura en Ingeniería de Telecomunicaciones ', 'profession', 6, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(20, 'Licenciatura en Ingeniería Química ', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(21, 'Licenciatura en Ingeniería Industrial ', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(22, 'Licenciatura en Ingeniería de Alimentos ', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(23, 'Licenciatura en Ingeniería Ambiental ', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(24, 'Licenciatura en Ingeniería de Alimentos', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(25, 'Técnico Superior en  Petroleo y Gas Natural ', 'profession', 7, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(26, 'Licenciatura en Ingeniería Mecánica ', 'profession', 10, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(27, 'Licenciatura en Ingeniería Electromecánica ', 'profession', 12, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(28, 'Licenciatura en Ingeniería Eléctrica ', 'profession', 11, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(29, 'Licenciatura en Ingeniería Eléctronica ', 'profession', 11, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(30, 'Técnico Superior en Informática ', 'profession', 13, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(31, 'Técnico Superior en Química Industrial ', 'profession', 13, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(32, 'Técnico Superior en Industrias de la Alimentación ', 'profession', 13, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(33, 'Desarrollo de Software', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(34, 'Network, Inteligencia Artificial', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(35, 'Seguridad de la informacion', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(36, 'Sistemas Integrados', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(37, 'Desarrollo Web', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(38, 'Dispositivos moviles', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(39, 'UX y diseño', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(40, 'Robotica', 'specialty', 5, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(41, 'Nuevo', 'type_register', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(42, 'Ampliacion', 'type_register', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(43, 'Reincorporacion', 'type_register', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL),
(44, 'Abortado', 'type_register', NULL, '2019-05-14 17:15:31', '2019-05-14 17:15:31', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `table_appointment`
--
ALTER TABLE `table_appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `person_id` (`person_id`);

--
-- Indices de la tabla `table_control`
--
ALTER TABLE `table_control`
  ADD PRIMARY KEY (`control_id`),
  ADD KEY `student_record_id` (`student_record_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indices de la tabla `table_defense_court`
--
ALTER TABLE `table_defense_court`
  ADD PRIMARY KEY (`defense_court_id`),
  ADD KEY `student_record_id` (`student_record_id`),
  ADD KEY `person_student_id` (`person_student_id`),
  ADD KEY `person_teacher_id_1` (`person_teacher_id_1`),
  ADD KEY `person_teacher_id_2` (`person_teacher_id_2`),
  ADD KEY `person_teacher_id_3` (`person_teacher_id_3`);

--
-- Indices de la tabla `table_payment_history`
--
ALTER TABLE `table_payment_history`
  ADD PRIMARY KEY (`payment_history_id`),
  ADD KEY `student_record_id` (`student_record_id`);

--
-- Indices de la tabla `table_person`
--
ALTER TABLE `table_person`
  ADD PRIMARY KEY (`person_id`),
  ADD UNIQUE KEY `ci` (`ci`);

--
-- Indices de la tabla `table_program_version`
--
ALTER TABLE `table_program_version`
  ADD PRIMARY KEY (`program_version_id`);

--
-- Indices de la tabla `table_student_record`
--
ALTER TABLE `table_student_record`
  ADD PRIMARY KEY (`student_record_id`),
  ADD KEY `person_student_id` (`person_student_id`),
  ADD KEY `program_version_id` (`program_version_id`);

--
-- Indices de la tabla `table_tracing`
--
ALTER TABLE `table_tracing`
  ADD PRIMARY KEY (`tracing_id`),
  ADD KEY `student_record_id` (`student_record_id`),
  ADD KEY `person_student_id` (`person_student_id`),
  ADD KEY `person_tutor_id` (`person_tutor_id`);

--
-- Indices de la tabla `table_tutor_assignment`
--
ALTER TABLE `table_tutor_assignment`
  ADD PRIMARY KEY (`tutor_assignment_id`),
  ADD KEY `student_record_id` (`student_record_id`),
  ADD KEY `person_student_id` (`person_student_id`),
  ADD KEY `person_tutor_id` (`person_tutor_id`);

--
-- Indices de la tabla `table_type`
--
ALTER TABLE `table_type`
  ADD PRIMARY KEY (`type_id`),
  ADD KEY `foreign_type_id` (`foreign_type_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `table_appointment`
--
ALTER TABLE `table_appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `table_control`
--
ALTER TABLE `table_control`
  MODIFY `control_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_defense_court`
--
ALTER TABLE `table_defense_court`
  MODIFY `defense_court_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_payment_history`
--
ALTER TABLE `table_payment_history`
  MODIFY `payment_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_person`
--
ALTER TABLE `table_person`
  MODIFY `person_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `table_program_version`
--
ALTER TABLE `table_program_version`
  MODIFY `program_version_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `table_student_record`
--
ALTER TABLE `table_student_record`
  MODIFY `student_record_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_tracing`
--
ALTER TABLE `table_tracing`
  MODIFY `tracing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_tutor_assignment`
--
ALTER TABLE `table_tutor_assignment`
  MODIFY `tutor_assignment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `table_type`
--
ALTER TABLE `table_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `table_appointment`
--
ALTER TABLE `table_appointment`
  ADD CONSTRAINT `table_appointment_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `table_person` (`person_id`);

--
-- Filtros para la tabla `table_control`
--
ALTER TABLE `table_control`
  ADD CONSTRAINT `table_control_ibfk_1` FOREIGN KEY (`student_record_id`) REFERENCES `table_student_record` (`student_record_id`),
  ADD CONSTRAINT `table_control_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `table_type` (`type_id`);

--
-- Filtros para la tabla `table_defense_court`
--
ALTER TABLE `table_defense_court`
  ADD CONSTRAINT `table_defense_court_ibfk_1` FOREIGN KEY (`student_record_id`) REFERENCES `table_student_record` (`student_record_id`),
  ADD CONSTRAINT `table_defense_court_ibfk_2` FOREIGN KEY (`person_student_id`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_defense_court_ibfk_3` FOREIGN KEY (`person_teacher_id_1`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_defense_court_ibfk_4` FOREIGN KEY (`person_teacher_id_2`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_defense_court_ibfk_5` FOREIGN KEY (`person_teacher_id_3`) REFERENCES `table_person` (`person_id`);

--
-- Filtros para la tabla `table_payment_history`
--
ALTER TABLE `table_payment_history`
  ADD CONSTRAINT `table_payment_history_ibfk_1` FOREIGN KEY (`student_record_id`) REFERENCES `table_student_record` (`student_record_id`);

--
-- Filtros para la tabla `table_student_record`
--
ALTER TABLE `table_student_record`
  ADD CONSTRAINT `table_student_record_ibfk_1` FOREIGN KEY (`person_student_id`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_student_record_ibfk_2` FOREIGN KEY (`program_version_id`) REFERENCES `table_program_version` (`program_version_id`);

--
-- Filtros para la tabla `table_tracing`
--
ALTER TABLE `table_tracing`
  ADD CONSTRAINT `table_tracing_ibfk_1` FOREIGN KEY (`student_record_id`) REFERENCES `table_student_record` (`student_record_id`),
  ADD CONSTRAINT `table_tracing_ibfk_2` FOREIGN KEY (`person_student_id`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_tracing_ibfk_3` FOREIGN KEY (`person_tutor_id`) REFERENCES `table_person` (`person_id`);

--
-- Filtros para la tabla `table_tutor_assignment`
--
ALTER TABLE `table_tutor_assignment`
  ADD CONSTRAINT `table_tutor_assignment_ibfk_1` FOREIGN KEY (`student_record_id`) REFERENCES `table_student_record` (`student_record_id`),
  ADD CONSTRAINT `table_tutor_assignment_ibfk_2` FOREIGN KEY (`person_student_id`) REFERENCES `table_person` (`person_id`),
  ADD CONSTRAINT `table_tutor_assignment_ibfk_3` FOREIGN KEY (`person_tutor_id`) REFERENCES `table_person` (`person_id`);

--
-- Filtros para la tabla `table_type`
--
ALTER TABLE `table_type`
  ADD CONSTRAINT `table_type_ibfk_1` FOREIGN KEY (`foreign_type_id`) REFERENCES `table_type` (`type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
