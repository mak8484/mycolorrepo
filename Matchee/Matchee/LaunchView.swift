//
//  LaunchViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 7/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

class LaunchView: UIViewController {

    @IBOutlet var logoView: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()



    }
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            
            let screenHeight = UIScreen.main.bounds.height
            
            switch screenHeight {
                case 896:
                    self.logoView.frame = CGRect(x: 8, y: 48, width: 60, height: 22)
                case 812:
                    self.logoView.frame = CGRect(x: 8, y: 48, width: 60, height: 22)
                default:
                    self.logoView.frame = CGRect(x: 8, y: 8, width: 60, height: 22)

            }
            
        }, completion: {(true) in
            
            let currentGender:String? = UserDefaults.standard.string(forKey: "Matchee.currentGender")

            if currentGender != nil {
                self.performSegue(withIdentifier: "launchSegue", sender: self)
            }
            else{
                self.performSegue(withIdentifier: "genderSelectionSegue", sender: self)

            }
            
        })
    }



}
