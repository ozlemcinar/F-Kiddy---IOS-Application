<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    $parent_name = $_REQUEST['parent_name'];
    $parent_username = $_REQUEST['parent_username'];
    $parent_password = $_REQUEST['parent_password'];
    $phone_number = $_REQUEST['phone_number'];
    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->createparent($parent_name, $parent_username,$parent_password, $phone_number, $response)){
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