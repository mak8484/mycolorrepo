//
//  cloth.swift
//  Tinder like drag
//
//  Created by Marco Mantegazza on 3/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit
import CoreData

public enum ClothDrawingOrder:Int16{
    case top
    case shoes
    case pants
    case belt
}

struct Designer{
    var matchee:NSArray = ["Matchee","http://www.ememapps.com/matchee.html",""]
    var sarah:NSArray = ["Sarah\nMaffeis","https://www.instagram.com/sarahmaffeis/","sarahmaffeis"]
    var nevena:NSArray = ["Nevena\nZizovic","https://www.instagram.com/sphynx_design","sphynx_design"]
    var edita:NSArray = ["Edita\nMauraite","https://www.instagram.com/edita.mauraite/","edita.mauraite"]
}


struct clothPiece {
    var cloth:String
    var drawingOrder:ClothDrawingOrder
    var designer:NSArray
}

struct ClothesMen {
    //Top
    var shirt:String = "m-shirt"
    var tshirt:String = "m-tshirt"
    var editaTshirt:String = "m-edita-tshirt"
    var tanktop:String = "m-tanktop"
    var pullover:String = "m-pullover"
    var sarahPullover:String = "m-sarah-pullover"
    var jacket:String = "m-jacket"
    
    //Belts
    var belt:String = "m-belt"
    var sarahBelt:String = "m-sarah-belt"
    var editaBelt:String = "m-edita-belt"
    
    //Pants
    var pants:String = "m-pants"
    var sarahPants:String = "m-sarah-pants"
    var editaPants:String = "m-edita-pants"
    var shorts:String = "m-shorts"
    
    //Shoes
    var shoes:String = "m-shoes"
    var sarahShoes:String = "m-sarah-shoes"
    var editaShoes:String = "m-edita-shoes"
    
    var clothesArrayMan:[clothPiece] = [clothPiece]()
    
    let designer = Designer()
    
    public mutating func getMenClothesFromStruct() -> [clothPiece] {
        
        clothesArrayMan.append(clothPiece(cloth: shirt, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: tshirt, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: editaTshirt, drawingOrder: ClothDrawingOrder.top, designer:designer.edita))
        clothesArrayMan.append(clothPiece(cloth: tanktop, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: jacket, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: pullover, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: sarahPullover, drawingOrder: ClothDrawingOrder.top, designer:designer.sarah))
        clothesArrayMan.append(clothPiece(cloth: belt, drawingOrder: ClothDrawingOrder.belt, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: sarahBelt, drawingOrder: ClothDrawingOrder.belt, designer:designer.sarah))
        clothesArrayMan.append(clothPiece(cloth: editaBelt, drawingOrder: ClothDrawingOrder.belt, designer:designer.edita))
        clothesArrayMan.append(clothPiece(cloth: pants, drawingOrder: ClothDrawingOrder.pants, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: shorts, drawingOrder: ClothDrawingOrder.pants, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: sarahPants, drawingOrder: ClothDrawingOrder.pants, designer:designer.sarah))
        clothesArrayMan.append(clothPiece(cloth: editaPants, drawingOrder: ClothDrawingOrder.pants, designer:designer.edita))
        clothesArrayMan.append(clothPiece(cloth: shoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.matchee))
        clothesArrayMan.append(clothPiece(cloth: sarahShoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.sarah))
        clothesArrayMan.append(clothPiece(cloth: editaShoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.edita))


        return clothesArrayMan
    }
    
}

struct ClothesWomen {
    //Top
    var shirt:String = "w-shirt"
    var tshirt:String = "w-tshirt"
    var tanktop:String = "w-tanktop"
    var pullover:String = "w-pullover"
    var sarahPullover:String = "w-sarah-pullover"
    
    //Belts
    var noBelt:String = "w-nobelt"
    var belt:String = "w-belt"
    var sarahBelt:String = "w-sarah-belt"
    
    //Pants
    var pants:String = "w-pants"
    var shorts:String = "w-shorts"
    var skirt:String = "w-skirt"
    var sarahSkirt:String = "w-sarah-skirt"
    var novenaSkirt01:String = "w-novena-skirt01"
    var novenaSkirt02:String = "w-novena-skirt02"
    var novenaSkirt03:String = "w-novena-skirt03"
    var novenaLongSkirt01:String = "w-nevena-longskirt01"
    var novenaLongSkirt02:String = "w-nevena-longskirt02"
    var novenaLongSkirt03:String = "w-nevena-longskirt03"
    var novenaPants01:String = "w-nevena-pants01"
    var novenaPants02:String = "w-nevena-pants02"
    var longskirt:String = "w-longskirt"
    
    
    //Shoes
    var shoes:String = "w-shoes"
    var flatshoes:String = "w-flatshoes"
    var sarahShoes:String = "w-sarah-shoes"
    
