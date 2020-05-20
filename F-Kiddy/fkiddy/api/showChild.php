<?php
//creating response array
require_once '/Users/ozlemcinar/Desktop/fkiddy/includes/DbOperation.php';

//$response = array();
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $parent_username= $_REQUEST['parent_username'];


    $db = new DbOperation();
    $teams = $db->showChild($parent_username);
    //getting the teams using the function we created

    //looping through all the teams.
    while ($team = $teams->fetch_assoc()) {
        //creating a temporary array
        $temp = array();
        //inserting the team in the temporary array
        $temp['parent_username'] = $team['parent_username'];
        $temp['child_id'] = $team['child_id'];
        $temp['child_name'] = $team['child_name'];



        //inserting the temporary array inside response
        array_push($response, $temp);

    }

}else{

    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);

