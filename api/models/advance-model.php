<?php

class AdvanceModel {
  private $conexion;
  private $response;

  /* person model */
  
  private $control_id;
  private $student_record_id;
  private $modality;
  private $document;
  private $software;
  
  public function __CONSTRUCT(
    $control_id         =null,
    $student_record_id  =null,
    $modality           =null,
    $document           =null,
    $software           =null
  ){

    /* model assignation */
    $this->control_id           = $control_id;
    $this->student_record_id    = $student_record_id;
    $this->modality             = $modality;
    $this->document             = $document;
    $this->software             = $software;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processAdvance($option = 5){
    $conex = $this->pdo;
    $sql = 'call crud_table_advance(?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->control_id,
        $this->student_record_id,
        $this->modality,
        $this->document,
        $this->software
      )
    );
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo insertar
    
    if($query->rowCount()!=0){
      if($option == 5 ){
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        $status = true;
        $msg = "Proceso con exito";

      }else{
        $result = $query->fetchObject();
        $status = $result->status;
        $msg = $result->msg;
      }
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
