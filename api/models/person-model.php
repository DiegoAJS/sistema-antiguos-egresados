<?php

class PersonModel {
  private $conexion;
  private $response;

  /* person model */
  private $person_id;
  private $first_name;
  private $last_name;
  private $ci;
  private $email;
  private $cellphone;
  private $telephone;
  private $city;
  private $address;
  private $pass;

  
  public function __CONSTRUCT(
    $person_id = null,
    $first_name = null,
    $last_name = null,
    $ci = null,
    $email = null,
    $cellphone = null,
    $telephone = null,
    $city = null,
    $address = null,
    $pass = null
  ){
    /* model assignation */
    $this->person_id = $person_id;
    $this->first_name = $first_name;
    $this->last_name = $last_name;
    $this->ci = $ci;
    $this->email = $email;
    $this->cellphone = $cellphone;
    $this->telephone = $telephone;
    $this->city = $city;
    $this->address = $address;
    $this->pass = $pass;

    /* database interaction init */
    $this->conexion = new Conexion();
    $this->pdo 		= $this->conexion->getConexion();
    $this->response = new Response();
    $this->security = new Security();
  }

  public function processCrud($option){
    $conex = $this->pdo;
    $sql = 'call crud_table_person(?,?,?,?,?,?,?,?,?,?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->person_id,
        $this->first_name,
        $this->last_name,
        $this->ci,
        $this->email,
        $this->cellphone,
        $this->telephone,
        $this->city,
        $this->address,
        $this->pass
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
    $sql = 'call list_table_person(?,?)';
    $query = $conex->prepare($sql);
    $query->execute(
      array(
        $option,
        $this->person_id
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

  public function setCi($ci)
  {
    $this->ci = $ci;
  }

  public function setPass($pass)
  {
    $this->pass = $pass;
  }
}

?>
