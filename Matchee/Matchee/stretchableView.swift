//
//  stretchableView.swift
//  Tinder like drag
//
//  Created by Marco Mantegazza on 28/12/16.
//  Copyright © 2016 FYDEM Pte Ltd. All rights reserved.
//

import UIKit


final class currentClothPiecesOfStretchView {
    
    private init() { }
    
    static let sharedInstance: currentClothPiecesOfStretchView = currentClothPiecesOfStretchView()
    
        var top:NSArray = NSArray()
        var belt:NSArray = NSArray()
        var bottom:NSArray = NSArray()
        var shoes:NSArray = NSArray()
    
//    var top:clothPiece = clothPiece(cloth:"",drawingOrder:.top, designer:[""])
//    var belt:clothPiece = clothPiece(cloth:"",drawingOrder:.belt, designer:[""])
//    var bottom:clothPiece = clothPiece(cloth:"",drawingOrder:.pants, designer:[""])
//    var shoes:clothPiece = clothPiece(cloth:"",drawingOrder:.shoes, designer:[""])
}

class stretchableView: UIImageView {
    
    struct Constants {
        static let boundaryHeightMax = 350
        static let boundaryWidthMax = 350
        static let boundaryHeightMin = 15
        static let boundaryWidthMin = 150
    }
    
    private struct stretchImagesProportionsWomen {
        let topProportion:CGFloat = 0.390
        let beltProportion:CGFloat = 0.03
        let bottomProportion:CGFloat = 0.600
        let bottomShiftUp:CGFloat = 0.06
        let shoesProportion:CGFloat = 0.070
    }
    
    private struct stretchImagesProportionsMen {
        let topProportion:CGFloat = 0.430
        let beltProportion:CGFloat = 0.030
        let bottomProportion:CGFloat = 0.560
        let bottomShiftUp:CGFloat = 0.0
        let shoesProportion:CGFloat = 0.070
    }
    
    private var didSetupConstraints = false
    private var lastTouchedPositionPinchOut = CGPoint(x: 0, y: 0)
    
    //This class helps colorize the clothes
    private var colorize:Colorize = Colorize()
    
