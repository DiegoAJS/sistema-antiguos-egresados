USE PGAENG;

DELIMITER //

CREATE PROCEDURE crud_table_defense_court(
 IN _operation INT,						/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:all }*/
 IN _defense_court_id INT,				/* id autogenerado*/
 IN _student_record_id INT,				/* id registro del estudiante*/
 IN _person_student_id INT,				/* id persona estudiante */
 IN _person_teacher_id_1 INT,			/* id persona docente*/
 IN _person_teacher_id_2 INT,			/* id persona docente*/
 IN _person_teacher_id_3 INT,			/* id persona docente*/
 IN _defensed DATETIME,					/* fecha de la defensa*/
 IN _place_defense VARCHAR(255),		/* lugar de la defensa*/
 IN _note TEXT							/* nota o obserbaciones */)

BEGIN

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
    
END;
//
DELIMITER 

/* Area Test
call crud_table_defense_court("operacion","id",student_record_id, person_student_id, person_teacher_id_1, person_teacher_id_2, person_teacher_id_3, defensed, place_defense, note);
insertar
call crud_table_defense_court(1,null,3, 29, 13, 14, 15, "2019-06-01 18:43:50", "place_defense", "note");
leer
call crud_table_defense_court(2,1,null, null, null, null, null, null, null, null);
editar
call crud_table_defense_court(3,1,1, 1, 2, 3, 4, "2019-06-01 18:43:50", "place_defense 2", "note 2");
eliminar 
call crud_table_defense_court(4,1,null, null, null, null, null, null, null, null);
lista
call crud_table_defense_court(5,null,null, null, null, null, null, null, null, null);

*/