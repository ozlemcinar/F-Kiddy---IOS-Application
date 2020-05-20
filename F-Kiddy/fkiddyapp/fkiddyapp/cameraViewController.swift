
import UIKit

class cameraViewController: UIViewController {
    
    
    
    let name: UILabel = {
       let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Avenir-Heavy", size: 20)
        text.text = "are you officier or parent?"
        text.textColor = .label
        return text
        
    }()
    
    let backButton: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToBack(_:)), for: .touchUpInside)
        button.setTitle("parent", for: .normal)
        let icon = UIImage(systemName: "eye")?.resized(newSize: CGSize(width: 50, height: 30))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = .systemRed
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.systemRed.cgColor
        
        return button
    }()
   
    
    let faceClassification: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToFaceClassification(_:)), for: .touchUpInside)
        button.setTitle("officer", for: .normal)
        let icon = UIImage(systemName: "tray.fill")?.resized(newSize: CGSize(width: 50, height: 40))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = .systemBlue
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.systemBlue.cgColor
        return button
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
        setupLabel()
        setupButtons()
    }
    
    func setupTabBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Face AI"
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = .systemBackground
             navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            self.navigationController?.navigationBar.barTintColor = .lightText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        }
        self.navigationController?.navigationBar.isHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.barStyle = .default
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
        }
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.backgroundColor = .systemBackground
        } else {
            navigationController?.navigationBar.backgroundColor = .white
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLabel() {
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        name.heightAnchor.constraint(equalToConstant: 100).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        name.numberOfLines = 1
    }
    
    private func setupButtons() {
        
       
        view.addSubview(faceClassification)
        view.addSubview(backButton)
        
        
        
        faceClassification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceClassification.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        faceClassification.heightAnchor.constraint(equalToConstant: 70).isActive = true
        faceClassification.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
        
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.topAnchor.constraint(equalTo: faceClassification.bottomAnchor, constant: 30).isActive = true
    }
    
    
    
    @objc func buttonToFaceClassification(_ sender: BtnPleinLarge) {
           
       let controller = FaceClassificationViewController()

       let navController = UINavigationController(rootViewController: controller)
       
       self.present(navController, animated: true, completion: nil)
    }
    
    
    @objc func buttonToBack(_ sender: BtnPleinLarge) {
        
        
       /*let controller = ViewController()

       let navController = UINavigationController(rootViewController: controller)
       
       self.present(navController, animated: true, completion: nil)*/
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ViewController")
        present(secondVC, animated: true, completion: nil)

        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = self.storyboard?.instantiateViewControllerWithIdentifier("NewsDetailsVCID") as! NewsDetailsViewController
            vc.newsObj = newsObj
                 present(vc!, animated: true, completion: nil)
         
         */
    }
    
    
    

}



