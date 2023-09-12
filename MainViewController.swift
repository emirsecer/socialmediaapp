//
//  MainViewController.swift
//  sosyalmedya2
//
//  Created by Emir Seçer on 12.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    var handle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }; override func viewWillAppear(_ animated: Bool) {
         handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
         } as! String
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle as NSObjectProtocol)
    }
    
 
 

}
