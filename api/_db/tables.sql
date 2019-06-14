USE PGAENG;

CREATE TABLE IF NOT EXISTS table_person(
 person_id INT NOT NULL AUTO_INCREMENT,
 first_name VARCHAR(255) NOT NULL, 			/* nombre*/
 last_name VARCHAR(255) NOT NULL, 			/* apellido*/
 ci varchar(120) NOT NULL unique, 			/* carnet de identidad*/
 email VARCHAR(120) NOT NULL,				/* correo electronico*/
 cellphone VARCHAR(16),						/* celular */
 telephone VARCHAR(16),						/* telefono */
 city VARCHAR(120),							/* ciudad*/
 address VARCHAR(120),						/* direccion*/
 passwords  VARCHAR(120),					/* password*/
 created DATETIME default CURRENT_TIMESTAMP,/* fecha de creacion*/
 updated DATETIME default CURRENT_TIMESTAMP,/* ultima fecha de modificacion*/
 deleted DATETIME, 							/* fecha de eliminacacion*/
    PRIMARY KEY (person_id),
    UNIQUE (email),
    UNIQUE (ci)

);

CREATE TABLE IF NOT EXISTS table_position(
	position_id INT NOT NULL AUTO_INCREMENT,	/* id auto generado*/
	person_id INT NOT NULL,						/* id persona*/
    appointment VARCHAR(120),					/* nombre de roles o asignaciones{Root, coordinador, adm, root}*/
    profession VARCHAR(255),					/* profecion { Ing sistemas, Ing Quimico, etc}*/
	specialty VARCHAR(255),						/* Especialidad { Desarrollo de Software, Network, Inteligencia Artificial, Seguridad de la informacion, Sistemas Integrados, Desarrollo Web, Dispositivos moviles, UX y diseño, Robotica}*/
    career_direction VARCHAR(511),				/* direccion de carreras */
    created DATETIME default CURRENT_TIMESTAMP, /* fecha de creacion*/
    updated DATETIME default CURRENT_TIMESTAMP, /* ultima fecha de modificacion*/
    deleted DATETIME, 							/* fecha de eliminacacion*/
		PRIMARY KEY (position_id),
		FOREIGN KEY (person_id) REFERENCES table_person(person_id)    
);

CREATE TABLE IF NOT EXISTS table_program_version(
	program_version_id INT NOT NULL AUTO_INCREMENT,
    program_version VARCHAR(120),				/* nombre de la gestion example 1/2018*/
    state VARCHAR(120),							/* estado {vigente, concluido, extendido, suspendido}*/
    grade VARCHAR(120),							/* Grado de las carreras { licenciaturas o tecnico superior }*/
    cost DECIMAL NOT NULL,						/* costo*/
    startd DATETIME,							/* fecha de comienzo*/
    finishd DATETIME,							/* fecha de culminacion*/
    created DATETIME default CURRENT_TIMESTAMP,	/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,	/* ultima fecha de modificacion*/
    deleted DATETIME, 							/* fecha de eliminacacion*/
		PRIMARY KEY (program_version_id)
);

CREATE TABLE IF NOT EXISTS table_student_record(
	student_record_id INT NOT NULL AUTO_INCREMENT,
    person_student_id INT NOT NULL, 			/* id persona estudiante*/
    program_version_id INT NOT NULL,			/* id programa asignado*/
    career VARCHAR(255) NOT NULL,				/* carrera*/
	career_direction VARCHAR(511),				/* direccion de carreras */
    cu VARCHAR(15) NOT NULL,					/* CU universitario*/
    cost DECIMAL,								/* costo total de la colegiatura*/
    on_account DECIMAL DEFAULT 0,				/* acuenta estudiante*/
    type_register VARCHAR(120) NOT NULL,		/* tipo de registro {nuevo, ampliacion, reincorporacion, abortado}*/
    state VARCHAR(120) NOT NULL,				/* estado del estudiante {vigente, habilitado, concluido, abandono}*/
    created DATETIME default CURRENT_TIMESTAMP,	/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,	/* ultima fecha de modificacion*/ 
    deleted DATETIME, 							/* fecha de eliminacacion*/
    /* id_person_coordinator*/
		PRIMARY KEY (student_record_id),
        FOREIGN KEY (person_student_id) REFERENCES table_person(person_id),
        FOREIGN KEY (program_version_id) REFERENCES table_program_version(program_version_id)
);

CREATE TABLE IF NOT EXISTS table_payment_history(
	payment_history_id INT NOT NULL AUTO_INCREMENT,
	student_record_id INT NOT NULL,						/* id resgistro del estudiante*/
    payment DECIMAL NOT NULL,							/* pago del estudiante*/
    payment_code VARCHAR(16),							/* codigo de pago*/
    name_bank VARCHAR(26),								/* nombre del banco*/
    created DATETIME default CURRENT_TIMESTAMP,			/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,			/* ultima fecha de modificacion*/    
    deleted DATETIME, 									/* fecha de eliminacacion*/
			PRIMARY KEY (payment_history_id),
			FOREIGN KEY (student_record_id) REFERENCES table_student_record(student_record_id)
);

