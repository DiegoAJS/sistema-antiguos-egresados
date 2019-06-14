<?php
  function getExternal($base = ""){
    $common = $base."api/common/";
    $env = $base."env/";
    /* security */
    require $common."security.php";
    /* enviroment */
    require $env."env.dev.php"; 
    //require $env."env.server.php";
  
    /* Common */
    require $common."conexion.php";
    require $common."response.php";
    require $common."verify-captcha.php";
    require $common."image-resizer.php";
    
    $baseApi = $base.'api/';
    $folders = [
      'models'
    ];
    foreach ($folders as $f) {
      foreach (glob($baseApi ."$f/*.php") as $k => $filename) {
        require $filename;
      }
    } 

  }
?>