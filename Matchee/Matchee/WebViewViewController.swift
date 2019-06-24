//
//  WebViewViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 13/2/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url: URL(string: "http://www.ememapps.com/matchee.html")!))
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        //self.removeFromParentViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
}
