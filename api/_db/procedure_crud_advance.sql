USE PGAENG;

DROP PROCEDURE `pgaeng`.`crud_table_advance`;

DELIMITER $$

CREATE PROCEDURE crud_table_advance(
 IN _operation INT,					/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _advance_id INT,				/* id autogenerado*/
 IN _student_record_id INT,			/* id registro de estudiante */
 IN _modality VARCHAR(120),			/* modalidad de titulacion {Proyecto de grado, Trabajo dirigido}*/
 IN _document INT,					/* 0 A 100 estado del documento*/
 IN _software INT 	)

BEGIN

 CASE _operation 
	WHEN 1 THEN 
		IF NOT EXISTS (SELECT * FROM table_advance WHERE student_record_id = _student_record_id) THEN
			INSERT INTO table_advance(student_record_id,modality,document,software) VALUE (_student_record_id,_modality,_document,_software);
			SELECT advance_id, true AS "status", "Correcto registro CREADO" AS msg FROM table_advance WHERE student_record_id = _student_record_id LIMIT 1; 
		ELSE
			SELECT false AS "status", "Error de registro ya existe" AS msg;
		END IF;
	WHEN 2 THEN
		IF EXISTS(SELECT * FROM table_advance WHERE advance_id=_advance_id) THEN
			SELECT *, true AS "status", "Correcto registro LEIDO" AS msg FROM table_advance WHERE advance_id=_advance_id LIMIT 1;
        ELSE
			SELECT false AS "status", "Error de registro no existe" AS msg;
        END IF;
		
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_advance WHERE advance_id=_advance_id) THEN
		UPDATE table_advance
        SET student_record_id=_student_record_id, 
			modality=_modality,
			document=_document,
            software=_software,
			updated = now()
        WHERE advance_id=_advance_id  LIMIT 1;
        SELECT advance_id, true AS "status", "Correcto registro EDITADO" AS msg FROM table_advance WHERE advance_id=_advance_id  LIMIT 1;  
	ELSE
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
	WHEN 4 THEN 
    IF EXISTS(SELECT * FROM table_advance WHERE advance_id=_advance_id) THEN
		DELETE FROM table_advance WHERE advance_id=_advance_id LIMIT 1;  
        SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro no existe" AS msg;
	END IF;
    
	WHEN 5 THEN
		SELECT * FROM table_advance;
	END CASE; 
    
END$$

/* Area Test
call crud_table_control("operacion","id",student_record_id, modalidad, document, software);
insertar 
call crud_table_advance(1,null,4,"Trabajo de grado",3,3);
leer
call crud_table_advance(2,1,null, null, null,null);
editar 
call crud_table_advance(3,1,3,"Trabajo de grado",5,6);
eliminar
call crud_table_advance(4,4,null, null, null,null);
lista 
call crud_table_advance(5,null,null, null, null,null);
*/