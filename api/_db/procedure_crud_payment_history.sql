USE PGAENG;

DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_payment_history`;
CREATE PROCEDURE crud_table_payment_history(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _payment_history_id INT,			/* id pago*/
 IN _student_record_id INT,				/* id resgistro del estudiante*/
 IN _payment DECIMAL,					/* pago del estudiante*/
 IN _payment_code VARCHAR(16),			/* codigo de pago*/
 IN _name_bank VARCHAR(26)				/* nombre del banco*/)

BEGIN

 CASE _operation 
	WHEN 1 THEN 
    IF NOT EXISTS(SELECT payment_history_id FROM table_payment_history WHERE student_record_id=_student_record_id AND payment_code=_payment_code AND name_bank=_name_bank) THEN
		INSERT INTO table_payment_history(student_record_id, payment, payment_code,name_bank)
		VALUE (_student_record_id, _payment, _payment_code, _name_bank);
        SELECT payment_history_id, TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_payment_history WHERE student_record_id=_student_record_id AND payment_code=_payment_code AND name_bank=_name_bank LIMIT 1; 
	ELSE
		SELECT FALSE AS "status", "Error ya existe registro" AS msg;
	END IF;
    
	WHEN 2 THEN
    IF EXISTS(SELECT payment_history_id FROM table_payment_history WHERE payment_history_id=_payment_history_id AND deleted IS NULL ) THEN
		SELECT *, TRUE AS "status", "Correcto registro LEIDO" AS msg  FROM table_payment_history WHERE payment_history_id=_payment_history_id LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
        
	WHEN 3 THEN 
    IF EXISTS(SELECT payment_history_id FROM table_payment_history WHERE payment_history_id=_payment_history_id AND student_record_id=_student_record_id AND deleted IS NULL ) THEN    
    UPDATE table_payment_history
        SET student_record_id = _student_record_id, 
			payment = _payment,
            payment_code = _payment_code,
            name_bank = _name_bank,
            updated = now()
        WHERE payment_history_id = _payment_history_id LIMIT 1;
        SELECT payment_history_id, TRUE AS "status", "Correcto registro EDITADO" AS msg FROM table_payment_history WHERE payment_history_id=_payment_history_id LIMIT 1;  
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;
    
	WHEN 4 THEN 
    IF EXISTS(SELECT payment_history_id FROM table_payment_history WHERE payment_history_id=_payment_history_id AND deleted IS NULL) THEN    
		UPDATE table_payment_history SET deleted = now() WHERE payment_history_id = _payment_history_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
    
    WHEN 5 THEN 
    IF EXISTS(SELECT payment_history_id FROM table_payment_history WHERE payment_history_id=_payment_history_id AND deleted IS NOT NULL) THEN    
		UPDATE table_payment_history SET deleted = NULL WHERE payment_history_id = _payment_history_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro HABILITADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
 END CASE; 
END$$


DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_payment_history`;
CREATE PROCEDURE list_table_payment_history(
 IN _operation INT,						/* operaciones{ 1:ROOTALL, 2:ALL, 3:PAGOS}*/
 IN _student_record_id INT				/* id resgistro del estudiante*/
 )

BEGIN

 CASE _operation 
	
     WHEN 1 THEN
		SELECT * FROM table_payment_history;
        
	 WHEN 2 THEN
		SELECT * FROM table_payment_history WHERE deleted IS NULL;
        
    /* REGISTRO DE STUDIANTE - PAGOS*/
	WHEN 3 THEN
    IF EXISTS(SELECT * FROM table_payment_history WHERE student_record_id=_student_record_id  AND deleted IS NULL) THEN
		SELECT * FROM table_payment_history WHERE student_record_id=_student_record_id AND deleted IS NULL;
	END IF;
    
 END CASE;     
END$$

/* Area Test
call crud_table_payment_history("operacion","id",student_record_id, payment, payment_code,name_bank);
insertar 
call crud_table_payment_history(1,null,3, 3400, "439757","Banco Bolivia");
leer
call crud_table_payment_history(2,7,null, null, null,null);
editar
call crud_table_payment_history(3,7,3, 3000, "123458","Banco Bolivia");
eliminar
call crud_table_payment_history(4,2,null, null, null,null);
lista
call crud_table_payment_history(5,null,3, null, null,null);
*/