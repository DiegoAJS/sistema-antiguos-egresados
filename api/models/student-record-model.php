<?php

class StudentRecordModel {
  private $conexion;
  private $response;

  /* person model */
  private $student_record_id;
  private $person_student_id;
  private $program_version_id;
  private $career;
  private $career_direction;
  private $cu;
  private $cost;
  private $type_register;
  private $state;
  
  public function __CONSTRUCT(
    $student_record_id=null,
    $person_student_id=null,
    $program_version_id=null,
    $career=null,
    $career_direction=null,
    $cu=null,
    $cost=null,
    $type_register=null,
    $state=null
  ){

    /* model assignation */
    $this->student_record_id = $student_record_id;
    $this->person_student_id = $person_student_id;
    $this->program_version_id = $program_version_id;
    $this->career = $career;
    $this->career_direction=$career_direction;
    $this->cu = $cu;
    $this->cost = $cost;
    $this->type_register = $type_register;
    $this->state = $state;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_student_record(?,?,?,?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->student_record_id,
        $this->person_student_id,
        $this->program_version_id,
        $this->career,
        $this->career_direction,
        $this->cu,
        $this->cost,
        $this->type_register,
        $this->state
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
    $sql = 'call list_table_student_record(?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->person_student_id,
        $this->career,
        $this->career_direction
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

  public function setCareer($career){
    $this->career=$career;
  }

  public function setCareerDirection($careerDirection){
    $this->career_direction=$careerDirection;
  }

  public function setPersonStudentID($person_student_id){
    $this->person_student_id=$person_student_id;
  }

}

?>