    public var centerPoint:CGPoint = CGPoint.zero
    public var siblingView:UIImageView? = UIImageView()
    public var backgroundView:UIImageView = UIImageView()
    public var boundariesMax:CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Constants.boundaryWidthMax, height: Constants.boundaryHeightMax))
    public var boundariesMin:CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Constants.boundaryWidthMin, height: Constants.boundaryHeightMin))
    
    public var clothes:[Cloth] = [Cloth]()

    public var skinColor:UIColor = UIColor(red: 229/255.0, green: 194/255.0, blue: 152/255.0, alpha: 1.0)

    enum Axis {
        case X
        case Y
    }
    
    
    public func setImageViewColor(cloth:Cloth, color:UIColor){

        cloth.color = color
        cloth.imageView.image = cloth.image
        cloth.imageView.image = cloth.imageView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cloth.imageView.image = colorize.processPixels(in: cloth.imageView.image!, color: color)//MM might add check if image exists
        
    }
    
    public func setStoredSetColorsToCurrentClothes(storedColors:[UIColor]){
    
        self.clothes[0].color = storedColors[0]
        self.clothes[1].color = storedColors[1]
        self.clothes[2].color = storedColors[2]
        self.clothes[3].color = storedColors[3]
        self.initSiblingView()
    }
    
    public func initWithClothes(clothes:[Cloth]) {
    //    self.tag = -1
        self.clothes = clothes
        initBackgroundView()
        initSiblingView()
    }
    
    public func changeGenderClothes(clothes:[Cloth]) {
    //    self.tag = -1
        self.clothes = clothes
        initSiblingView()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if didSetupConstraints == false {
        //    addConstraintsForMyView()
        }
    }
    
    func saveCurrentUsedClothes(){
        let storageManager = Storage()
        storageManager.storeCurrentClothesSet(clothesArray: clothes)
        
    }
    
    func restoreCurrentUsedClothes() -> Bool{
        let storageManager = Storage()
        let clothesSet = storageManager.getCurrentClothingSet()
        
        if clothesSet.count > 0 {
            self.clothes = clothesSet
            self.initSiblingView()
            return true
        }
        else{
            return false
        }
    }
    
    func initSiblingView(){

        //Remove all subviews
//        self.subviews.forEach({ $0.removeFromSuperview() })
        for subview in self.subviews {
            if subview.tag != -1{
                subview.removeFromSuperview()
            }
        }
        
        var tag = 0
        
        var oldCloth = Cloth()
        
        for cloth:Cloth in clothes {    // TODO: Optimise
            
            let currentGender = UserDefaults.standard.string(forKey: "Matchee.currentGender")
            if currentGender == "M" {
                var menClass = ClothesMen()
                let menArray:[clothPiece] = menClass.getMenClothesFromStruct()
                
                for menCloth in menArray{
                    if menCloth.cloth == cloth.name{
                        switch tag {
                        case 0://top
                            currentClothPiecesOfStretchView.sharedInstance.top = menCloth.designer
                            break
                        case 1://shoes
                            currentClothPiecesOfStretchView.sharedInstance.shoes = menCloth.designer
                            break
                        case 2://pants
                            currentClothPiecesOfStretchView.sharedInstance.bottom = menCloth.designer
                            break
                        case 3://belt
                            currentClothPiecesOfStretchView.sharedInstance.belt = menCloth.designer
                            break
                        default:
                            break
                        }
                    }
                }
                
            }else{
                var womenClass = ClothesWomen()
                let womenArray:[clothPiece] = womenClass.getWomenClothesFromStruct()
                
                for womenCloth in womenArray{
                    if womenCloth.cloth == cloth.name{
                        switch tag {
                        case 0://top
                            currentClothPiecesOfStretchView.sharedInstance.top = womenCloth.designer
                            break
                        case 1://shoes
                            currentClothPiecesOfStretchView.sharedInstance.shoes = womenCloth.designer
                            break
                        case 2://pants
                            currentClothPiecesOfStretchView.sharedInstance.bottom = womenCloth.designer
                            break
                        case 3://belt
                            currentClothPiecesOfStretchView.sharedInstance.belt = womenCloth.designer
                            break
                        default:
                            break
                        }
                    }
                }
  
            }
            
            cloth.imageView.tag = tag
            cloth.imageView.isUserInteractionEnabled = true
            let pinchOutGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchedOut(gestureRecognizer:)))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gestureRecognizer:)))
            tapGesture.numberOfTapsRequired = 1
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            cloth.imageView.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            cloth.imageView.addGestureRecognizer(swipeRight)
            
            let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(gestureRecognizer:)))
            longTap.minimumPressDuration = 1.0
            cloth.imageView.addGestureRecognizer(longTap)
            
            
            cloth.imageView.addGestureRecognizer(pinchOutGesture)
            cloth.imageView.addGestureRecognizer(tapGesture)
            cloth.imageView.clipsToBounds = true
            cloth.imageView.backgroundColor = UIColor.clear
            cloth.imageView.isMultipleTouchEnabled = true
            cloth.imageView.contentMode = UIViewContentMode.scaleAspectFit
            cloth.imageView.image = cloth.image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cloth.imageView.image = colorize.processPixels(in: (cloth.imageView.image)!,color:cloth.color)

            self.addSubview(cloth.imageView)
            self.bringSubview(toFront: cloth.imageView)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            cloth.imageView.translatesAutoresizingMaskIntoConstraints = false
            oldCloth.imageView.translatesAutoresizingMaskIntoConstraints = false

           
            let proportionsMen = stretchImagesProportionsMen()
            let proportionsWomen = stretchImagesProportionsWomen()
            
            //Constraints
            switch tag {
                case 0: //shirt
                    if currentGender == "M"{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsMen.topProportion, constant: 0))
                        oldCloth = cloth
                    }else{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsWomen.topProportion, constant: 0))
                        oldCloth = cloth
                    }
                    break
                case 1: //shoes
                    if currentGender == "M"{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant:0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsMen.shoesProportion, constant: 0))
                    }else{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant:0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsWomen.shoesProportion, constant: 0))
                    }
                    break
                        
                case 2: //pants
                    if currentGender == "M"{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: oldCloth.imageView, attribute: .bottom, multiplier: 1.0, constant: -(self.frame.height*0.061)))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsMen.bottomProportion, constant: 0))
                        oldCloth = cloth
                    }else{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: oldCloth.imageView, attribute: .bottom, multiplier: 1.0, constant: -(self.frame.height*0.061)))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsWomen.bottomProportion, constant: 0))
                        oldCloth = cloth
                    }
                    break
                case 3: //belt
                    if currentGender == "M"{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: oldCloth.imageView, attribute: .top, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsMen.beltProportion, constant: 0))
                    }
                    else{
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .top, relatedBy: .equal, toItem: oldCloth.imageView, attribute: .top, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
                        self.addConstraint(NSLayoutConstraint(item: cloth.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: proportionsWomen.beltProportion, constant: 0))
                    }
                    break
                default:
                    break
            }
            
            tag = tag + 1
        }
    }
    
    func initBackgroundView(){
        self.isUserInteractionEnabled = true

        if self.backgroundView.tag != -1 {
            self.backgroundView.tag = -1

            self.backgroundView.isUserInteractionEnabled = true
            self.backgroundView.contentMode = .scaleAspectFit
//            self.backgroundView.image = UIImage(named:"w-model")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//            self.backgroundView.image = colorize.processPixels(in: (self.backgroundView.image)!,color:self.skinColor)
            
            self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        }

    }
    
    public func initBackgroundView(imageName:String){
        self.isUserInteractionEnabled = true

        self.backgroundView.frame = self.frame
        self.backgroundView.transform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
        self.backgroundView.image = UIImage(named:imageName)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.backgroundView.image = colorize.processPixels(in: (self.backgroundView.image)!,color:self.skinColor)

        self.addSubview(self.backgroundView)
        self.sendSubview(toBack: self.backgroundView)
        
        self.addConstraint(NSLayoutConstraint(item: self.backgroundView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.backgroundView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.backgroundView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.backgroundView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        self.backgroundView.layoutIfNeeded()
    }
    
    public func changeBackgroundViewColor(color:UIColor, image:String){
        self.skinColor = color
        self.backgroundView.image = UIImage(named:image)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.backgroundView.image = colorize.processPixels(in: (self.backgroundView.image)!,color:self.skinColor)

//        self.backgroundView.image = UIImage(named:"w-model")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        self.backgroundView.image = colorize.processPixels(in: (self.backgroundView.image)!,color:self.skinColor)
    }
    
    // MARK:  GESTURE RECOGNIZERS   //////////////////////////////////////////////////////////////
    
    func swiped(gesture:UISwipeGestureRecognizer){
    
        var clothesMen:ClothesMen = ClothesMen()
        var clothesWomen:ClothesWomen = ClothesWomen()
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                    print("swiped right on view with tag \(gesture.view!.tag)")
                    
                    let cloth = clothes[gesture.view!.tag]
                    let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
                    var list:[clothPiece] = [clothPiece]()
                    
                    if currentGender == "M" {
                        list = clothesMen.getMenClothesFromStruct()
                    }
                    else{
                        list = clothesWomen.getWomenClothesFromStruct()
                    }

                    switch gesture.view!.tag {
                    case 0:

                        
                        let filteredList = list.filter() {
                            let isTop = $0.drawingOrder == ClothDrawingOrder.top
                            return isTop
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.top {
                                if cloth.name == filteredList[index].cloth {
                                    if (index + 1) <= (filteredList.count - 1) {
                                        cloth.name = filteredList[index+1].cloth
                                        cloth.image = UIImage(named: filteredList[index+1].cloth)!
                                        //assigning current cloth piece to singleton
                                        currentClothPiecesOfStretchView.sharedInstance.top = filteredList[index+1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        //assigning current cloth piece to singleton
                                        currentClothPiecesOfStretchView.sharedInstance.top = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 1:
                        
                        let filteredList = list.filter() {
                            let isPants = $0.drawingOrder == ClothDrawingOrder.shoes
                            return isPants
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.shoes {
                                if cloth.name == filteredList[index].cloth {
                                    if (index + 1) <= (filteredList.count - 1) {
                                        cloth.name = filteredList[index+1].cloth
                                        cloth.image = UIImage(named: filteredList[index+1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.shoes = filteredList[index+1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.shoes = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 2:
                        
                        let filteredList = list.filter() {
                            let isPants = $0.drawingOrder == ClothDrawingOrder.pants
                            return isPants
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.pants {
                                if cloth.name == filteredList[index].cloth {
                                    if (index + 1) <= (filteredList.count - 1) {
                                        cloth.name = filteredList[index+1].cloth
                                        cloth.image = UIImage(named: filteredList[index+1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.bottom = filteredList[index+1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.bottom = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 3:
                        
                        let filteredList = list.filter() {
                            let isBelt = $0.drawingOrder == ClothDrawingOrder.belt
                            return isBelt
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.belt {
                                if cloth.name == filteredList[index].cloth {
                                    if (index + 1) <= (filteredList.count - 1) {
                                        cloth.name = filteredList[index+1].cloth
                                        cloth.image = UIImage(named: filteredList[index+1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.belt = filteredList[index+1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.belt = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break

                    default:
                        break
                    }
                    
                break
            case UISwipeGestureRecognizerDirection.down:
                
                break
            case UISwipeGestureRecognizerDirection.left:
                    print("swiped left on view with tag \(gesture.view!.tag)")
                    let cloth = clothes[gesture.view!.tag]
                    let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
                    var list:[clothPiece] = [clothPiece]()
                    
                    if currentGender == "M" {
                        list = clothesMen.getMenClothesFromStruct()
                    }
                    else{
                        list = clothesWomen.getWomenClothesFromStruct()
                    }
                    
                    switch gesture.view!.tag {
                    case 0:
                        
                        
                        let filteredList = list.filter() {
                            let isTop = $0.drawingOrder == ClothDrawingOrder.top
                            return isTop
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.top {
                                if cloth.name == filteredList[index].cloth {
                                    if (index - 1) >= 0 {
                                        cloth.name = filteredList[index-1].cloth
                                        cloth.image = UIImage(named: filteredList[index-1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.top = filteredList[index-1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.top = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 1:
                        
                        let filteredList = list.filter() {
                            let isPants = $0.drawingOrder == ClothDrawingOrder.shoes
                            return isPants
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.shoes {
                                if cloth.name == filteredList[index].cloth {
                                    if (index - 1) >= 0 {
                                        cloth.name = filteredList[index-1].cloth
                                        cloth.image = UIImage(named: filteredList[index-1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.shoes = filteredList[index-1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }                                else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.shoes = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 2:
                        
                        let filteredList = list.filter() {
                            let isPants = $0.drawingOrder == ClothDrawingOrder.pants
                            return isPants
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.pants {
                                if cloth.name == filteredList[index].cloth {
                                    if (index - 1) >= 0 {
                                        cloth.name = filteredList[index-1].cloth
                                        cloth.image = UIImage(named: filteredList[index-1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.bottom = filteredList[index-1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.bottom = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break
                    case 3:
                        
                        let filteredList = list.filter() {
                            let isBelt = $0.drawingOrder == ClothDrawingOrder.belt
                            return isBelt
                        }
                        
                        for index in 0...filteredList.count-1 {
                            
                            if filteredList[index].drawingOrder == ClothDrawingOrder.pants {
                                if cloth.name == filteredList[index].cloth {
                                    if (index - 1) >= 0 {
                                        cloth.name = filteredList[index-1].cloth
                                        cloth.image = UIImage(named: filteredList[index-1].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.belt = filteredList[index-1].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                    else{
                                        cloth.name = filteredList[0].cloth
                                        cloth.image = UIImage(named: filteredList[0].cloth)!
                                        currentClothPiecesOfStretchView.sharedInstance.belt = filteredList[0].designer
                                        self.setImageViewColor(cloth: cloth, color: cloth.color)
                                        break
                                    }
                                }
                            }
                        }
                        break

                    default:
                        break
                    }
                break
            case UISwipeGestureRecognizerDirection.up:
                
                break
            default:
                break
            }
            
            //Update designer view with designer info
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Notification.updateDesignerView")))
        }

    
    }
    
    func longTap(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            var selectedCloth:Cloth = Cloth()
            
            for clothLocal in clothes{
                
                if clothLocal.imageView.tag == gestureRecognizer.view!.tag{
                    //I pass the selected cloth to the stretchViewController to know what cloth should get the detected color
                    selectedCloth = clothLocal
                    
                    let dataDict:[String: Cloth] = ["clothingElement": selectedCloth ]
                    NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "Notification.presentPicker"), object: nil, userInfo: dataDict))
                }
            }
       }
    }
    


    func pinchedOut(gestureRecognizer:UIPinchGestureRecognizer){

        if gestureRecognizer.state == UIGestureRecognizerState.changed || gestureRecognizer.state == UIGestureRecognizerState.began{
            
            if gestureRecognizer.numberOfTouches > 1 {
                
                let axis = axisFromPoints(p1: gestureRecognizer.location(ofTouch: 0, in: self), gestureRecognizer.location(ofTouch: 1, in: self))
                
                let checkBounds = checkBoundaries(frame1: (gestureRecognizer.view?.frame)!, boundariesMaxLocal: self.boundariesMax, boundariesMinLocal:self.boundariesMin, direction:gestureRecognizer.scale, axis:axis)
                if checkBounds {
                    if axis == Axis.X {
                        self.backgroundView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)
                        print(self.backgroundView.transform)
                        self.clothes[0].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)
                        self.clothes[1].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)
                        self.clothes[2].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)
                        self.clothes[3].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)

                      //  gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: 1)
                        gestureRecognizer.scale = 1;
                    }
                    else{
                       // self.transform =  (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
//                        self.backgroundView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
//                        self.clothes[0].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
//                        self.clothes[1].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
//                        self.clothes[2].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
//                        self.clothes[3].imageView.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
                   //     gestureRecognizer.view?.transform  = (gestureRecognizer.view?.transform)!.scaledBy(x: 1, y: gestureRecognizer.scale)
                        gestureRecognizer.scale = 1;
                    }
                }
                else{
//                    //animate with a small up or down scale
//                    
//                    var delta:CGFloat = 2.0
//                    
//                    if gestureRecognizer.scale < 1.0 {
//                        delta = delta * -1
//                    }
//
//                    UIView.animate(withDuration: 0.1, animations: {
//                        gestureRecognizer.view!.frame.size = CGSize(width: gestureRecognizer.view!.frame.size.width+delta, height: gestureRecognizer.view!.frame.size.height+delta)
//
//                    }, completion: {
//                        (value: Bool) in
//                        UIView.animate(withDuration: 0.1, animations: {
//                            gestureRecognizer.view!.frame.size = CGSize(width: gestureRecognizer.view!.frame.size.width-delta, height: gestureRecognizer.view!.frame.size.height-delta)
//                            
//                        }, completion: {
//                            (value: Bool) in
//                            
//                        })
//                        
//                    })
//                
                }
            }
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.ended{
            lastTouchedPositionPinchOut = CGPoint.zero
        }
        
    }

    func doubleTapped(gestureRecognizer:UITapGestureRecognizer){

        var selectedCloth:Cloth = Cloth()
        
        for clothLocal in clothes{
        
            if clothLocal.imageView.tag == gestureRecognizer.view!.tag{
                
                let delta:CGFloat = 8.0
                
                UIView.animate(withDuration: 0.1, animations: {
                    gestureRecognizer.view!.frame = CGRect(x: gestureRecognizer.view!.frame.origin.x-delta/2, y: gestureRecognizer.view!.frame.origin.y-delta/2, width: gestureRecognizer.view!.frame.size.width+delta, height: gestureRecognizer.view!.frame.size.height+delta)

                }, completion: {
                    (value: Bool) in
                    UIView.animate(withDuration: 0.1, animations: {
                        gestureRecognizer.view!.frame = CGRect(x: gestureRecognizer.view!.frame.origin.x+delta/2, y: gestureRecognizer.view!.frame.origin.y+delta/2, width: gestureRecognizer.view!.frame.size.width-delta, height: gestureRecognizer.view!.frame.size.height-delta)

                    }, completion: {
                        (value: Bool) in
                        selectedCloth = clothLocal
                        let dataDict:[String: Cloth] = ["clothingElement": selectedCloth ]
                        NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "Notification.showBottomMenu"), object: nil, userInfo: dataDict))
                    })
                })
            }
        }
    }
    
    //   UTILITIES   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func checkBoundaries(frame1:CGRect, boundariesMaxLocal:CGRect, boundariesMinLocal:CGRect, direction:CGFloat, axis:Axis) -> Bool{
        
        var heightCheck = false
        var widthCheck = false

        //If we try to shrink
        if direction < 1.0 && direction > 0 {
            //if the width is smaller than the bound
            if axis == Axis.X {
                if (boundariesMaxLocal.width - frame1.width) <= 0 {
                    widthCheck = true
                }
                
                else if(frame1.width - boundariesMinLocal.width) > 0 {
                    widthCheck = true
                }
                
                return widthCheck
            }
            
            if axis == Axis.Y {
                if (boundariesMaxLocal.height - frame1.height) <= 0 {
                    heightCheck = true
                }
                
                else if(frame1.height - boundariesMinLocal.height) > 0 {
                    heightCheck = true
                }
                return heightCheck
            }
            
        }
        
        //If we try to enlarge
        if direction > 1.0 {
            //if the width is smaller than the bound
            if axis == Axis.X {
                if (frame1.width - boundariesMinLocal.width) <= 0 {
                    widthCheck = true
                }
                
                if(boundariesMaxLocal.width - frame1.width) >= 0 {
                    widthCheck = true
                }
                
                return widthCheck
            }
            
            if axis == Axis.Y {
                if (frame1.height - boundariesMinLocal.height) <= 0 {
                    heightCheck = true
                }
                
                if(boundariesMaxLocal.height - frame1.height) >= 0 {
                    heightCheck = true
                }
                return heightCheck
            }
        }
        
        return false
    }
    
    private func axisFromPoints(p1: CGPoint, _ p2: CGPoint) -> Axis {
        let absolutePoint = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
        let radians = atan2(Double(absolutePoint.x), Double(absolutePoint.y))
        
        let absRad = fabs(radians)
        
        if absRad > M_PI_4 && absRad < 3*M_PI_4 {
            return .X
        } else {
            return .Y
        }
    }
    

    
}

extension UIImage {
    
    // colorize image with given tint color
    // this is similar to Photoshop's "Color" layer blend mode
    // this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
    // white will stay white and black will stay black as the lightness of the image is preserved
    func tint(tintColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(self.cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            tintColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    
    
    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func fillAlpha(fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            //            context.fillCGContextFillRect(context, rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    private func modifiedImage( draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    

    

}
