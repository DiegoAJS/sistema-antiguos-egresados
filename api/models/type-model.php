<?php

class TypeModel {
  
  private $conexion;
  private $response;

  /* person model */
  
  private $type_id;
  private $name_type;
  private $label_type;
  private $foreign_type_id;
  
  public function __CONSTRUCT(
    $type_id=null,
    $name_type=null,
    $label_type=null,
    $foreign_type_id=null
  ){

    /* model assignation */
    $this->type_id = $type_id;
    $this->name_type = $name_type;
    $this->label_type = $label_type;
    $this->foreign_type_id = $foreign_type_id;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processType($option = 6){
    $conex = $this->pdo;
    $sql = 'call crud_table_type(?,?,?,?,?);';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->type_id,
        $this->name_type,
        $this->label_type,
        $this->foreign_type_id
      )
    );
    
    $result = null;  // data null
    $msg = "No existen datos";
    $status = false; // no se pudo insertar

    if($query->rowCount()!=0){
      if($option == 6 || $option == 7 || $option == 8 || $option == 9){
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
