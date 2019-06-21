//
//  MatchSettingsViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 26/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit
import  Mixpanel
import MessageUI

class MatchSettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    //Outlets
    @IBOutlet var ButtonComplementary: UIButton!
    @IBOutlet var ButtonMono: UIButton!
    @IBOutlet var ButtonAnalogous: UIButton!
    @IBOutlet var ButtonSplitComplementary: UIButton!
    
    @IBOutlet var buttonBuyMore: UIButton!
    
    var complementary:Int = 0
    var mono:Int = 0
    var analogous:Int = 0
    var split:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //localization
        self.buttonBuyMore.titleLabel?.text = NSLocalizedString("settings_buyMoreButton", comment: "Buy More")
        
        complementary = UserDefaults.standard.integer(forKey: "Matchee.complementaryCheck")
        mono = UserDefaults.standard.integer(forKey: "Matchee.monochromaticCheck")
        analogous = UserDefaults.standard.integer(forKey: "Matchee.analogousCheck")
        split = UserDefaults.standard.integer(forKey: "Matchee.splitComplementaryCheck")
        let splitPurchased = UserDefaults.standard.integer(forKey: "Matchee.splitComplementaryPurchased")
        
        if complementary == 1{
            ButtonComplementary.isSelected = true
            ButtonComplementary.setBackgroundImage(UIImage(named:"button_Complementary_Thick"), for: UIControl.State.selected)
        }
        else{
            ButtonComplementary.isSelected = false
            ButtonComplementary.setBackgroundImage(UIImage(named:"button_Complementary"), for: UIControl.State.selected)
        }
        
        if mono == 1{
            ButtonMono.isSelected = true
            ButtonMono.setBackgroundImage(UIImage(named:"button_Monochromatic_Thick"), for: UIControl.State.selected)
        }
        else{
            ButtonMono.isSelected = false
            ButtonMono.setBackgroundImage(UIImage(named:"button_Monochromatic"), for: UIControl.State.selected)
        }
        
        if analogous == 1{
            ButtonAnalogous.isSelected = true
            ButtonAnalogous.setBackgroundImage(UIImage(named:"button_Analogous_Thick"), for: UIControl.State.selected)
        }
        else{
            ButtonAnalogous.isSelected = false
            ButtonAnalogous.setBackgroundImage(UIImage(named:"button_Analogous"), for: UIControl.State.selected)
        }
        
        if split == 1{
            ButtonSplitComplementary.isSelected = true
            ButtonSplitComplementary.setBackgroundImage(UIImage(named:"button_SplitComplementary_Thick"), for: UIControl.State.selected)
        }
        else{
            if splitPurchased == 1 {
                ButtonSplitComplementary.isSelected = false
                ButtonSplitComplementary.setBackgroundImage(UIImage(named:"button_SplitComplementary"), for: UIControl.State.normal)
            }
            else{
                ButtonSplitComplementary.isSelected = false
                ButtonSplitComplementary.setBackgroundImage(UIImage(named:"button_SplitComplementary_Pay"), for: UIControl.State.normal)
            }
        }

    }

    //Buttons actions
    @IBAction func closeController(_ sender: UIButton) {
        dismiss(animated: true, completion: {
        
            //Refresh the matching labels in StretchViewController
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Notification.colorMatching")))
        
        })
    }
    
    @IBAction func ButtonComplementaryAction(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setBackgroundImage(UIImage(named:"button_Complementary_Thick"), for: UIControl.State.selected)
            UserDefaults.standard.set(1, forKey: "Matchee.complementaryCheck")
            UserDefaults.standard.synchronize()
        }
        else{
            sender.isSelected = false
            sender.setBackgroundImage(UIImage(named:"button_Complementary"), for: UIControl.State.selected)
            UserDefaults.standard.set(0, forKey: "Matchee.complementaryCheck")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func ButtonMonoAction(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setBackgroundImage(UIImage(named:"button_Monochromatic_Thick"), for: UIControl.State.selected)
            UserDefaults.standard.set(1, forKey: "Matchee.monochromaticCheck")
            UserDefaults.standard.synchronize()
        }
        else{
            sender.isSelected = false
            sender.setBackgroundImage(UIImage(named:"button_Monochromatic"), for: UIControl.State.selected)
            UserDefaults.standard.set(0, forKey: "Matchee.monochromaticCheck")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func ButtonAnalogousAction(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setBackgroundImage(UIImage(named:"button_Analogous_Thick"), for: UIControl.State.selected)
            UserDefaults.standard.set(1, forKey: "Matchee.analogousCheck")
            UserDefaults.standard.synchronize()
        }
        else{
            sender.isSelected = false
            sender.setBackgroundImage(UIImage(named:"button_Analogous"), for: UIControl.State.selected)
            UserDefaults.standard.set(0, forKey: "Matchee.analogousCheck")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func ButtonSplitComplementaryAction(_ sender: UIButton) {
       
        if UserDefaults.standard.integer(forKey: "Matchee.splitComplementaryPurchased") == 1{
            if sender.isSelected == false {
                sender.isSelected = true
                sender.setBackgroundImage(UIImage(named:"button_SplitComplementary_Thick"), for: UIControl.State.selected)
                UserDefaults.standard.set(1, forKey: "Matchee.splitComplementaryCheck")
                UserDefaults.standard.synchronize()
            }
            else{
                sender.isSelected = false
                sender.setBackgroundImage(UIImage(named:"button_SplitComplementary"), for: UIControl.State.normal)
                UserDefaults.standard.set(0, forKey: "Matchee.splitComplementaryCheck")
                UserDefaults.standard.synchronize()
            }
        }
        else{
            self.performSegue(withIdentifier: "IAPSegue", sender: nil)
        }
//        let mixpanel = Mixpanel.sharedInstance()
//        var properties = [String: String]()
//        properties = ["Purchase": ""]
//        mixpanel.track("Purchased Filter", properties: properties)
//
//        SweetAlert().showAlert(NSLocalizedString("addons_availableSoon", comment: ""), subTitle: NSLocalizedString("addons_availableSoonText", comment: ""), style: AlertStyle.none)
    }
    
    @IBAction func sendFeedbackButtonAction(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["hellomatchee@gmail.com"])
            mail.setMessageBody("<p>Write anything you like here:</p>", isHTML: true)
            mail.setSubject("My feedback on Matchee")
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
 

}
