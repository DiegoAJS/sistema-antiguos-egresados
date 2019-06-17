<?php

class PaymentHistoryModel {
  private $conexion;
  private $response;

  /* person model */
  private $payment_history_id;
  private $student_record_id;
  private $payment;
  private $payment_code;
  private $name_bank;
  
  public function __CONSTRUCT(
    $payment_history_id=null,
    $student_record_id=null,
    $payment=null,
    $payment_code=null,
    $name_bank=null
  ){

    /* model assignation */
    $this->payment_history_id = $payment_history_id;
    $this->student_record_id = $student_record_id;
    $this->payment = $payment;
    $this->payment_code = $payment_code;
    $this->name_bank = $name_bank;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option = 5){
    $conex = $this->pdo;
    $sql = 'call crud_table_payment_history(?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->payment_history_id,
        $this->student_record_id,
        $this->payment,
        $this->payment_code,
        $this->name_bank
      )
    );

    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo inserta

    if($query->rowCount()!=0){
      $result = $query->fetchObject();
      $status = $result->status;
      $msg = $result->msg;
    }
    
    return $this->response->send(
      $result,
      $status,
      $msg,
      []
    );

  }

  public function processList($option){
    $conex = $this->pdo;
    $sql = 'call list_table_payment_history(?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->student_record_id
      )
    );
    
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo inserta

    if($query->rowCount()!=0){
      $result = $query->fetchAll(PDO::FETCH_OBJ);
      $status = true;
      $msg = "Proceso con exito";
    }
    
    return $this->response->send(
      $result,
      $status,
      $msg,
      []
    );

  }


  public function SetStudentRecordID($student_record_id=null){
      $this->student_record_id=$student_record_id;
  }

}

?>
