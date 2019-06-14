USE PGAENG;

DELIMITER $$

CREATE TRIGGER on_account_insert_table_payment_history AFTER INSERT ON table_payment_history
FOR EACH ROW
BEGIN
        UPDATE table_student_record
        SET 
			on_account=(SELECT sum(payment) FROM table_payment_history WHERE student_record_id=NEW.student_record_id)
        WHERE student_record_id=NEW.student_record_id LIMIT 1;
END$$ 

DELIMITER $$

CREATE TRIGGER on_account_update_table_payment_history AFTER UPDATE ON table_payment_history
FOR EACH ROW
BEGIN
        UPDATE table_student_record
        SET 
			on_account=(SELECT sum(payment) FROM table_payment_history WHERE student_record_id=NEW.student_record_id)
        WHERE student_record_id=NEW.student_record_id LIMIT 1;
END$$

DELIMITER $$

CREATE TRIGGER on_account_delete_table_payment_history AFTER DELETE ON table_payment_history
FOR EACH ROW
BEGIN
        UPDATE table_student_record
        SET 
			on_account=(SELECT sum(payment) FROM table_payment_history WHERE student_record_id=OLD.student_record_id)
        WHERE student_record_id= OLD.student_record_id LIMIT 1;
END$$ 

/* Area Test
DROP TRIGGER PGAENG.on_account_insert_table_payment_history;
DROP TRIGGER PGAENG.on_account_update_table_payment_history;
DROP TRIGGER PGAENG.on_account_delete_table_payment_history;

*/