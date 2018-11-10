    //
    //  ScanViewController.swift
    //  lincenseplate
    //
    //  Created by student on 10/3/18.
    //  Copyright © 2018 student. All rights reserved.
    //
    
    import UIKit
    import SwiftOCR
    import Firebase
    import FirebaseFirestore
    
    class MotorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        
        @IBOutlet weak var img: UIImageView!
        
        @IBOutlet weak var plate: UITextField!
        @IBAction func OCR(_ sender: Any) {
            
            if (img.image != nil){
                let swiftOCRIns = SwiftOCR()
                swiftOCRIns.recognize(img.image!) { recognizedString in
                    DispatchQueue.main.async {
                        self.plate.text = recognizedString
                    }
                    print(recognizedString)
                    
                }
            }
            else{
                let alert = UIAlertController(title: "โปรดเลือกรูปหรือถ่ายรูป", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                
            }
            
        }
        
        
        @IBAction func chooseBtn(_ sender: Any) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            
        }
        
        @IBAction func Okbtn(_ sender: Any) {
            if plate.text != ""{
                guard let lp = plate.text else { return }
                let typeRef = Firestore.firestore().collection("รถจักยานยนต์")
                let docRef = typeRef.document(lp)
                docRef.getDocument{ (document, err) in
                    if let document = document {
                        
                        if document.exists{
                            let retriVC = self.storyboard?.instantiateViewController(withIdentifier: "retri") as! RetrieveViewController
                            retriVC.data = lp
                            retriVC.type = "รถจักยานยนต์"
                            DispatchQueue.main.async (execute: {
                                self.navigationController?.pushViewController(retriVC, animated: true)
                            })
                        } else {
                            let alert = UIAlertController(title: "ไม่มีเลขทะเบียนในระบบ", message: nil, preferredStyle: .alert)
                            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert,animated: true,completion: nil)
                        }
                        
                    }
                }
            } else {
                let alert = UIAlertController(title: "โปรดกรอกเลขทะเบียนรถ", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
        
    }


    


