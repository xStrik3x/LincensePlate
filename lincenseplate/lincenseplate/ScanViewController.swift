//
//  ScanViewController.swift
//  lincenseplate
//
//  Created by student on 10/3/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import SwiftOCR


class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBAction func chooseBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let swiftOCRIns = SwiftOCR()
//
//        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        swiftOCRIns.recognize(img.image!) { recognizedString in
//            print(recognizedString)
//        }
    }
    

}