    var clothesArrayWoman:[clothPiece] = [clothPiece]()
    let designer = Designer()
    public mutating func getWomenClothesFromStruct() -> [clothPiece] {
        
        clothesArrayWoman.append(clothPiece(cloth: shirt, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: tshirt, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: tanktop, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: pullover, drawingOrder: ClothDrawingOrder.top, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: sarahPullover, drawingOrder: ClothDrawingOrder.top, designer:designer.sarah))
        clothesArrayWoman.append(clothPiece(cloth: belt, drawingOrder: ClothDrawingOrder.belt, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: sarahBelt, drawingOrder: ClothDrawingOrder.belt, designer:designer.sarah))
        clothesArrayWoman.append(clothPiece(cloth: noBelt, drawingOrder: ClothDrawingOrder.belt, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: pants, drawingOrder: ClothDrawingOrder.pants, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: skirt, drawingOrder: ClothDrawingOrder.pants, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: sarahSkirt, drawingOrder: ClothDrawingOrder.pants, designer:designer.sarah))
        clothesArrayWoman.append(clothPiece(cloth: novenaSkirt01, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaSkirt02, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaSkirt03, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaLongSkirt01, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaLongSkirt02, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaLongSkirt03, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaPants01, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: novenaPants02, drawingOrder: ClothDrawingOrder.pants, designer:designer.nevena))
        clothesArrayWoman.append(clothPiece(cloth: longskirt, drawingOrder: ClothDrawingOrder.pants, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: shoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: flatshoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.matchee))
        clothesArrayWoman.append(clothPiece(cloth: sarahShoes, drawingOrder: ClothDrawingOrder.shoes, designer:designer.sarah))
        
        return clothesArrayWoman
    }
    
}


//Class that declares objects Cloth for UI related matters
class Cloth {
    
    public var imageView:UIImageView = UIImageView()
    public var image:UIImage = UIImage()
    public var color:UIColor = UIColor(red: 213/255.0, green: 179/255.0, blue: 151/255.0, alpha: 1.0)
    public var name:String = ""
    public var gender:Int = 0  // 0 = male 1 = female
    public var drawingOrder:ClothDrawingOrder = ClothDrawingOrder.top


    func getStandardClothesSetForUI()->[Cloth]{
        
        let shirt:Cloth = Cloth()
        let belt:Cloth = Cloth()
        let pants:Cloth = Cloth()
        let shoes:Cloth = Cloth()
        
        var array:[Cloth] = [Cloth]()
        var gender = 0
        
        let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
        if currentGender == "W"{
            gender = 1
            let clothes = ClothesWomen()
            //add shirt
            shirt.imageView = UIImageView()
            shirt.image = UIImage(named: clothes.shirt)!
            shirt.name = clothes.shirt
            shirt.drawingOrder = ClothDrawingOrder.top
            shirt.gender = gender
            
            array.append(shirt)
            
            //add shoes
            shoes.imageView = UIImageView()
            shoes.image = UIImage(named: clothes.shoes)!
            shoes.name = clothes.shoes
            shoes.color = UIColor.white
            shoes.drawingOrder = ClothDrawingOrder.shoes
            shoes.gender = gender
            
            array.append(shoes)
            
            //add pants
            pants.imageView = UIImageView()
            pants.image = UIImage(named: clothes.pants)!
            pants.name = clothes.pants
            pants.drawingOrder = ClothDrawingOrder.pants
            pants.gender = gender
            
            array.append(pants)
            
            //add belt
            belt.imageView = UIImageView()
            belt.image = UIImage(named: clothes.belt)!
            belt.name = clothes.belt
            belt.color = UIColor.white
            belt.drawingOrder = ClothDrawingOrder.belt
            belt.gender = gender
            
            array.append(belt)

        }
        else{
            let clothes = ClothesMen()
            //add shirt
            shirt.imageView = UIImageView()
            shirt.image = UIImage(named: clothes.shirt)!
            shirt.name = clothes.shirt
            shirt.drawingOrder = ClothDrawingOrder.top
            shirt.gender = gender
            
            array.append(shirt)
            
            //add shoes
            shoes.imageView = UIImageView()
            shoes.image = UIImage(named: clothes.shoes)!
            shoes.name = clothes.shoes
            shoes.color = UIColor.white
            shoes.drawingOrder = ClothDrawingOrder.shoes
            shoes.gender = gender
            
            array.append(shoes)
            
            //add pants
            pants.imageView = UIImageView()
            pants.image = UIImage(named: clothes.pants)!
            pants.name = clothes.pants
            pants.drawingOrder = ClothDrawingOrder.pants
            pants.gender = gender
            
            array.append(pants)
            
            //add belt
            belt.imageView = UIImageView()
            belt.image = UIImage(named: clothes.belt)!
            belt.name = clothes.belt
            belt.color = UIColor.white
            belt.drawingOrder = ClothDrawingOrder.belt
            belt.gender = gender
            
            array.append(belt)
        }
        
        return array
    
    }
    
    func getClothesObjectsForUI(clothesFromStorage:[Clothes])->[Cloth]{
        
        var clothesForUI:[Cloth] = [Cloth]()
        
        for cloth in clothesFromStorage {
            
            let clothUI:Cloth = Cloth()
            clothUI.color = NSKeyedUnarchiver.unarchiveObject(with: cloth.color as! Data) as! (UIColor)
            clothUI.gender = Int(cloth.gender)
            clothUI.image = UIImage(named: cloth.imageName!)!
            clothUI.imageView = UIImageView()
            clothUI.name = cloth.name!
            clothUI.drawingOrder = ClothDrawingOrder(rawValue: cloth.drawingOrder)!
            clothesForUI.append(clothUI)
            
        }
        
        //Sort array by drawing order
    
        let sortedArray =  clothesForUI.sorted {
            $0.drawingOrder.rawValue < $1.drawingOrder.rawValue
        }
        
        return sortedArray
        
    }

    
}


