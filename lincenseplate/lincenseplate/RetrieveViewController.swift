//
//  RetrieveViewController.swift
//  lincenseplate
//
//  Created by student on 9/29/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RetrieveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let docRef = Firestore.firestore().collection("รถยนต์").document("9กฐ9345")
        docRef.getDocument{(document, error) in
            if let depart = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Depart(dictionary: data)
                })
            }) {
                print("Depart: \(depart)")
            }else{
                print("Docu,emt deos not exist")
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
