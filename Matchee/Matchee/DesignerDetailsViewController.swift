//
//  DesignerDetailsViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 1/4/17.
//  Copyright © 2017 Ememapps. All rights reserved.
//

import UIKit

class DesignerDetailsViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var URLString:String = ""
    var designerISProfile:String = ""
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func openISApp(_ sender: UIButton) {
        
        let instagramHooks = "instagram://user?username=\(designerISProfile)"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            if designerISProfile != "" {
                UIApplication.shared.open(instagramUrl! as URL, options: ["":""], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        self.activityIndicator.startAnimating()
        if URLString != "" {
            webView.loadRequest(URLRequest(url: URL(string: URLString)!))
        }
        else{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.activityIndicator.stopAnimating()
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
