<?php

  $app->post('/type/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $type = new TypeModel(
        null,
        $objDatos->name_type,
        $objDatos->label_type,
        $objDatos->foreign_type_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/type/:id', function($id) use($app){
    try {
        $type = new TypeModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/type/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $type = new TypeModel(        
        $objDatos->type_id,
        $objDatos->name_type,
        $objDatos->label_type,
        $objDatos->foreign_type_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/type/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $type = new TypeModel(
        $objDatos->type_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/type/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $type = new TypeModel(
        $objDatos->type_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/type/rootall', function() use($app){
    try {
      $type = new TypeModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(6)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/type/all', function() use($app){
    try {
      $type = new TypeModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(7)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/type/label/:label', function($label) use($app){
    try {
      $type = new TypeModel();
      $type->label_type=$label;
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(8)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/type/groud/:id', function($id) use($app){
    try {
      $type = new TypeModel();
      $type->foreign_type_id=$id;
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($type->processType(9)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
