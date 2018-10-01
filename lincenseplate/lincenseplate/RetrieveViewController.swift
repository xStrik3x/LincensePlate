//
//  RetrieveViewController.swift
//  lincenseplate
//
//  Created by student on 9/29/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class RetrieveViewController: UIViewController {

    @IBOutlet weak var lblno: UILabel!
    @IBOutlet weak var lblstate: UILabel!
    @IBOutlet weak var lblfname: UILabel!
    @IBOutlet weak var lbllname: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lbldepart: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //firestore path
        let docRef = Firestore.firestore().collection("รถยนต์").document("9กฐ9345")
        
        
        //get data
        docRef.getDocument { (document, err) in
            if let document = document {
    
                let no = document.get("no")
                let state = document.get("state")
                let fname = document.get("fname")
                let lname = document.get("lname")
                let number = document.get("number")
                let depart = document.get("depart")
                //show out on lbl
                self.lblno.text = no as? String
                self.lblstate.text = state as? String
                self.lblfname.text = fname as? String
                self.lbllname.text = lname as? String
                self.lblnumber.text = number as? String
                self.lbldepart.text = depart as? String
            } else {
                print("Document does not exist")
            }
        }
        
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
