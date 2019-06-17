<?php

class TracingModel {
  private $conexion;
  private $response;

  /* person model */  
  private $tracing_id;
  private $student_record_id;
  private $person_student_id;
  private $person_tutor_id;
  private $detail;
  private $documents_attached;
  
  public function __CONSTRUCT(
    $tracing_id=null,
    $student_record_id=null,
    $person_student_id=null,
    $person_tutor_id=null,
    $detail=null,
    $documents_attached=null
  ){

    /* model assignation */
    $this->tracing_id = $tracing_id;
    $this->student_record_id = $student_record_id;
    $this->person_student_id = $person_student_id;
    $this->person_tutor_id = $person_tutor_id;
    $this->detail = $detail;
    $this->documents_attached = $documents_attached;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_tracing(?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->tracing_id,
        $this->student_record_id,
        $this->person_student_id,
        $this->person_tutor_id,
        $this->detail,
        $this->documents_attached
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
    $sql = 'call list_table_tracing(?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->student_record_id
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
  
  public function SetStudentRecordID($student_record_id=null){
    $this->student_record_id=$student_record_id;
  }
}

?>
