USE PGAENG;

DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_notification`;
CREATE PROCEDURE crud_table_notification(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _notification_id INT,				/* id autogenerado*/
 IN _receiver_person_id INT,			/* id persona receptor */
 IN _sender_person_id INT,				/* id persona emisor  */
 IN _message VARCHAR(511),				/* text mensaje*/
 IN _viewed BOOLEAN						/* visto notificacion {false, true}*/
 )

BEGIN

 CASE _operation 
	WHEN 1 THEN 
		INSERT INTO table_notification(receiver_person_id, sender_person_id, message, viewed)
		VALUE (_receiver_person_id, _sender_person_id, _message,_viewed);
        SELECT notification_id ,TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_notification ORDER BY notification_id  DESC LIMIT 1;
	
    WHEN 2 THEN
    IF EXISTS(SELECT * FROM table_notification WHERE notification_id=_notification_id AND deleted IS NULL) THEN 
		SELECT *, TRUE AS "status", "Correcto registro LEIDO" AS msg FROM table_notification WHERE notification_id=_notification_id AND deleted IS NULL LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
    
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_notification WHERE notification_id=_notification_id AND deleted IS NULL) THEN 
		UPDATE table_notification
        SET receiver_person_id=_receiver_person_id,
			sender_person_id=_sender_person_id,
            message=_message, 
            viewed=_viewed,
            updated = now()
        WHERE notification_id=_notification_id LIMIT 1;
        SELECT notification_id, TRUE AS "status", "Correcto registro EDITADO" AS msg FROM table_notification WHERE notification_id=_notification_id LIMIT 1 ;  
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
        
	WHEN 4 THEN 
    IF EXISTS(SELECT * FROM table_notification WHERE notification_id=_notification_id AND deleted IS NULL) THEN 
		UPDATE table_notification SET deleted = now() WHERE notification_id=_notification_id LIMIT 1;
        SELECT true AS "status", "Correcto registro ELIMINADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
    
    WHEN 5 THEN 
    IF EXISTS(SELECT * FROM table_notification WHERE notification_id=_notification_id AND deleted IS NOT NULL) THEN 
		UPDATE table_notification SET deleted = NULL WHERE notification_id=_notification_id LIMIT 1;
        SELECT true AS "status", "Correcto registro HABILITADO" AS msg;
	ELSE
		SELECT FALSE AS "status", "Error de registro ya existe" AS msg;
	END IF;
 END CASE; 
END$$

DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_notification`;
CREATE PROCEDURE list_table_notification(
 IN _operation INT,						/* operaciones{ 1:rootall, 2:all, 3:record }*/
 IN _receiver_person_id INT			/* id persona receptor */)

BEGIN

 CASE _operation 
	
    WHEN 1 THEN 
		SELECT * FROM table_notification;
        
	WHEN 2 THEN 
		SELECT * FROM table_notification WHERE deleted IS NULL;
	
    /* INBOX NOTIFICATION*/
	WHEN 3 THEN
    IF EXISTS (SELECT * FROM table_notification WHERE receiver_person_id = _receiver_person_id AND viewed IS FALSE AND deleted IS NULL) THEN 
		SELECT * FROM table_notification WHERE receiver_person_id = _receiver_person_id AND viewed IS FALSE AND deleted IS NULL;
	END IF;
 END CASE; 
END$$
/*
insertar 
call crud_table_notification(option, notification_id, receiver_person_id, sender_person_id, message, viewed);

call crud_table_notification(1,null, 2, 1, "message", false);
*/