//
//  ScanViewController.swift
//  lincenseplate
//
//  Created by student on 10/3/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftyTesseract

class CarViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var plate: UITextField!
    
    @IBAction func CameraBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "โทรศัพท์ของคุณไม่สามารถใช้กล้องได้", message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    
    @IBAction func OCR(_ sender: Any) {
        
        if (img.image != nil){
            let swiftyTesseract = SwiftyTesseract(languages: [.thai])
            
            guard let image = img.image else { return }
            swiftyTesseract.performOCR(on: image) { recognizedString in
                
                guard let recognizedString = recognizedString else { return }
                self.plate.text = recognizedString.replacingOccurrences(of: " ", with: "")
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
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        img.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
//        let ciImage = CIImage(image: img.image!)
//        let blackAndWhiteImage = ciImage!.applyingFilter("CIColorControls", parameters: ["inputSaturation": 0, "inputContrast": 5])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //grayScale()
    }
    
    
    @IBAction func Okbtn(_ sender: Any) {
        if plate.text != ""{
            guard let lp = plate.text else { return }
            let typeRef = Firestore.firestore().collection("รถยนต์")
            let docRef = typeRef.document(lp)
            docRef.getDocument{ (document, err) in
                if let document = document {
                    
                    if document.exists{
                        let retriVC = self.storyboard?.instantiateViewController(withIdentifier: "retri") as! RetrieveViewController
                        retriVC.data = lp
                        retriVC.type = "รถยนต์"
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
    func grayScale() {
        let currentCIImage = CIImage(image: img.image!)
        
 //       let blackAndWhiteImage = currentCIImage!.applyingFilter("CIColorControls", parameters: ["inputSaturation": 0, "inputContrast": 5])

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")

        // set a gray value for the tint color
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return }
        let context = CIContext()

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            print(processedImage.size)
            img.image = processedImage
        }
    }
    
    
}
