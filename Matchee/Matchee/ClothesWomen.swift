//
//  ClothesWomen.swift
//  Matchee
//
//  Created by Marco on 21/6/2562 BE.
//  Copyright © 2562 Ememapps. All rights reserved.
//

import Foundation


struct ClothesWomen: StandardCloth {
    
    //Tops
    let shirt:String = "w-shirt"
    let tshirt:String = "w-tshirt"
    let tanktop:String = "w-tanktop"
    let pullover:String = "w-pullover"
    let sarahPullover:String = "w-sarah-pullover"
    
    //Belts
    let noBelt:String = "w-nobelt"
    let belt:String = "w-belt"
    let sarahBelt:String = "w-sarah-belt"
    
    //Pants
    let pants:String = "w-pants"
    let shorts:String = "w-shorts"
    let skirt:String = "w-skirt"
    let sarahSkirt:String = "w-sarah-skirt"
    let novenaSkirt01:String = "w-novena-skirt01"
    let novenaSkirt02:String = "w-novena-skirt02"
    let novenaSkirt03:String = "w-novena-skirt03"
    let novenaLongSkirt01:String = "w-nevena-longskirt01"
    let novenaLongSkirt02:String = "w-nevena-longskirt02"
    let novenaLongSkirt03:String = "w-nevena-longskirt03"
    let novenaPants01:String = "w-nevena-pants01"
    let novenaPants02:String = "w-nevena-pants02"
    let longskirt:String = "w-longskirt"
    
    //Shoes
    let shoes:String = "w-shoes"
    let flatshoes:String = "w-flatshoes"
    let sarahShoes:String = "w-sarah-shoes"
   
    public func getWomenClothesFromStruct() -> [clothPiece] {
        
        var clothesArrayWoman:[clothPiece] = [clothPiece]()
        let designer = Designers()
        
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
