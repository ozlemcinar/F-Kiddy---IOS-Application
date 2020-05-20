//
//  newChildViewController.swift
//  fkiddyapp
//
//  Created by Ozlem Cinar on 4/1/20.
//  Copyright © 2020 Ozlem Cinar. All rights reserved.
//

import UIKit
import Alamofire

class newChildViewController: UIViewController {
    var parent_username: String? = nil
    let URL_USER_REGISTER = "https://a0467e64.ngrok.io/api/createChild.php"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let showChildViewController = segue.destination as? showChildViewController{
            showChildViewController.parent_username = parent_username
        }
    }
    @IBOutlet weak var child_name: UITextField!
    
    @IBAction func addChildButton(_ sender: UIButton) {
        
        let parameters: Parameters=[
            "parent_username": parent_username!,
            "child_name": child_name.text!
        ]
       Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
            //print(response)
            
        }
        
        
        self.performSegue(withIdentifier: "childCreated", sender: self)

       
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
