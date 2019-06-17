USE PGAENG;

DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_tracing`;
CREATE PROCEDURE crud_table_tracing(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _tracing_id INT,					/* id autogenerado*/
 IN _student_record_id INT,				/* id de registro*/
 IN _person_student_id INT, 			/* id persona estudiante*/
 IN _person_tutor_id INT,				/* id persona tutor*/
 IN _detail VARCHAR(511),				/* detalle del seguimiento*/
 IN _documents_attached VARCHAR(127)	/* ruta del documento adjunto*/)

BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_tracing(student_record_id, person_student_id, person_tutor_id, detail, documents_attached)
		VALUE ( _student_record_id,_person_student_id,_person_tutor_id,_detail,_documents_attached);
        SELECT tracing_id,TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_tracing WHERE student_record_id=_student_record_id ORDER BY tracing_id DESC LIMIT 1;
	WHEN 2 THEN
    IF EXISTS(SELECT * FROM table_tracing WHERE tracing_id=_tracing_id AND deleted IS NULL) THEN 
		SELECT *, TRUE AS "status", "Correcto registro LEIDO" AS msg FROM table_tracing WHERE tracing_id=_tracing_id AND deleted IS NULL LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
    
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_tracing WHERE tracing_id=_tracing_id AND deleted IS NULL) THEN 
		UPDATE table_tracing
        SET student_record_id=_student_record_id,
			person_student_id=_person_student_id,
            person_tutor_id=_person_tutor_id,
            detail=_detail, 
            documents_attached=_documents_attached,
            updated = now()
        WHERE tracing_id=_tracing_id  LIMIT 1;
        SELECT tracing_id, TRUE AS "status", "Correcto registro EDITADO" AS msg FROM table_tracing WHERE tracing_id=_tracing_id ;  
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
        
	WHEN 4 THEN 
    IF EXISTS(SELECT * FROM table_tracing WHERE tracing_id=_tracing_id AND deleted IS NULL) THEN 
		UPDATE table_tracing SET deleted = now() WHERE tracing_id=_tracing_id LIMIT 1;
        SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
    
    WHEN 5 THEN 
    IF EXISTS(SELECT * FROM table_tracing WHERE tracing_id=_tracing_id AND deleted IS NOT NULL) THEN 
		UPDATE table_tracing SET deleted = NULL WHERE tracing_id=_tracing_id LIMIT 1;
        SELECT true AS "status", "Correcto registro HABILITADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
 END CASE; 
END$$

DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_tracing`;
CREATE PROCEDURE list_table_tracing(
 IN _operation INT,						/* operaciones{ 1:rootall, 2:all, 3:record }*/
 IN _student_record_id INT				/* id de registro*/)

BEGIN

 CASE _operation 
	
    WHEN 1 THEN 
		SELECT * FROM table_tracing;
        
	WHEN 2 THEN 
		SELECT * FROM table_tracing WHERE deleted IS NULL;
	        
	WHEN 3 THEN
    IF EXISTS (SELECT * FROM table_tracing WHERE student_record_id = _student_record_id AND deleted IS NULL) THEN 
		SELECT * FROM table_tracing WHERE student_record_id = _student_record_id AND deleted IS NULL;
	END IF;
 END CASE; 
END$$

/* Area Test
call crud_table_tracing("operacion","id",student_record_id, person_student_id, person_tutor_id, detail, documents_attached);
insertar 
call crud_table_tracing(1,null,3, 30, 15," detalle 2", "/doc/perfil2.docx");
leer
call crud_table_tracing(2,1,null,null,null,null,null);
editar
call crud_table_tracing(3,2,3, 28, 13," detalle 2", "/doc/perfil3.docx");
eliminar
call crud_table_tracing(4,2,null,null,null,null,null);
lista
call crud_table_tracing(5,null,3,28,null,null,null);

call crud_table_tracing(6,null,3,null,13,null,null);

*/