USE pgaeng;

DROP PROCEDURE `pgaeng`.`crud_table_position`;

DELIMITER $$

CREATE PROCEDURE crud_table_position(
	IN _operation INT, 					/* operacion a realizar*/
	IN _position_id INT,				/* id auto generado*/
	IN _person_id INT,					/* id persona*/
    IN _appointment VARCHAR(120),		/* nombre de roles o asignaciones{Docente,coordinador, adm, root}*/
    IN _profession TEXT,				/* profecion { Ing sistemas, Ing Quimico, etc}*/
	IN _specialty TEXT,					/* Especialidad { Desarrollo de Software, Network, Inteligencia Artificial, Seguridad de la informacion, Sistemas Integrados, Desarrollo Web, Dispositivos moviles, UX y diseño, Robotica}*/
    IN _career_direction VARCHAR(120)	/* direccion de carreras */
)

BEGIN

CASE _operation 
	WHEN 1 THEN 
    IF NOT EXISTS( SELECT * FROM table_position WHERE person_id = _person_id AND appointment= _appointment AND career_direction=_career_direction) THEN 
		INSERT INTO table_position(person_id, appointment, profession, specialty, career_direction) VALUE (_person_id, _appointment, _profession, _specialty, _career_direction);
        SELECT position_id,true AS "status", "Correcto registro CREADO" AS msg FROM table_position WHERE person_id = _person_id AND appointment= _appointment AND career_direction=_career_direction LIMIT 1;
    ELSE
		SELECT false AS "status", "Error de registro ya existe " AS msg;
    END IF;        
	WHEN 2 THEN
    IF EXISTS( SELECT * FROM table_position WHERE position_id= _position_id AND deleted IS NULL) THEN 
		SELECT *,true AS "status", "Correcto registro LEIDO" AS msg FROM table_position WHERE position_id= _position_id LIMIT 1;
	ELSE 
		SELECT false AS "status", "Error de registro NO existe " AS msg;
	END IF;
	WHEN 3 THEN 
     IF EXISTS( SELECT * FROM table_position WHERE position_id= _position_id AND deleted IS NULL) THEN 
		UPDATE table_position  
        SET person_id = _person_id, 
            appointment = _appointment,
            profession = _profession,
            specialty = _specialty,
            career_direction = _career_direction, 
            updated= now()
        WHERE position_id= _position_id LIMIT 1;
        SELECT position_id,true AS "status", "Correcto registro EDITADO" AS msg FROM table_position WHERE position_id= _position_id LIMIT 1; 
	ELSE 
		SELECT false AS "status", "Error de registro NO existe " AS msg;
	END IF;
                                    
	WHEN 4 THEN 
    IF EXISTS( SELECT * FROM table_position WHERE position_id= _position_id AND deleted IS NULL) THEN 
		UPDATE table_position SET deleted= now() WHERE position_id= _position_id LIMIT 1;
        SELECT position_id,true AS "status", "Correcto registro ELIMINADO" AS msg FROM table_position WHERE position_id= _position_id LIMIT 1; 
	ELSE 
		SELECT false AS "status", "Error de registro NO existe " AS msg;
	END IF;
        
	WHEN 5 THEN
    IF EXISTS( SELECT * FROM table_position WHERE position_id= _position_id AND deleted IS NOT NULL) THEN 
		UPDATE table_position SET deleted= NULL WHERE position_id= _position_id LIMIT 1;
        SELECT position_id,true AS "status", "Correcto registro HABILITADO" AS msg FROM table_position WHERE position_id= _position_id LIMIT 1; 
	ELSE 
		SELECT false AS "status", "Error de registro NO EXISTE" AS msg;
	END IF;
	
    WHEN 6 THEN		       
        select a.ci, a.first_name, a.last_name ,b.* from table_person a INNER JOIN table_position b on a.person_id = b.person_id;
        
	WHEN 7 THEN 
		select a.ci, a.first_name, a.last_name ,b.* from table_person a INNER JOIN table_position b on a.person_id = b.person_id WHERE b.deleted IS NULL;
	END CASE; 
    
END$$

/* test* /
CALL crud_table_appointment("operacion", "appointment_id","person_id", "appointment", "profession", "specialty", "career_direction");
/* insertar * /
CALL crud_table_position(1, null,1, "appointment 5", "profession", "specialty", "career_direction 5");
/*leer * /
CALL crud_table_appointment(2, 1,null, null, null, null, null);
/*editar * /
CALL crud_table_appointment(3, 1,1, "appointment 2", "profession 2", "specialty 2", "career_direction2");
/*Eliminar * /
CALL crud_table_appointment(4, 2,null, null, null, null, null);
/*lista * /
CALL crud_table_appointment(5, null,null, null, null, null, null);
*/