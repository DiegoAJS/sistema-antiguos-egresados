<?php

  $app->get('/payment-history/:id/all/', function($id) use($app){
    try {
      $paymentHistory = new PaymentHistoryModel();
      $paymentHistory->SetStudentRecordID($id);
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(5)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->get('/payment-history/rootall', function() use($app){
    try {
      $paymentHistory = new PaymentHistoryModel();
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(6)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/payment-history/new', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $paymentHistory = new PaymentHistoryModel(
        null,
        $objDatos->student_record_id,
        $objDatos->payment,
        $objDatos->payment_code,
        $objDatos->name_bank
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(1)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });
  
  $app->get('/payment-history/:id', function($id) use($app){
    try {
        $paymentHistory = new PaymentHistoryModel(
           $id
         );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(2)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  })->conditions(array('id'=>'[0-9]{1,11}'));

  $app->post('/payment-history/update', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $paymentHistory = new PaymentHistoryModel(        
        $objDatos->payment_history_id,
        $objDatos->student_record_id,
        $objDatos->payment,
        $objDatos->payment_code,
        $objDatos->name_bank
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(3)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

  $app->post('/payment-history/delete', function() use($app){
    try {
      $objDatos = json_decode(file_get_contents("php://input"));
      $paymentHistory = new PaymentHistoryModel(
        $objDatos->payment_history_id
      );
      $app->response->headers->set('Content-type','application/json');
      $app->response->headers->set('Access-Control-Allow-Origin','*');
      $app->response->status(200);
      $app->response->body(json_encode($paymentHistory->processPaymentHistory(4)));
    }catch(PDOException $e) {
      echo 'Error: '.$e->getMessage();
    }
  });

?>
