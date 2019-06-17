<?php

  $app->get('/notification/rootall', function() use($app){
    try {
      $notification = new NotificationModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processList(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->get('/notification/all', function() use($app){
    try {
      $notification = new NotificationModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processList(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/notification/inbox', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $notification = new NotificationModel();
      $notification->receiverPersonID($objDatos->receiver_person_id);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processList(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/notification/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $notification = new NotificationModel(
        null,
        $objDatos->receiver_person_id,
        $objDatos->sender_person_id,
        $objDatos->message,
        $objDatos->viewed
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processCrud(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/notification/:id', function($id) use($app){
    try {
        $notification = new NotificationModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processCrud(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/notification/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $notification = new NotificationModel(        
        $objDatos->notification_id,
        $objDatos->receiver_person_id,
        $objDatos->sender_person_id,
        $objDatos->message,
        $objDatos->viewed
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processCrud(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/notification/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $notification = new NotificationModel(
        $objDatos->notification_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processCrud(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/notification/undelete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $notification = new NotificationModel(
        $objDatos->notification_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($notification->processCrud(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
