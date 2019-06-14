<?php

  $app->post('/person/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $person = new PersonModel(
        null,
        $objDatos->first_name,
        $objDatos->last_name,
        $objDatos->ci,
        $objDatos->email,
        $objDatos->cellphone,
        $objDatos->telephone,
        $objDatos->city,
        $objDatos->address,
        $objDatos->pass
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/person/:id', function($id) use($app){
    try {
         $person = new PersonModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/person/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $person = new PersonModel(
        $objDatos->person_id,
        $objDatos->first_name,
        $objDatos->last_name,
        $objDatos->ci,
        $objDatos->email,
        $objDatos->cellphone,
        $objDatos->telephone,
        $objDatos->city,
        $objDatos->address,
        $objDatos->pass
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/person/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $person = new PersonModel(
        $objDatos->person_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/person/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $person = new PersonModel(
        $objDatos->person_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/person/rootall', function() use($app){
    try {
      $person = new PersonModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);      
      $app->response->body(json_encode($person->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/person/all', function() use($app){
    try {
      $person = new PersonModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  //OPERACIONES ESPECIALES 

  //->Login
  $app->post('/person/login', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $person = new PersonModel();
      $person->setCi($objDatos->ci);
      $person->setPass($objDatos->pass);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processCrud(6)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  //-> cargos
  $app->get('/person/:id/positions', function($id) use($app){
    try {
      $person = new PersonModel(
        $id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processList(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  //->estudiantes asignados 
  $app->get('/person/:id/students', function($id) use($app){
    try {
      $person = new PersonModel(
        $id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($person->processList(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
?>
