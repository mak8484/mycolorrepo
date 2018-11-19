//
//  GenderSelectionViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 27/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

class GenderSelectionViewController: UIViewController {

    @IBAction func selectWomanAction(_ sender: UIButton) {
        
        UserDefaults.standard.set("W", forKey: "Matchee.currentGender")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "genderSelectedSegue", sender: self)

    }
    
    @IBAction func selectManAction(_ sender: UIButton) {
        
        UserDefaults.standard.set("M", forKey: "Matchee.currentGender")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "genderSelectedSegue", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
