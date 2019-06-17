USE PGAENG;


DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_person`;
CREATE PROCEDURE crud_table_person(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:undelete , 6:login }*/
 IN _person_id INT,						/* id persona */
 IN _first_name VARCHAR(255), 			/* nombre*/
 IN _last_name VARCHAR(255), 			/* apellido*/
 IN _ci varchar(120), 					/* carnet de identidad*/
 IN _email VARCHAR(120),				/* correo electronico*/
 IN _cellphone VARCHAR(16),				/* celular */
 IN _telephone VARCHAR(16),				/* telefono */
 IN _city VARCHAR(120),					/* ciudad*/
 IN _address VARCHAR(120),				/* direccion*/
 IN _passwords VARCHAR(120)				/* password*/ )
BEGIN

 CASE _operation
	/* I N S E R T A R */
	WHEN 1 THEN 
		IF NOT EXISTS(SELECT person_id FROM table_person WHERE table_person.ci = _ci OR email =_email) THEN
			INSERT INTO table_person(first_name, last_name, ci, email, cellphone, telephone, city, address, passwords) VALUE (_first_name, _last_name, _ci, _email, _cellphone, _telephone, _city, _address, _passwords);
            SELECT person_id, true AS "status", "Correcto registro CREADO" AS msg FROM table_person WHERE table_person.ci=_ci LIMIT 1;
		ELSE
			SELECT false AS "status", "Error de registro ya existe el CI O CORREO" AS msg;
		END IF;
	
    /* L E E R */
	WHEN 2 THEN
		IF EXISTS(SELECT * FROM table_person WHERE person_id=_person_id AND deleted IS NULL ) THEN
			SELECT *, true AS "status", "Correcto registro LEIDO"AS msg FROM table_person WHERE table_person.person_id=_person_id LIMIT 1;
		ELSE
			SELECT false AS "status", "Error no existe registro" AS msg;
        END IF;
	
    /* A C T  U A L I Z A R */
	WHEN 3 THEN
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id 
													AND email = _email
                                                    AND ci = _ci 
                                                    AND table_person.deleted IS NULL) THEN
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
            SELECT person_id, true AS "status", "Correcto registro ACTUALIZADO" AS msg FROM table_person WHERE table_person.person_id = _person_id  LIMIT 1; 
        ELSE
			SELECT false AS "status", "Error NO EDITADO" AS msg;
        END IF;
        
    /* E L I  M I N  A R */ 
	WHEN 4 THEN 
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id AND table_person.deleted IS NULL) THEN
			UPDATE table_person SET deleted = NOW()  WHERE table_person.person_id = _person_id LIMIT 1;
            SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
        ELSE
			SELECT false AS "status", "Error no existe registro" AS msg;
        END IF;
    
    /* D E S E L I M I N A R*/
	WHEN 5 THEN 
		IF EXISTS(SELECT * FROM table_person WHERE table_person.person_id=_person_id AND table_person.deleted IS NOT NULL) THEN
			UPDATE table_person SET deleted = NULL  WHERE table_person.person_id = _person_id LIMIT 1;
            SELECT true AS "status", "Correcto registro HABILITADO" AS msg;
        ELSE
			SELECT false AS "status", "Error no existe registro" AS msg;
        END IF;	
	
    /* LO G I N */
    WHEN 6 THEN
		IF EXISTS(select * from table_person WHERE  ci = _ci AND passwords = _passwords AND table_person.deleted IS NULL) THEN
			select person_id,first_name, last_name, ci, email, true AS "status","Correcto LOGIN" AS msg from table_person WHERE  ci = _ci AND passwords = _passwords LIMIT 1;
		ELSE 
			SELECT FALSE AS "status", "Error NO LOGIN" AS msg;
		END IF;
        
	END CASE; 
END$$


DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_person`;
CREATE PROCEDURE list_table_person(
 IN _operation INT,						/* operaciones{ 1:rootall, 2:all, 3:cargos, 4:tutor }*/
 IN _person_id INT						/* id persona */) 
BEGIN

 CASE _operation
 
    /* LISTA DE TODO*/
    WHEN 1 THEN
		SELECT * FROM table_person;
	
    /* LISTA DE LOS NO ELIMINADOS*/
	WHEN 2 THEN 
		SELECT * FROM table_person WHERE table_person.deleted IS NULL;
        
    /* CARGOS */
    WHEN 3 THEN
		IF EXISTS(select b.appointment from table_person a INNER JOIN table_position b on a.person_id = b.person_id WHERE b.person_id=_person_id AND a.deleted IS NULL AND b.deleted IS NULL) THEN
			select b.appointment, b.career_direction from table_person a INNER JOIN table_position b on a.person_id = b.person_id WHERE b.person_id=_person_id AND a.deleted IS NULL AND b.deleted IS NULL;
		END IF;
	
	/* TUTOR - ESTUDIANTES*/
	WHEN 4 THEN
		IF EXISTS(select a.* from table_person a INNER JOIN table_tutor_assignment b on a.person_id = b.person_tutor_id WHERE b.person_tutor_id=_person_id AND a.deleted IS NULL AND b.deleted IS NULL) THEN
			select a.* from table_person a INNER JOIN table_tutor_assignment b on a.person_id = b.person_tutor_id WHERE b.person_tutor_id=_person_id;
		END IF;        
	
	END CASE; 
END$$

/* Area Test
call crud_table_person("operacion","id",first_name, last_name, ci, email, cellphone, telephone, city, address, passwords);

/* insertar return id* /
call crud_table_person(1,null,"first_name", "last_nam", "ci 5", "email",12345678 , 12345678, "city", "address", "pass");

/* leer con id* /
call crud_table_person(2,1,null,null, null, null, null, null, null, null,null);

/* Editar persona return id* /
call crud_table_person(3,1,"first_name 2", "last_name 2", "ci", "email 2",12345678 , 12345678, "city", "address", "pass");

/* Eliminar persona* /
call crud_table_person(4,2,null,null, null, null, null, null, null, null,null);

/* Lista persona* /
call crud_table_person(7,null,null,null, null, null, null, null, null, null,null);

select * from table_person;*/