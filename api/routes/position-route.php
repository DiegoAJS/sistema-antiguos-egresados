<?php

  $app->get('/position/rootall', function() use($app){
    try {
      $position = new PositionModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/position/all', function() use($app){
    try {
      $position = new PositionModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });  

  $app->post('/position/direction', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $position = new PositionModel();
      $position->setCareerDirection($objDatos->career_direction);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processList(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  }); 

  $app->post('/position/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $position = new PositionModel(
        null,
        $objDatos->person_id,
        $objDatos->appointment,
        $objDatos->profession,
        $objDatos->specialty,
        $objDatos->career_direction        
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/position/:id', function($id) use($app){
    try {
         $position = new PositionModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/position/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $position = new PositionModel(
        $objDatos->position_id,
        $objDatos->person_id,
        $objDatos->appointment,
        $objDatos->profession,
        $objDatos->specialty,
        $objDatos->career_direction 
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/position/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $position = new PositionModel(
        $objDatos->position_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/position/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $position = new PositionModel(
        $objDatos->position_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($position->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
