USE PGAENG;

DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_student_record`;
CREATE PROCEDURE crud_table_student_record(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _student_record_id INT,				/* resgistro de estudiante autogenerado*/
 IN _person_student_id INT, 			/* id persona estudiante*/
 IN _program_version_id INT,			/* id programa asignado*/
 IN _career VARCHAR(255),				/* carrera*/
 IN _career_direction VARCHAR(511),		/* direccion de carreras */
 IN _cu VARCHAR(15),					/* CU universitario*/
 IN _cost DECIMAL,						/* pago total de la colegiatura*/
 IN _type_register VARCHAR(120),		/* tipo de registro {nuevo, ampliacion, reincorporacion, abortado}*/
 IN _state VARCHAR(120) 				/* estado del estudiante {vigente, habilitado, concluido, abandono}*/
)
BEGIN
 CASE _operation 
	WHEN 1 THEN 
	IF NOT EXISTS (SELECT * FROM table_student_record WHERE person_student_id = _person_student_id  
														AND program_version_id=_program_version_id 
                                                        AND career=_career) THEN
        INSERT INTO table_student_record(person_student_id, program_version_id, career, career_direction, cu, cost, type_register, state)
		VALUE (_person_student_id, _program_version_id, _career, _career_direction, _cu, _cost, _type_register, _state);
SELECT 
    student_record_id,
    TRUE AS 'status',
    'Correcto registro CREADO' AS msg
FROM
    table_student_record
WHERE
    person_student_id = _person_student_id
        AND program_version_id = _program_version_id
        AND career = _career
LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error ya existe registro" AS msg;
    END IF;
    
	WHEN 2 THEN
    IF EXISTS (SELECT * FROM table_student_record WHERE student_record_id=_student_record_id AND deleted IS NULL) THEN 
		SELECT *, TRUE AS "status", "Correcto registro LEIDO" AS msg  FROM table_student_record WHERE student_record_id=_student_record_id LIMIT 1;
	ELSE 
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
    
	WHEN 3 THEN 
    IF EXISTS (SELECT * FROM table_student_record WHERE student_record_id=_student_record_id AND deleted IS NULL) THEN 
		UPDATE table_student_record
        SET person_student_id = _person_student_id,   
			program_version_id = _program_version_id,
            career = _career,
            cu = _cu,
            cost = _cost,
            type_register=_type_register,
            state = _state, 
            updated = now()
        WHERE student_record_id=_student_record_id LIMIT 1;
		SELECT 
    student_record_id,
    TRUE AS 'status',
    'Correcto registro EDITADO' AS msg
FROM
    table_student_record
WHERE
    student_record_id = _student_record_id
LIMIT 1;
	ELSE 
		SELECT FALSE AS "status", "Error de registro" AS msg;
	END IF;
        
	WHEN 4 THEN 
    IF EXISTS(SELECT * FROM table_student_record WHERE student_record_id=_student_record_id AND deleted IS NULL) THEN 
		UPDATE table_student_record SET deleted = NOW() WHERE student_record_id=_student_record_id LIMIT 1;
SELECT TRUE AS 'status', 'Correcto registro ELIMINADO' AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro" AS msg;
	END IF;
    
    WHEN 5 THEN 
    IF EXISTS(SELECT * FROM table_student_record WHERE student_record_id=_student_record_id AND deleted IS NOT NULL) THEN 
		UPDATE table_student_record SET deleted = NULL WHERE student_record_id=_student_record_id LIMIT 1;
        SELECT TRUE AS 'status', 'Correcto registro HABILITADO' AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro" AS msg;
	END IF;
	
	/* LOGIN ESTUDIANTES */
	WHEN 6 THEN 
    IF EXISTS(select b.career from table_person a INNER JOIN table_student_record b on a.person_id = b.person_student_id WHERE a.ci=_person_student_id AND b.cu=_cu AND b.deleted IS NULL) THEN
		select a.person_id, a.ci, a.first_name, a.last_name, b.student_record_id, b.cu, b.career, b.career_direction, TRUE AS 'status', 'Correcto registro HABILITADO' AS msg from table_person a INNER JOIN table_student_record b on a.person_id = b.person_student_id WHERE a.ci=_person_student_id AND b.cu=_cu AND b.deleted IS NULL;
	ELSE
		SELECT FALSE AS "status", "Error no hay estudiante" AS msg;
    END IF;
	
	END CASE; 
    
END$$

DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_student_record`;
CREATE PROCEDURE list_table_student_record(
 IN _operation INT,						/* operaciones{ 1:rootall, 2:all, 3:direccion, 4:versiones}*/
 IN _person_student_id INT, 			/* id persona estudiante*/
 IN _career VARCHAR(255),				/* carrera*/
 IN _career_direction VARCHAR(511)		/* direccion de carreras */)
BEGIN
 CASE _operation 
		
	WHEN 1 THEN
		SELECT * FROM table_student_record;
        
	WHEN 2 THEN
		SELECT * FROM table_student_record WHERE deleted IS NULL;
    
     /* DIRECION ESTUDIANTES*/
    WHEN 3 THEN
		IF EXISTS(select a.* from table_person a INNER JOIN table_student_record b on a.person_id = b.person_student_id WHERE career_direction=_career_direction AND b.deleted IS NULL) THEN
			select DISTINCT a.* from table_person a INNER JOIN table_student_record b on a.person_id = b.person_student_id WHERE career_direction=_career_direction AND b.deleted IS NULL;
		END IF;	
        
	/* ESTUDIANTE CARRERAS */
     WHEN 4 THEN 
		IF EXISTS(SELECT DISTINCT a.career FROM table_student_record a INNER JOIN table_person b ON a.person_student_id = b.person_id WHERE a.person_student_id=_person_student_id AND a.career_direction=_career_direction AND a.deleted IS NULL) THEN 
			SELECT DISTINCT a.career FROM table_student_record a INNER JOIN table_person b ON a.person_student_id = b.person_id WHERE a.person_student_id=_person_student_id AND a.career_direction=_career_direction AND a.deleted IS NULL;
		END IF;
        
     /* CARRERA VERSIONES */
     WHEN 5 THEN 
		IF EXISTS(SELECT b.* FROM table_student_record a INNER JOIN table_program_version b ON a.program_version_id = b.program_version_id WHERE a.person_student_id=_person_student_id AND a.career=_career AND a.deleted IS NULL) THEN 
			SELECT a.person_student_id, a.career, b.* FROM table_student_record a INNER JOIN table_program_version b ON a.program_version_id = b.program_version_id WHERE a.person_student_id=_person_student_id AND a.career=_career AND a.deleted IS NULL;
		END IF;
     
	END CASE; 
    
END$$


/* Area Test
call crud_table_student_record("operacion","id",person_student_id, program_version_id, career, cu, tuition, type_register, state);

/* insertar return id* /
call crud_table_student_record(1,null,27, 4, "Computacion","Direccion de sistemas", "36-1234", 100000, "nuevo", "habilitado");

/* leer con id* /
call crud_table_student_record(2,2,null, null, null, null, null, null, null);

/* Editar  return id* /
call crud_table_student_record(1,null,27, , "Sistemas","Direccion de sistemas", "35-1234", 100000, "nuevo", "habilitado");

/* Eliminar * /
call crud_table_student_record(4,1,null, null, null, null, null, null, null);

/* Lista * /
call list_table_student_record(4,4, NULL, "career_direction 2");

select * from table_student_record;*/