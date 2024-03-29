<?php

  $app->get('/defense-court/rootall', function() use($app){
    try {
      $defenseCourt = new DefenseCourtModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/defense-court/all', function() use($app){
    try {
      $defenseCourt = new DefenseCourtModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/defense-court/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $defenseCourt = new DefenseCourtModel(
        null,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_teacher_id_1,
        $objDatos->person_teacher_id_2,
        $objDatos->person_teacher_id_3,
        $objDatos->defensed,
        $objDatos->place_defense,
        $objDatos->note
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/defense-court/:id', function($id) use($app){
    try {
        $defenseCourt = new DefenseCourtModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/defense-court/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $defenseCourt = new DefenseCourtModel(        
        $objDatos->defense_court_id,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_teacher_id_1,
        $objDatos->person_teacher_id_2,
        $objDatos->person_teacher_id_3,
        $objDatos->defensed,
        $objDatos->place_defense,
        $objDatos->note
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/defense-court/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $defenseCourt = new DefenseCourtModel(
        $objDatos->defense_court_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/defense-court/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $defenseCourt = new DefenseCourtModel(
        $objDatos->defense_court_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($defenseCourt->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
