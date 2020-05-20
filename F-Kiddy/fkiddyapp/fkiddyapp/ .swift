

import UIKit
import AVKit
import Vision
import VideoToolbox
import MessageUI
import Alamofire

class FaceClassificationViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, MFMessageComposeViewControllerDelegate {
    var phone_number: String? = nil
    var c:String?
    var location:String?
    var z:Int?
    var counter:Int? = 0
    var counter2:Int?
    var total: Int?

    let URL_USER_REGISTER = "https://bf04f28b.ngrok.io/api/camera.php"

    
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
           
       }
       @IBAction func sendMessageButtonAction(_ sender: Any) {
           displayMessageInterface()
       }
       
       func displayMessageInterface(){
           
           let composeVC = MFMessageComposeViewController()
           composeVC.messageComposeDelegate = self
           
           composeVC.recipients = ["6073405801"]
           composeVC.body = "Your child is found in this location : Walmart in Vestal!"
           
           if MFMessageComposeViewController.canSendText(){
               self.present(composeVC,animated: true,completion: nil)
           }else{
               print("Can't send messages.")
           }
       }
    let backButton: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("parent", for: .normal)
        button.addTarget(self, action: #selector(buttonToBack(_:)), for: .touchUpInside)
        let icon = UIImage(systemName: "eye")?.resized(newSize: CGSize(width: 70, height: 70))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = .systemRed
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.systemRed.cgColor
        return button
    }()
       
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = UIFont(name: "Avenir-Heavy", size: 30) //attaki yazi
        //print(label.text)
        label.text = "No face"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupCamera()
        setupLabel()
        setupButtons()
    }
    
    func setupTabBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Face Classification"
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = .systemBackground
             navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            // Fallback on earlier versions
            self.navigationController?.navigationBar.barTintColor = .lightText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        }
        self.navigationController?.navigationBar.isHidden = true
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
            // Fallback on earlier versions
            navigationController?.navigationBar.backgroundColor = .white
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func setupCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    fileprivate func setupLabel() {
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    private func setupButtons() {
        
        view.addSubview(backButton)
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    
    @objc func buttonToBack(_ sender: BtnPleinLarge) {
        
        
       /*let controller = ViewController()

       let navController = UINavigationController(rootViewController: controller)
       
       self.present(navController, animated: true, completion: nil)*/
        print("aa")

        displayMessageInterface()


        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = self.storyboard?.instantiateViewControllerWithIdentifier("NewsDetailsVCID") as! NewsDetailsViewController
            vc.newsObj = newsObj
                 present(vc!, animated: true, completion: nil)
         
         */
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
                    fatalError("Unable to load model")
                }
                
        let coreMlRequest = VNCoreMLRequest(model: model) {[weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("Unexpected results")
            }
            
           


            DispatchQueue.main.async {[weak self] in
                self?.label.text = topResult.identifier
            }
            if(topResult.identifier != "unknown"){
                self!.displayMessageInterface()
                
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        DispatchQueue.global().async {
            do {
                try handler.perform([coreMlRequest])
            } catch {
                print(error)
            }
        }
        
    }
    
}
