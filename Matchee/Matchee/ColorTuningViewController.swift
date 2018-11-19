//
//  ColorTuningViewController.swift
//  Matchee
//
//  Created by Marco Mantegazza on 24/2/17.
//  Copyright © 2017 Ememapps. All rights reserved.
//

import UIKit




class ColorTuningViewController: UIViewController, SwiftHUEColorPickerDelegate {
    
    public var imageFromPicker = UIImage()
    private var colorize:Colorize = Colorize()
    private var selectedColor = UIColor()
    
    @IBOutlet var HUEPicker: SwiftHUEColorPicker!
    @IBOutlet var brightnessPicker: SwiftHUEColorPicker!
    @IBOutlet var saturationPicker: SwiftHUEColorPicker!
    
    @IBOutlet var colorTuningFillOutlet: UIImageView!
    @IBOutlet var pickedImageOutlet: UIImageView!
    @IBOutlet var hexValue: UILabel!
    
    //Buttons actions
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        
        let dataDict:[String: UIColor] = ["selectedColor": selectedColor]
        NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "Notification.changeClothColorFromDetection"), object: nil, userInfo: dataDict))
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        HUEPicker.delegate = self
        HUEPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
        HUEPicker.type = SwiftHUEColorPicker.PickerType.color
        //HUEPicker.currentColor = UIColor(hsba: (h: 180.0, s: 0.3, b: 0.3, a: 1.0))
        
        saturationPicker.delegate = self
        saturationPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
        saturationPicker.type = SwiftHUEColorPicker.PickerType.saturation
       // saturationPicker.currentColor = UIColor(hsba: (h: 180.0, s: 0.3, b: 0.3, a: 1.0))
        
        brightnessPicker.delegate = self
        brightnessPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
        brightnessPicker.type = SwiftHUEColorPicker.PickerType.brightness
       // brightnessPicker.currentColor = UIColor(hsba: (h: 180.0, s: 0.3, b: 0.3, a: 1.0))
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pickedImageOutlet.image = imageFromPicker
        
        let averageColor = self.imageFromPicker.averageColor()
        HUEPicker.currentColor = averageColor!
        saturationPicker.currentColor = averageColor!
        brightnessPicker.currentColor = averageColor!
        
        self.selectedColor = averageColor!
        
        let colorString = averageColor?.hexString
        self.hexValue.text = colorString
        
        self.colorTuningFillOutlet.image = UIImage(named: "colorDetectionFill")
        self.colorTuningFillOutlet.image = self.colorTuningFillOutlet.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.colorTuningFillOutlet.image = colorize.processPixels(in: self.colorTuningFillOutlet.image!, color: averageColor!)

    }

    override func viewDidLayoutSubviews() {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func averageColor() -> UIColor {
//        
//        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
//        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
//        let info = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//        let context: CGContext = CGContext(data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: info.rawValue)!
//        
//        context.draw(self.imageFromPicker.cgImage!, in: CGRect(x: 0.0,y: 0.0,width: 500,height: 500))
//
//        if rgba[3] > 0 {
//            
//            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
//            let multiplier: CGFloat = alpha / 255.0
//            
//            return UIColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
//            
//        } else {
//            
//            return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
//        }
//    }
    
    func valuePicked(_ color: UIColor, type: SwiftHUEColorPicker.PickerType) {
        
        
        switch type {
        case SwiftHUEColorPicker.PickerType.color:
            HUEPicker.currentColor = color
            saturationPicker.currentColor = color
            brightnessPicker.currentColor = color
            
            break
        case SwiftHUEColorPicker.PickerType.saturation:
            HUEPicker.currentColor = color
            saturationPicker.currentColor = color
            brightnessPicker.currentColor = color
            
            break
        case SwiftHUEColorPicker.PickerType.brightness:
            HUEPicker.currentColor = color
            saturationPicker.currentColor = color
            brightnessPicker.currentColor = color
            
            break
        default:
            break
        }
        
        self.selectedColor = color
        let colorString:String = color.hexString
        
        self.hexValue.text = colorString
        self.colorTuningFillOutlet.image = UIImage(named: "colorDetectionFill")
        self.colorTuningFillOutlet.image = self.colorTuningFillOutlet.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.colorTuningFillOutlet.image = colorize.processPixels(in: self.colorTuningFillOutlet.image!, color: color)

        
    }

    



}
