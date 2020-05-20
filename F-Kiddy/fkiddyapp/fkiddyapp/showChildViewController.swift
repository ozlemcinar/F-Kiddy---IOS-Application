//
//  showChildViewController.swift
//  fkiddyapp
//
//  Created by Ozlem Cinar on 3/30/20.
//  Copyright © 2020 Ozlem Cinar. All rights reserved.
//

import UIKit
import Alamofire

class showChildViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate {

    
    
    let URL_USER_REGISTER = "https://a0467e64.ngrok.io/api/showChild.php"
    var parent_username: String? = nil
    var phone_number: String? = nil
    var c:String?
    var z:Int?
    var counter:Int? = 0
    var counter2:Int?
    var total: Int?
    var deneme = CollectionViewCell()
    @IBOutlet weak var imageViewTwo: UIImage?
    @IBOutlet private var x: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    @IBAction func lostChildButton(_ sender: Any) {
        let alert = UIAlertController(title: "IN PROGRESS", message: "We get your request right now, we will send a message when we find your child!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editButtonTapped() -> Void {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(image, animated:true){
                             
                                 //after
                             }
        image.allowsEditing = false
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("abcd")
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //self.imageViewTwo.image = image
        //cell.childImage.image = self.imageViewTwo.image
        imageViewTwo = image
        x = CollectionViewCell.init().self.childImage
        x = imageViewTwo
        deneme.childImage = imageViewTwo
        print(deneme.childImage)
        //imageViewTwo.image = image
        self.dismiss(animated:true,completion: nil)
        let alert = UIAlertController(title: "HEEYY", message: "picture is uploaded to our system!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let parameters: Parameters=[
            "parent_username": parent_username!
        ]
    
        let editButton = UIButton(frame: CGRect(x:10, y:20, width:100,height:100))
        editButton.setImage(UIImage(named: "launchscreenlogo.png"), for: UIControl.State.normal)
        cell.addSubview(editButton)
        
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            if let result = response.result.value {
                //converting it as NSDictionary
                let jsonData = result as! NSArray
                //displaying the message in label
                self.total = jsonData.count
                for i in jsonData{
                    let jsonData2 = i as! NSDictionary
                    self.c = jsonData2.value(forKey: "child_name") as! String?
                    self.counter2 = (jsonData2.value(forKey: "child_id") as! Int?)!
                    let x:Int = self.counter2!
                    let y:Int = self.counter!
                    if(x>y){
                        cell.mylabel.text = self.c
                        editButton.addTarget(self, action: #selector(self.editButtonTapped), for: UIControl.Event.touchUpInside)
                        self.counter = (jsonData2.value(forKey: "child_id") as! Int?)!
                        break
                        
                    }
                }
            }
        }//alamofire son

        return cell
    }
    
    @IBAction func newChildButton(_ sender: UIButton) {
    
        
        self.performSegue(withIdentifier: "addChild", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newChildViewController = segue.destination as? newChildViewController{
            newChildViewController.parent_username = parent_username
        }
        if let FaceClassificationViewController = segue.destination as? FaceClassificationViewController{
            FaceClassificationViewController.phone_number = phone_number
            
        }
    }
}

