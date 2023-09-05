//
//  ViewControllermesajekranı.swift
//  sosyalmedya2
//
//  Created by Emir Seçer on 24.08.2023.
//

import UIKit

class ViewControllermesajekranı: UIViewController {
    @IBOutlet weak var isim: UILabel!
    var secilenisim = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        isim.text = secilenisim

    
        // Do any additional setup after loading the view.
    }
    
        
    }


