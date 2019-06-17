USE PGAENG;

DELIMITER $$
DROP PROCEDURE `pgaeng`.`crud_table_program`;
CREATE PROCEDURE crud_table_program(
    IN _operation INT,								/* operaciones{ 1:create, 2:read, 3:update, 4:delete, 5:find }*/
    IN _program_version_id INT,						/* id program version */
    IN _program_version VARCHAR(120),				/* nombre de la gestion example 1/2018*/
    IN _state VARCHAR(120),							/* estado {vigente, concluido, extendido, suspendido}*/
    IN _grade VARCHAR(120),							/* Grado de las carreras { licenciaturas o tecnico superior }*/
    IN _cost DECIMAL,								/* costo*/
    IN _startd DATETIME,							/* fecha de comienzo*/
    IN _finishd DATETIME							/* fecha de culminacion*/ )
BEGIN

 CASE _operation 
	WHEN 1 THEN 
	IF NOT EXISTS(SELECT program_version_id FROM table_program_version WHERE program_version = _program_version AND grade= _grade) THEN
		INSERT INTO table_program_version(program_version, state,grade, cost, startd, finishd) VALUE (_program_version, _state, _grade, _cost, _startd, _finishd); 
		SELECT program_version_id,TRUE AS "status", "Correcto registro CREADO" AS msg FROM table_program_version  WHERE table_program_version.program_version = _program_version AND table_program_version.grade= _grade LIMIT 1; 
	ELSE 
		SELECT FALSE AS "status", "Error registro ya existe " AS msg ;
	END IF;
	
	WHEN 2 THEN
	IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id AND deleted IS NULL) THEN
		SELECT *,TRUE AS "status", "Correcto registro LEIDO" AS msg FROM table_program_version  WHERE program_version_id= _program_version_id LIMIT 1;
	ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
	END IF;
        
	WHEN 3 THEN 
    IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id AND deleted IS NULL) THEN
		UPDATE table_program_version
			SET program_version = _program_version, 
				state = _state,
				grade = _grade,
				cost = _cost,
				startd = _startd, 
				finishd = _finishd,
				updated= now()
			WHERE program_version_id= _program_version_id LIMIT 1;
        SELECT program_version_id,TRUE AS "status", "Correcto registro ACTUALIZADO" AS msg FROM table_program_version WHERE program_version_id= _program_version_id LIMIT 1; 
    ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;
		                                    
	WHEN 4 THEN 
	IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id AND deleted IS NULL) THEN
		UPDATE table_program_version SET deleted = now() WHERE program_version_id= _program_version_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro ELIMINADO" AS msg;
    ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;
    
    WHEN 5 THEN 
	IF EXISTS(SELECT * FROM table_program_version WHERE program_version_id= _program_version_id AND deleted IS NOT NULL) THEN
		UPDATE table_program_version SET deleted = NULL WHERE program_version_id= _program_version_id LIMIT 1;
        SELECT TRUE AS "status", "Correcto registro HABILITADO" AS msg;
    ELSE
		SELECT FALSE AS "status", "Error no existe registro" AS msg;
    END IF;  
   /* Last registro version para el grado*/ 
    WHEN 6 THEN 
	IF EXISTS(SELECT * from table_program_version WHERE grade=_grade AND state=_state AND deleted IS NULL ORDER BY program_version_id DESC LIMIT 1) THEN
		SELECT * ,TRUE AS "status", "Correcto Version del actual" AS msg from table_program_version WHERE grade=_grade AND state=_state AND deleted IS NULL ORDER BY program_version_id DESC LIMIT 1;
    END IF;
	
    END CASE;     
END$$

DELIMITER $$
DROP PROCEDURE `pgaeng`.`list_table_program`;
CREATE PROCEDURE list_table_program(
    IN _operation INT								/* operaciones{ 1:ROOTALL, 2:ALL}*/ )
BEGIN
	CASE _operation 	
	WHEN 1 THEN
		SELECT * FROM table_program_version;
        
	WHEN 2 THEN
		SELECT * FROM table_program_version WHERE deleted IS NULL;
        
	END CASE;     
END$$

 
 /* Area Test* /
call crud_ProgramVersion("operacion","id","program_version", "state", "grade", "cost", "start_date", "finish_date");
/* insertar ProgramVersion* /
call crud_table_program_version(1,null,"program_version", "state","grade", 10000, "2019-10-01 18:43:50", "2019-10-01 18:43:50");
/* leer con id ProgramVersion* /
call crud_table_program_version(2,1,null, null, null, null, null, null);
/* Editar ProgramVersion* /
call crud_table_program_version(3,1,"program_version_2", "state_2", "grade_2", 10000, "2019-04-01 18:43:50", "2019-10-01 18:43:50");
/* Eliminar ProgramVersion* /
call crud_table_program_version(4,1,null, null, null, null, null, null);
/* Lista ProgramVersion
call crud_table_program(6,null,null, null, null, null, null, null);

SELECT * FROM table_program_version*/
