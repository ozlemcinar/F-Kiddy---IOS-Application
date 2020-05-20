<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    $encoded_string = $_REQUEST['encoded_string'];
    $image_name = $_REQUEST['image_name'];
    
    //including the db operation file
    require_once '../includes/DbOperation.php';
    //$decoded_string = base64_decode($encoded_string);

    $db = new DbOperation();
    //inserting values
    if($db->images($encoded_string, $image_name)){
        $response['error']=false;
        $response['message']='Team added successfully\n';

    }else{
        $response['error']=true;
        $response['message']='Could not add team';
    }
}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);