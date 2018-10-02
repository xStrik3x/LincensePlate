//
//  FillViewController.swift
//  lincenseplate
//
//  Created by student on 9/29/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FillViewController: UIViewController {
    
    @IBOutlet weak var fillTField: UITextField!
    @IBAction func fillBtn(_ sender: Any) {
        if fillTField.text != ""{
            guard let lp = fillTField.text else { return }
            let typeRef = Firestore.firestore().collection("รถยนต์")
            let docRef = typeRef.document(lp)
            docRef.getDocument{ (document, err) in
                if let document = document {
                    
                    if document.exists{
                        let retriVC = self.storyboard?.instantiateViewController(withIdentifier: "retri") as! RetrieveViewController
                        retriVC.data = lp
                        DispatchQueue.main.async (execute: {
                            self.present(retriVC, animated: true, completion: nil)
                        })
                    } else {
                        let alert = UIAlertController(title: "ไม่มียานพาหนะในระบบ", message: nil, preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert,animated: true,completion: nil)
                    }
                        
                }
            }
        } else {
            let alert = UIAlertController(title: "โปรดกรอกป้ายยานพาหนะ", message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
