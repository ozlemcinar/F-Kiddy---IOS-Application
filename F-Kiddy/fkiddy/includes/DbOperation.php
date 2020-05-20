<?php
class DbOperation
{
    private $conn;
    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config.php';
        require_once dirname(__FILE__) . '/DbConnect.php';

        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
        
    }
    public function createparent( $parent_name,$parent_username, $parent_password,$phone_number,$response)
    {
        $sql = "select * from parents where parent_username = '$parent_username' ";
        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            return false;
        }
        else{
            $str = "INSERT INTO parents(parent_name,parent_username,parent_password,phone_number) VALUES ('$parent_name', '$parent_username','$parent_password','$phone_number')";
            if ($this->conn->query($str)) {
                
                    return true;
                
            } else {
                return false;
            }
        }

    }
    public function camera ($camera_id){
        $str = "select location from camera where camera_id = '$camera_id'  " ;
        $stmt = $this->conn->prepare($str);
        $stmt->execute();
        $result = $stmt ->get_result();
        return $result;

    }

    public function images ($encoded_string, $image_name){
        
        $decoded_string = base64_decode($encoded_string);
        $path = '/images'.$image_name;
        $file = fopen($path,'wb');
        $is_written = fwrite($file,$decoded_string);
        echo $is_written;
        fclose($file);
        $str = "INSERT INTO photos(name,path) VALUES ('$image_name','$path')";
        if ($this->conn->query($str)) {
                return true;
            
        } else {
            return false;
        }

        
    }
    public function createchild( $child_name,$parent_username)
    {
        
        $str = "INSERT INTO children(parent_id,child_name) SELECT  parent_id, '$child_name' from parents where parent_username = '$parent_username'  " ;
        if ($this->conn->query($str)) { 
                return true;
            
        } else {
            return false;
        }
        
    }
    

    public function isthereparent($parent_username,$parent_password)
    {
        $sql = "select * from parents where parent_username = '$parent_username' and parent_password = '$parent_password' ";

        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            return true;
        }
        return false;
    }

    public function showChild($parent_username)
    {
        $str = "SELECT child_id,child_name, parent_username 
        from children, parents
        where  parents.parent_username = '$parent_username'
                and children.parent_id = parents.parent_id
                
         ORDER BY child_id ASC";
        $stmt = $this->conn->prepare($str);
        $stmt->execute();
        $result = $stmt ->get_result();
        return $result;

    }
    
    
    
}

