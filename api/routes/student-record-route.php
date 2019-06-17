<?php

  $app->get('/student-record/rootall', function() use($app){
    try {
      $studentRecord = new StudentRecordModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/student-record/all', function() use($app){
    try {
      $studentRecord = new StudentRecordModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/direction', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel();
      $studentRecord->setCareerDirection($objDatos->career_direction);      
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processList(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/careers', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel();
      $studentRecord->setPersonStudentID($objDatos->person_student_id);      
      $studentRecord->setCareerDirection($objDatos->career_direction);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processList(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/programs', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel();
      $studentRecord->setPersonStudentID($objDatos->person_student_id);      
      $studentRecord->setCareer($objDatos->career);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processList(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel(
        null,  
        $objDatos->person_student_id,
        $objDatos->program_version_id,
        $objDatos->career,
        $objDatos->career_direction,
        $objDatos->cu,
        $objDatos->cost,
        $objDatos->type_register,
        $objDatos->state
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/student-record/:id', function($id) use($app){
    try {
         $studentRecordModel = new StudentRecordModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecordModel->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/student-record/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel(
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->program_version_id,
        $objDatos->career,
        $objDatos->cu,
        $objDatos->cost,
        $objDatos->type_register,
        $objDatos->state
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel(
        $objDatos->student_record_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/student-record/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $studentRecord = new StudentRecordModel(
        $objDatos->student_record_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($studentRecord->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
