//
//  ViewController.swift
//  lincenseplate
//
//  Created by student on 9/10/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passtext: UITextField!
    
    @IBOutlet weak var viewbg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewbg.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        emailtext.delegate = self
        passtext.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func login(_ sender: UIButton) {
        if emailtext.text != "" && passtext.text != ""
        {
            Auth.auth().signIn(withEmail: emailtext.text! + "@bumail.net" , password: passtext.text!) { (user, error) in
                if user != nil{
                    let login = self.storyboard?.instantiateViewController(withIdentifier: "tabCon") as! TabController
                    DispatchQueue.main.async(execute: {
                        
                        self.present(login, animated: true, completion: nil)
                    })
                }
                    
                else
                {
                    let alert = UIAlertController(title: "โปรดกรอกชื่อผู้ใช้หรือรหัสผ่านให้ถูกต้อง", message: nil, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true,completion: nil)
                }
            }
            
        }
        else{
            if emailtext.text == "" && passtext.text == ""
            {
                let alert = UIAlertController(title: "โปรดกรอกชื่อผู้ใช้และรหัสผ่าน", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }
            else if emailtext.text == ""
            {
                let alert = UIAlertController(title: "โปรดกรอกชื่อผู้ใช้", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }
            else if passtext.text == ""
            {
                let alert = UIAlertController(title: "โปรดกรอกรหัสผ่าน", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "โปรดกรอกชื่อผู้ใช้และรหัสผ่านให้ครบถ้วน", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }
        }
    }
}