CREATE TABLE IF NOT EXISTS table_tutor_assignment(
	tutor_assignment_id INT NOT NULL AUTO_INCREMENT,	/* id autogenerado*/
	student_record_id INT NOT NULL,						/* id registro de estudiante */
	person_student_id INT NOT NULL,						/* id persona, tipo estudiante  */
    person_tutor_id INT NOT NULL,						/* id persona, tipo tutor */
    finishd DATETIME,									/* fecha de culminacion*/
    created DATETIME default CURRENT_TIMESTAMP,			/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,			/* ultima fecha de modificacion*/
    deleted DATETIME, 									/* ultima fecha de eliminacacion*/
		PRIMARY KEY (tutor_assignment_id),
		FOREIGN KEY (student_record_id) REFERENCES table_student_record(student_record_id),
		FOREIGN KEY (person_student_id) REFERENCES table_person(person_id),
        FOREIGN KEY (person_tutor_id) REFERENCES table_person(person_id)
);

CREATE TABLE IF NOT EXISTS table_tracing(
	tracing_id INT NOT NULL AUTO_INCREMENT,		/* id autogenerado*/
	student_record_id INT NOT NULL,				/* id de registro*/
    person_student_id INT NOT NULL, 			/* id persona estudiante*/
    person_tutor_id INT NOT NULL,				/* id persona tutor*/
    detail VARCHAR(511),						/* detalle del seguimiento*/
    documents_attached VARCHAR(255),			/* ruta del documento adjunto*/
    created DATETIME default CURRENT_TIMESTAMP,	/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,	/* ultima fecha de modificacion*/
    deleted DATETIME, 							/* ultima fecha de eliminacacion*/
		PRIMARY KEY (tracing_id),
		FOREIGN KEY (student_record_id) REFERENCES table_student_record(student_record_id),
        FOREIGN KEY (person_student_id) REFERENCES table_person(person_id),
        FOREIGN KEY (person_tutor_id) REFERENCES table_person(person_id)
);

CREATE TABLE IF NOT EXISTS table_advance(
	advance_id INT NOT NULL AUTO_INCREMENT,			/* id autogenerado*/
	student_record_id INT NOT NULL,					/* id registro de estudiante */
    modality VARCHAR(120),							/* modalidad de titulacion {Proyecto de grado, Trabajo dirigido}*/
    document INT NOT NULL,							/* 0 A 100 estado del documento*/
    software INT NOT NULL,							/* 0 A 100 estado del software*/
    created DATETIME default CURRENT_TIMESTAMP,		/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,		/* ultima fecha de modificacion*/
    deleted DATETIME, 								/* fecha de eliminacacion*/
		PRIMARY KEY (advance_id),
		FOREIGN KEY (student_record_id) REFERENCES table_student_record(student_record_id)
);

CREATE TABLE IF NOT EXISTS table_defense_court(
	defense_court_id INT NOT NULL AUTO_INCREMENT,	/* id autogenerado*/
	student_record_id INT NOT NULL,					/* id registro del estudiante*/
    person_student_id INT NOT NULL,					/* id persona estudiante */					
    person_teacher_id_1 INT NOT NULL,				/* id persona docente*/
    person_teacher_id_2 INT NOT NULL,				/* id persona docente*/
    person_teacher_id_3 INT NOT NULL,				/* id persona docente*/
	defensed DATETIME,								/* fecha de la defensa*/
    place_defense VARCHAR(255),						/* lugar de la defensa*/
    note TEXT,										/* nota o obserbaciones */
    created DATETIME default CURRENT_TIMESTAMP,		/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,		/* ultima fecha de modificacion*/
    deleted DATETIME, 								/* fecha de eliminacacion*/
		PRIMARY KEY (defense_court_id),
		FOREIGN KEY (student_record_id) REFERENCES table_student_record(student_record_id),
        FOREIGN KEY (person_student_id) REFERENCES table_person(person_id),
        FOREIGN KEY (person_teacher_id_1) REFERENCES table_person(person_id),
        FOREIGN KEY (person_teacher_id_2) REFERENCES table_person(person_id),
        FOREIGN KEY (person_teacher_id_3) REFERENCES table_person(person_id)
);

CREATE TABLE IF NOT EXISTS table_notification(
	notification_id INT NOT NULL AUTO_INCREMENT,		/* id autogenerado*/
    receiver_person_id  INT NOT NULL,					/* id persona receptor */
    sender_person_id  INT NOT NULL,						/* id persona emisor  */
	message VARCHAR(511) NOT NULL,						/* text mensaje*/
    viewed BOOLEAN DEFAULT FALSE,						/* visto notificacion {false, true}*/
    created DATETIME default CURRENT_TIMESTAMP,			/* fecha de creacion*/
	updated DATETIME default CURRENT_TIMESTAMP,			/* ultima fecha de modificacion*/
    deleted DATETIME, 									/* fecha de eliminacacion*/
		PRIMARY KEY (notification_id),
		FOREIGN KEY (sender_person_id) REFERENCES table_person(person_id),
        FOREIGN KEY (receiver_person_id) REFERENCES table_person(person_id)
);

