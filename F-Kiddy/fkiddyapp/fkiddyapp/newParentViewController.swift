//
//  newParentViewController.swift
//  fkiddyapp
//
//  Created by Ozlem Cinar on 3/5/20.
//  Copyright © 2020 Ozlem Cinar. All rights reserved.
//

import UIKit
import Alamofire

class newParentViewController: UIViewController {

    let URL_USER_REGISTER = "https://a0467e64.ngrok.io/api/createparent.php"
    
    @IBOutlet weak var parent_name: UITextField!
    
    @IBOutlet weak var parent_username: UITextField!
    
    @IBOutlet weak var parent_password: UITextField!
    
    @IBOutlet var phone_number: UITextField!
    
    var c:String?
    
    @IBAction func newParentButton(_ sender: UIButton) {
        let parameters: Parameters=[
            "parent_name":parent_name.text!,
            "parent_username":parent_username.text!,
            "parent_password":parent_password.text!,
            "phone_number":phone_number.text!
        ]
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
            //print(response)
            
        }
        self.performSegue(withIdentifier: "parentCreated", sender: self)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parent_password.isSecureTextEntry = true


        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ViewController = segue.destination as? ViewController{
            ViewController.phone_number = phone_number.text
        }
    }
    

}

