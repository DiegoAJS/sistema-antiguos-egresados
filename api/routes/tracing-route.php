<?php

  $app->get('/tracing/rootall', function() use($app){
    try {
      $tracing = new TracingModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/tracing/all', function() use($app){
    try {
      $tracing = new TracingModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tracing/record', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tracing = new TracingModel();
      $tracing->SetStudentRecordID($objDatos->student_record_id);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processList(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tracing/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tracing = new TracingModel(
        null,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_tutor_id,
        $objDatos->detail,
        $objDatos->documents_attached
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/tracing/:id', function($id) use($app){
    try {
        $tracing = new TracingModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tracing/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tracing = new TracingModel(        
        $objDatos->tracing_id,
        $objDatos->student_record_id,
        $objDatos->person_student_id,
        $objDatos->person_tutor_id,
        $objDatos->detail,
        $objDatos->documents_attached
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tracing/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tracing = new TracingModel(
        $objDatos->tracing_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/tracing/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $tracing = new TracingModel(
        $objDatos->tracing_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });


?>
