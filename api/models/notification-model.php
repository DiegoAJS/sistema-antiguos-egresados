<?php

class NotificationModel {
  
  private $conexion;
  private $response;

  /* person model */
  
  private $notification_id;
  private $receiver_person_id;
  private $sender_person_id;
  private $message;
  private $viewed;
  
  public function __CONSTRUCT(
    $notification_id=null,
    $receiver_person_id=null,
    $sender_person_id=null,
    $message=null,
    $viewed=null
  ){

    /* model assignation */
    $this->notification_id = $notification_id;
    $this->receiver_person_id = $receiver_person_id;
    $this->sender_person_id = $sender_person_id;
    $this->message = $message;
    $this->viewed = $viewed;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_notification(?,?,?,?,?,?);';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->notification_id,
        $this->receiver_person_id,
        $this->sender_person_id,
        $this->message,
        $this->viewed
      )
    );
    
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo insertar

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
    $sql = 'call list_table_notification(?,?);';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->receiver_person_id        
      )
    );
    
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo insertar
    
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

  public function receiverPersonID($receiver_person_id){
    $this->receiver_person_id=$receiver_person_id;
  }
}

?>
