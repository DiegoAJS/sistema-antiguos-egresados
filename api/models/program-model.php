<?php

class ProgramModel {
  private $conexion;
  private $response;

  /* person model */
  private $program_version_id;
  private $program_version;
  private $state;
  private $grade;
  private $cost;
  private $startd;
  private $finishd;

  
  public function __CONSTRUCT(
    $program_version_id=null,
    $program_version=null,
    $state=null,
    $grade=null,
    $cost=null,
    $startd=null,
    $finishd=null
  ){
    /* model assignation */
    $this->program_version_id = $program_version_id;
    $this->program_version = $program_version;
    $this->state = $state;
    $this->grade = $grade;
    $this->cost = $cost;
    $this->startd = $startd;
    $this->finishd = $finishd;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processProgram($option = 5){
    $conex = $this->pdo;
    $sql = 'call crud_table_program(?,?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->program_version_id,
        $this->program_version,
        $this->state,
        $this->grade,
        $this->cost,
        $this->startd,
        $this->finishd
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
