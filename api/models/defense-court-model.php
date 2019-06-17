<?php

class DefenseCourtModel {
  private $conexion;
  private $response;

  /* person model */
  private $defense_court_id;
  private $student_record_id;
  private $person_student_id;
  private $person_teacher_id_1;
  private $person_teacher_id_2;
  private $person_teacher_id_3;
  private $defensed;
  private $place_defense;
  private $note;
  
  public function __CONSTRUCT(
    $defense_court_id=null,
    $student_record_id=null,
    $person_student_id=null,
    $person_teacher_id_1=null,
    $person_teacher_id_2=null,
    $person_teacher_id_3=null,
    $defensed=null,
    $place_defense=null,
    $note=null
  ){

    /* model assignation */
    $this->defense_court_id=$defense_court_id;
    $this->student_record_id=$student_record_id;
    $this->person_student_id=$person_student_id;
    $this->person_teacher_id_1=$person_teacher_id_1;
    $this->person_teacher_id_2=$person_teacher_id_2;
    $this->person_teacher_id_3=$person_teacher_id_3;
    $this->defensed=$defensed;
    $this->place_defense=$place_defense;
    $this->note=$note;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_defense_court(?,?,?,?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->defense_court_id,
        $this->student_record_id,
        $this->person_student_id,
        $this->person_teacher_id_1,
        $this->person_teacher_id_2,
        $this->person_teacher_id_3,
        $this->defensed,
        $this->place_defense,
        $this->note
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
    $sql = 'call list_table_defense_court(?)';
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
}

?>
