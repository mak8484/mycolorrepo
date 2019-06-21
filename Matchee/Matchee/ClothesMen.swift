//
//  ClothesMen.swift
//  Matchee
//
//  Created by Marco on 21/6/2562 BE.
//  Copyright © 2562 Ememapps. All rights reserved.
//

import Foundation


struct ClothesMen: StandardCloth {
    
    //Tops
    let shirt:String = "m-shirt"
    let tshirt:String = "m-tshirt"
    let editaTshirt:String = "m-edita-tshirt"
    let tanktop:String = "m-tanktop"
    let pullover:String = "m-pullover"
    let sarahPullover:String = "m-sarah-pullover"
    let jacket:String = "m-jacket"
    
    //Belts
    let belt:String = "m-belt"
    let sarahBelt:String = "m-sarah-belt"
    let editaBelt:String = "m-edita-belt"
    
    //Pants
    let pants:String = "m-pants"
    let sarahPants:String = "m-sarah-pants"
    let editaPants:String = "m-edita-pants"
    let shorts:String = "m-shorts"
    
    //Shoes
    let shoes:String = "m-shoes"
    let sarahShoes:String = "m-sarah-shoes"
    let editaShoes:String = "m-edita-shoes"
    
    public func getMenClothesFromStruct() -> [clothPiece] {
        
        let designer = Designers()
        var clothesArrayMan:[clothPiece] = [clothPiece]()
        
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
