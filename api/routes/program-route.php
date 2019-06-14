<?php

  $app->get('/program/rootall', function() use($app){
    try {
      $program = new ProgramModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(6)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/program/all', function() use($app){
    try {
      $program = new ProgramModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(7)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });


  $app->post('/program/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $program = new ProgramModel(
        null,
        $objDatos->program_version,
        $objDatos->state,
        $objDatos->grade,
        $objDatos->cost,
        $objDatos->startd,
        $objDatos->finishd
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/program/:id', function($id) use($app){
    try {
         $program = new ProgramModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/program/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $program = new ProgramModel(
        $objDatos->program_version_id,
        $objDatos->program_version,
        $objDatos->state,
        $objDatos->grade,
        $objDatos->cost,
        $objDatos->startd,
        $objDatos->finishd
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/program/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $program = new ProgramModel(
        $objDatos->program_version_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/program/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $program = new ProgramModel(
        $objDatos->program_version_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($program->processProgram(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
