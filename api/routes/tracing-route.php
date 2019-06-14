<?php

  $app->get('/tracing/all/student/:id/:record', function($id,$record) use($app){
    try {
      $tracing = new TracingModel();
      $tracing->SetPersonStudentID($id);
      $tracing->SetStudentRecordID($record);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processTracing(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/tracing/all/tutor/:id/:record', function($id,$record) use($app){
    try {
      $tracing = new TracingModel();
      $tracing->SetPersonTutorID($id);
      $tracing->SetStudentRecordID($record);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($tracing->processTracing(6)));
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
      $app->response->body(json_encode($tracing->processTracing(1)));
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
      $app->response->body(json_encode($tracing->processTracing(2)));
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
      $app->response->body(json_encode($tracing->processTracing(3)));
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
      $app->response->body(json_encode($tracing->processTracing(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
