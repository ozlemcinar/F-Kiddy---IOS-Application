<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $child_name = $_REQUEST['child_name'];
    $parent_username= $_REQUEST['parent_username'];

    //including the db operation file
    require_once '/Users/ozlemcinar/Desktop/fkiddy/includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->createchild($child_name,$parent_username)){
        $response['error']=false;
        $response['message']='Team added successfully';


    }else{
        $response['error']=true;
        $response['message']='Could not add team';

    }


}else{

    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);

