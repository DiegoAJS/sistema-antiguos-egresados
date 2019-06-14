<?php

class PositionModel {
  private $conexion;
  private $response;

  /* person model */
  private $appointment_id;
  private $person_id;
  private $appointment;
  private $profession;
  private $specialty;
  private $career_direction;

  
  public function __CONSTRUCT(
    $appointment_id=null,
    $person_id=null,
    $appointment=null,
    $profession=null,
    $specialty=null,
    $career_direction=null
  ){
    /* model assignation */
    $this->appointment_id = $appointment_id;
    $this->person_id = $person_id;
    $this->appointment = $appointment;
    $this->profession = $profession;
    $this->specialty = $specialty;
    $this->career_direction = $career_direction;


    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processPosition($option = 5){
    $conex = $this->pdo;
    $sql = 'CALL crud_table_position(?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->appointment_id,
        $this->person_id,
        $this->appointment,
        $this->profession,
        $this->specialty,
        $this->career_direction
      )
    );
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo inserta

    if($query->rowCount()!=0){
      if($option == 6 || $option == 7){
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        $status = true;
        $msg = "Proceso con exito";
      }else{
        $result = $query->fetchObject();
        $status = $result->status;
        $msg = $result->msg;
      }			
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
