//
//  ViewController.swift
//  fkiddyapp
//
//  Created by Ozlem Cinar on 3/4/20.
//  Copyright © 2020 Ozlem Cinar. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var parent_username: UITextField!
    @IBOutlet weak var parent_password: UITextField!
    var phone_number: String? = nil
    
    
    let URL_USER_REGISTER = "https://a0467e64.ngrok.io/api/isthereparent.php"
    var c:String?
    @IBAction func signInButton(_ sender: UIButton) {
        let parameters: Parameters=[
            "parent_username":parent_username.text!,
            "parent_password":parent_password.text!
        ]
        //print(parent_username.text!)
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
            if let result = response.result.value {
                //converting it as NSDictionary
                let jsonData = result as! NSDictionary
                //displaying the message in label
                 self.c = jsonData.value(forKey: "message") as! String?
                //print(self.c)
                if(self.c == "Team added successfully"){
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                else{
                    //print("boyle bir kullanici yok")
                    let alert = UIAlertController(title: "HEEYY", message: "Username or Password is wrong", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }//alamofire son
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
        if let showChildViewController = segue.destination as? showChildViewController{
            showChildViewController.parent_username = parent_username.text
            showChildViewController.phone_number = phone_number
            
        }
        
    }
    

}












