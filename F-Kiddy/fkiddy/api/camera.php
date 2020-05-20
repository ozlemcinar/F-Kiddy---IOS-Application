<?php
//creating response array
require_once '/Users/ozlemcinar/Desktop/fkiddy/includes/DbOperation.php';

//$response = array();
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $camera_id= $_REQUEST['camera_id'];


    $db = new DbOperation();
    $teams = $db->camera($camera_id);
    //getting the teams using the function we created

    //looping through all the teams.
    while ($team = $teams->fetch_assoc()) {
        //creating a temporary array
        $temp = array();
        //inserting the team in the temporary array
        $temp['camera_id'] = $team['camera_id'];
        $temp['location'] = $team['location'];
        //inserting the temporary array inside response
        array_push($response, $temp);

    }

}else{

    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);

