<?php
class DbConnect
{
    private $conn;
    function __construct(){
    }

    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect()
    {
        require_once 'Config.php';
        // Connecting to mysql database
        $conn = new mysqli(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME,'8889', '/var/lib/mysql/mysql.sock');
        // Check for database connection error
       
        if ($conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        } 
        if($conn){
            return $conn;
            echo "Connected successfully";
        }

        // returing connection resource
        return $conn;
    }
}