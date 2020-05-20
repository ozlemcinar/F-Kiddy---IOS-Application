<?php

require_once '/Users/ozlemcinar/Desktop/fkiddy/includes/DbOperation.php';
$returnValue = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
    $parent_username = $_REQUEST['parent_username'];
    $parent_password = $_REQUEST['parent_password'];
    $db = new DbOperation();

    if ($result = $db->isthereparent ($parent_username,$parent_password)) {

        $response['error']=false;
        $response['message']='Team added successfully';

    }
    else{
        $response['error']=true;
        $response['message']='Could not add team';
    }


}
else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
