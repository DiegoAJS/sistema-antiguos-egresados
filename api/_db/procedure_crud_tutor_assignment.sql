USE PGAENG;

DROP PROCEDURE `pgaeng`.`crud_table_tutor_assignment`;

DELIMITER $$

CREATE PROCEDURE crud_table_tutor_assignment(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _tutor_assignment_id INT,			/* id autogenerado*/
 IN _student_record_id INT,				/* id registro de estudiante */
 IN _person_student_id INT,				/* id persona, tipo estudiante  */
 IN _person_tutor_id INT,				/* id persona, tipo tutor */
 IN _finishd DATETIME					/* fecha de culminacion*/)

BEGIN

 CASE _operation 
	WHEN 1 THEN 
    IF NOT EXISTS(SELECT * FROM table_tutor_assignment WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id AND person_tutor_id=_person_tutor_id) THEN 
		INSERT INTO table_tutor_assignment(student_record_id, person_student_id, person_tutor_id, finishd) VALUE (_student_record_id, _person_student_id, _person_tutor_id, _finishd);
        SELECT tutor_assignment_id, TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_tutor_assignment WHERE student_record_id=_student_record_id AND person_student_id=_person_student_id AND person_tutor_id=_person_tutor_id LIMIT 1; 
	ELSE 
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
    
	WHEN 2 THEN
    IF EXISTS(SELECT * FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id AND deleted IS NULL) THEN 
		SELECT *,TRUE AS "status", "Correcto registro LEIDO" AS msg  FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id AND deleted IS NULL) THEN 
		UPDATE table_tutor_assignment
        SET student_record_id= _student_record_id, 
			person_student_id=_person_student_id,
            person_tutor_id=_person_tutor_id,
            finishd=_finishd, 
            updated = now()
        WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
        SELECT tutor_assignment_id,TRUE AS "status", "Correcto registro EDITADO" AS msg  FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id;  
	ELSE 
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
	WHEN 4 THEN 
    IF EXISTS (SELECT * FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id AND deleted IS NULL) THEN
		UPDATE table_tutor_assignment SET deleted=NOW() WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
    WHEN 5 THEN 
    IF EXISTS (SELECT * FROM table_tutor_assignment WHERE tutor_assignment_id=_tutor_assignment_id AND deleted IS NULL) THEN
		UPDATE table_tutor_assignment SET deleted=NULL WHERE tutor_assignment_id=_tutor_assignment_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro HABILITADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
	WHEN 6 THEN
		SELECT * FROM table_tutor_assignment;
    
    WHEN 7 THEN
		SELECT * FROM table_tutor_assignment WHERE deleted IS NULL;
    
	END CASE; 
    
END$$

/* Area Test
call crud_table_tutor_assignment("operacion","id",student_record_id, person_student_id, person_tutor_id, finishd);
insertar
call crud_table_tutor_assignment(1,null,1, 1, 2, "2019-10-08 16:48:00");
leer
call crud_table_tutor_assignment(2,1,null, null, null, null);
editar
call crud_table_tutor_assignment(3,1,1, 2, 1, "2019-10-09 16:48:00");
eliminar
call crud_table_tutor_assignment(4,1,null, null, null, null);
lista
call crud_table_tutor_assignment(5,null,null, null, null, null);
*/