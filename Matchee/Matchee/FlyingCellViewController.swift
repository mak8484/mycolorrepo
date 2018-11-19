//
//  FlyingCellViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 1/2/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

class FlyingCellViewController: UIViewController {

    public var topColorValue:UIColor = UIColor()
    public var beltColorValue:UIColor = UIColor()
    public var bottomColorValue:UIColor = UIColor()
    public var shoesColorValue:UIColor = UIColor()

    @IBOutlet var topView: UIView!
    @IBOutlet var beltView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var shoesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.backgroundColor = topColorValue
        beltView.backgroundColor = beltColorValue
        bottomView.backgroundColor = bottomColorValue
        shoesView.backgroundColor = shoesColorValue
        // Do any additional setup after loading the view.
    }
    
//    class func instanceFromNib() -> UIView {
//        return UINib(nibName: "FlyingCellViewController", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func updateCellColors(){
        

        
    }


}
