<?php

  $app->get('/tutor-assignment/rootall/', function() use($app){
    try {
      $tutorAssignment = new TutorAssignmentModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/tutor-assignment/all/', function() use($app){
    try {
      $tutorAssignment = new TutorAssignmentModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tutor-assignment/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tutorAssignment = new TutorAssignmentModel(
        null,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_tutor_id,
        $objDatos->finishd
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/tutor-assignment/:id', function($id) use($app){
    try {
        $tutorAssignment = new TutorAssignmentModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/tutor-assignment/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tutorAssignment = new TutorAssignmentModel(        
        $objDatos->tutor_assignment_id,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_tutor_id,
        $objDatos->finishd
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tutor-assignment/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tutorAssignment = new TutorAssignmentModel(
        $objDatos->tutor_assignment_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tutor-assignment/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tutorAssignment = new TutorAssignmentModel(
        $objDatos->tutor_assignment_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tutorAssignment->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
