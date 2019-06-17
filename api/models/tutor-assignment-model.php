<?php

class TutorAssignmentModel {
  private $conexion;
  private $response;

  /* person model */
  private $tutor_assignment_id;
  private $student_record_id;
  private $person_student_id;
  private $person_tutor_id;
  private $finishd;
  
  public function __CONSTRUCT(
    $tutor_assignment_id=null,
    $student_record_id=null,
    $person_student_id=null,
    $person_tutor_id=null,
    $finishd=null
  ){

    /* model assignation */
    $this->tutor_assignment_id = $tutor_assignment_id;
    $this->student_record_id = $student_record_id;
    $this->person_student_id = $person_student_id;
    $this->person_tutor_id = $person_tutor_id;
    $this->finishd = $finishd;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_tutor_assignment(?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->tutor_assignment_id,
        $this->student_record_id,
        $this->person_student_id,
        $this->person_tutor_id,
        $this->finishd
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
    $sql = 'call list_table_tutor_assignment(?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option
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

  public function setPersonTutorID($person_tutor_id=null){
    $this->person_tutor_id=$person_tutor_id;
  }

}

?>
