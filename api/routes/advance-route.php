<?php

  $app->get('/advance/rootall', function() use($app){
    try {
      $advance = new AdvanceModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/advance/all', function() use($app){
    try {
      $advance = new AdvanceModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/advance/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $advance = new AdvanceModel(
        null,
        $objDatos->student_record_id,
        $objDatos->modality,
        $objDatos->document,
        $objDatos->software
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/advance/:id', function($id) use($app){
    try {
        $advance = new AdvanceModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/advance/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $advance = new AdvanceModel(    
        $objDatos->advance_id,
        $objDatos->student_record_id,
        $objDatos->modality,
        $objDatos->document,
        $objDatos->software
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/advance/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $advance = new AdvanceModel(
        $objDatos->advance_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/advance/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $advance = new AdvanceModel(
        $objDatos->advance_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($advance->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
