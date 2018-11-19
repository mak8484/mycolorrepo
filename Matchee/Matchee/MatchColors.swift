//
//  MatchColors.swift
//  Matchee
//
//  Created by Marco Mantegazza on 6/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

enum colorMatchingAlgorithms{

    case complementaryColorRGB
    case analoguosRGB
    case splitComplementaryRGB
    case monoChromatic
    case triadic
    case skinWithClothesRGB

}

struct matchingCriterias {
    public var complementaryColorDegrees:CGFloat = 30.0
    public var minimumSaturation:CGFloat = 0.02
    public var monoChromaticHueDifference:CGFloat = 0.02
    public var analogousAngle:CGFloat = 30.0
    public var triadicAngle:CGFloat = 5.0
}


class MatchColors: NSObject {
    
    public var chosenAlgorithm:colorMatchingAlgorithms = colorMatchingAlgorithms.complementaryColorRGB
    
    func matchGlobal(topColor:UIColor, beltColor:UIColor, bottomColor:UIColor, shoesColor:UIColor, skinColor:UIColor)->String{
        
        let criterias = matchingCriterias()
        
        switch chosenAlgorithm {
        case .complementaryColorRGB:
            
            let topHSBA = topColor.hsba()
            let bottomHSBA = bottomColor.hsba()
            let beltHSBA = beltColor.hsba()
            let shoesHSBA = shoesColor.hsba()
            
            var consideredChecks:CGFloat = 0
            var hueCheckResultClothes:CGFloat = 0
            var hueCheckResultTopBelt:CGFloat = 0
            var hueCheckResultTopShoes:CGFloat = 0
            var hueCheckResultBottomBelt:CGFloat = 0
            var hueCheckResultBottomShoes:CGFloat = 0

            if topHSBA.s > criterias.minimumSaturation && bottomHSBA.s > criterias.minimumSaturation {
                hueCheckResultClothes = howComplementaryAreTwoHuesinRGB(color1: topColor, color2: bottomColor)
                consideredChecks += 1
            }
            if topHSBA.s > criterias.minimumSaturation && beltHSBA.s > criterias.minimumSaturation {
                hueCheckResultTopBelt = howComplementaryAreTwoHuesinRGB(color1: topColor, color2: beltColor)
                consideredChecks += 1
            }
            if topHSBA.s > criterias.minimumSaturation && shoesHSBA.s > criterias.minimumSaturation {
                hueCheckResultTopShoes = howComplementaryAreTwoHuesinRGB(color1: topColor, color2: shoesColor)
                consideredChecks += 1
            }
            if bottomHSBA.s > criterias.minimumSaturation && beltHSBA.s > criterias.minimumSaturation {
                hueCheckResultBottomBelt = howComplementaryAreTwoHuesinRGB(color1: bottomColor, color2: beltColor)
                consideredChecks += 1
            }
            if bottomHSBA.s > criterias.minimumSaturation && shoesHSBA.s > criterias.minimumSaturation {
                hueCheckResultBottomShoes = howComplementaryAreTwoHuesinRGB(color1: bottomColor, color2: shoesColor)
                consideredChecks += 1
            }
            
            if consideredChecks == 0{
                consideredChecks = 1
            }
            
            var hueResultComplementary:String = ""

//            print(hueCheckResultClothes + hueCheckResultTopBelt + hueCheckResultTopShoes + hueCheckResultBottomBelt + hueCheckResultBottomShoes)
//            print(criterias.complementaryColorDegrees*consideredChecks)
            
            if (hueCheckResultClothes + hueCheckResultTopBelt + hueCheckResultTopShoes + hueCheckResultBottomBelt + hueCheckResultBottomShoes) < criterias.complementaryColorDegrees*consideredChecks
            {
                hueResultComplementary = NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                hueResultComplementary = NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
            return hueResultComplementary
        case .monoChromatic:
            
            var hueCheckResultClothes:Bool = false
            var hueCheckResultTopBelt:Bool = false
            var hueCheckResultTopShoes:Bool = false
            var hueCheckResultBottomBelt:Bool = false
            var hueCheckResultBottomShoes:Bool = false
            
            hueCheckResultClothes = howSimilarAreTwoHuesInRGB(color1: topColor, color2: bottomColor)
            hueCheckResultTopBelt = howSimilarAreTwoHuesInRGB(color1: topColor, color2: beltColor)
            hueCheckResultTopShoes = howSimilarAreTwoHuesInRGB(color1: topColor, color2: shoesColor)
            hueCheckResultBottomBelt = howSimilarAreTwoHuesInRGB(color1: bottomColor, color2: beltColor)
            hueCheckResultBottomShoes = howSimilarAreTwoHuesInRGB(color1: bottomColor, color2: shoesColor)
            
            if (hueCheckResultClothes && hueCheckResultTopBelt && hueCheckResultTopShoes && hueCheckResultBottomBelt && hueCheckResultBottomShoes) == true {
                return NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                return NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
        case .analoguosRGB:
            
           var hueCheckResultClothes:Bool = false
           var hueCheckResultTopBelt:Bool = false
           var hueCheckResultTopShoes:Bool = false
           var hueCheckResultBottomBelt:Bool = false
           var hueCheckResultBottomShoes:Bool = false
           
           hueCheckResultClothes = isAnalogousAreTwoHuesInRGB(color1: topColor, color2: bottomColor, angle:criterias.analogousAngle)
           hueCheckResultTopBelt = isAnalogousAreTwoHuesInRGB(color1: topColor, color2: beltColor,angle:criterias.analogousAngle)
           hueCheckResultTopShoes = isAnalogousAreTwoHuesInRGB(color1: topColor, color2: shoesColor,angle:criterias.analogousAngle)
           hueCheckResultBottomBelt = isAnalogousAreTwoHuesInRGB(color1: bottomColor, color2: beltColor,angle:criterias.analogousAngle)
           hueCheckResultBottomShoes = isAnalogousAreTwoHuesInRGB(color1: bottomColor, color2: shoesColor,angle:criterias.analogousAngle)
           
           if (hueCheckResultClothes && hueCheckResultTopBelt && hueCheckResultTopShoes && hueCheckResultBottomBelt && hueCheckResultBottomShoes) == true{
            return NSLocalizedString("MatchColors_Match", comment: "")
           }
           else{
            return NSLocalizedString("MatchColors_NoMatch", comment: "")
           }
        case .triadic:
            
            var triadicCheckResultClothes:Bool = false
            var triadicCheckResultTopBelt:Bool = false
            var triadicCheckResultTopShoes:Bool = false
            var triadicCheckResultBottomBelt:Bool = false
            var triadicCheckResultBottomShoes:Bool = false
            
            triadicCheckResultClothes = isTriadicTwoHuesInRGB(color1: topColor, color2: bottomColor)
            triadicCheckResultTopBelt = isTriadicTwoHuesInRGB(color1: topColor, color2: beltColor)
            triadicCheckResultTopShoes = isTriadicTwoHuesInRGB(color1: topColor, color2: shoesColor)
            triadicCheckResultBottomBelt = isTriadicTwoHuesInRGB(color1: bottomColor, color2: beltColor)
            triadicCheckResultBottomShoes = isTriadicTwoHuesInRGB(color1: bottomColor, color2: shoesColor)
            
            if (triadicCheckResultClothes && triadicCheckResultTopBelt && triadicCheckResultTopShoes && triadicCheckResultBottomBelt && triadicCheckResultBottomShoes) == true {
                return NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                return NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
        case .skinWithClothesRGB:
            
            
            
            return "lah"
        default:
            return "Don't know"
        }
       
    }
    
    func matchTopBottom(topColor:UIColor, bottomColor:UIColor)->String{
        
        let criterias = matchingCriterias()
        
        switch chosenAlgorithm {
        case .complementaryColorRGB:
            let hueCheckResult = howComplementaryAreTwoHuesinRGB(color1: topColor, color2: bottomColor)
            var hueResultComplementary:String = ""
            let criterias = matchingCriterias()
            if hueCheckResult < criterias.complementaryColorDegrees {
                hueResultComplementary = NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                let topColorHSBA = topColor.hsba()
                let bottomColorHSBA = bottomColor.hsba()
                
                //If one of the colors is black or very dark -> match
                if topColorHSBA.b < 0.1 || bottomColorHSBA.b < 0.1 {
                    hueResultComplementary = NSLocalizedString("MatchColors_Match", comment: "")
                }
                    //if one of the colors is very bright close to white -> match
                else if topColorHSBA.s < 0.1 && topColorHSBA.b > 0.9 || bottomColorHSBA.s < 0.1 && bottomColorHSBA.b > 0.9 {
                    hueResultComplementary = NSLocalizedString("MatchColors_Match", comment: "")
                }
                else{
                    hueResultComplementary = NSLocalizedString("MatchColors_NoMatch", comment: "")
                }
                
            }
            return hueResultComplementary
        
        case .monoChromatic:
            
            var hueCheckResultClothes:Bool = false
            
            hueCheckResultClothes = howSimilarAreTwoHuesInRGB(color1: topColor, color2: bottomColor)
            
            if (hueCheckResultClothes){
                return NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                return NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
        
        case .analoguosRGB:
            
            var hueCheckResultClothes:Bool = false

            hueCheckResultClothes = isAnalogousAreTwoHuesInRGB(color1: topColor, color2: bottomColor,angle:criterias.analogousAngle)

            
            if hueCheckResultClothes == true{
                return NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                return NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
        case .triadic:
            var triadicCHeckResult:Bool = false
            
            triadicCHeckResult = isTriadicTwoHuesInRGB(color1: topColor, color2: bottomColor)
            
            if triadicCHeckResult == true{
                return NSLocalizedString("MatchColors_Match", comment: "")
            }
            else{
                return NSLocalizedString("MatchColors_NoMatch", comment: "")
            }
            
        case .skinWithClothesRGB:
            
            
            return "lah"
        default:
            return "Don't know"
        }
        
    }

    
    func matchAccessories( beltColor:UIColor, shoesColor:UIColor)->String{
    
        let beltHSBA = beltColor.hsba()
        let shoesHSBA = shoesColor.hsba()
        
        let hueSimilarity = abs(beltHSBA.h * 360.0 - shoesHSBA.h * 360.0)
        let brightnessSimilarity = abs(beltHSBA.b - shoesHSBA.b)
        print(brightnessSimilarity)
        //print(hueSimilarity)
        if hueSimilarity <= 3.0 && brightnessSimilarity < 0.05{
            return NSLocalizedString("MatchColors_Match", comment: "")
        }
        else{
            return NSLocalizedString("MatchColors_NoMatch", comment: "")
        }
    }
    
    //MARK: Color matching methods
    
    
    //Complementary
    func howComplementaryAreTwoHuesinRGB(color1:UIColor, color2:UIColor) -> CGFloat{
        
        let complementaryColor = color1.complementaryColor()
       
        let complementaryColorHSBA = complementaryColor.hsba()
        let secondColorHSBA = color2.hsba()

        
        //If the colors HUE is close in value, the colors are matching. Best is 0, worst is 90
        let hueSimilarity = abs(complementaryColorHSBA.h * 360.0 - secondColorHSBA.h * 360.0)  //The closest to 0 the more similar the color
        
        return hueSimilarity
    
    }
    
    //Monochromatic
    func howSimilarAreTwoHuesInRGB(color1:UIColor, color2:UIColor) -> Bool{
    
        let color1HSBA = color1.hsba()
        let color2HSBA = color2.hsba()
        
        let hueSimilarity = abs(color1HSBA.h  - color2HSBA.h )
        
        if hueSimilarity <= matchingCriterias().monoChromaticHueDifference {
            return true
        }
        
        if color2HSBA.s <= matchingCriterias().minimumSaturation || color1HSBA.s <= matchingCriterias().minimumSaturation{
            return true
        }else{
            return false
        }
    }
    
    
    //Analogous
    func isAnalogousAreTwoHuesInRGB(color1:UIColor, color2:UIColor, angle:CGFloat) -> Bool{
        
        //let analogousColors = self.getAnalogousColors(color1: color1, angle:angle)
        let analogArray = color1.colorScheme(type: .Analagous)

        let colorMinus:UIColor = analogArray[3]
        let colorPlus:UIColor = analogArray[0]
        
        let colorMinusH = colorMinus.hsba().h
        let colorPlusH = colorPlus.hsba().h
        
        let color2HSBA = color2.hsba()
        
        let Color1HSBA = color1.hsba()
        
        if Color1HSBA.s <= 0.05 {
            return true
        }
        
        if colorMinusH < colorPlusH {
            if color2HSBA.h >= colorMinusH && color2HSBA.h <= colorPlusH{
                return true
            }
            else{
                //If the colors has no saturation it is in theory always matching
                if color2HSBA.s <= 0.05 {
                    return true
                }else{
                    return false
                }
            }
        }
        else{
            if color2HSBA.h >= (-1 + colorMinusH) && color2HSBA.h <= colorPlusH{
                return true
            }
            else{
                if color2HSBA.s <= 0.05 {
                    return true
                }else{
                    return false
                }
            }
        }

    }
    
    //Triadic
    func isTriadicTwoHuesInRGB(color1:UIColor, color2:UIColor) -> Bool{
        
        //Get the two triadic colors of color1
        let criterias = matchingCriterias()
        let color1HSBA = color1.hsba()
        
        if color1HSBA.s >= 0.01 && color1HSBA.b >= 0.01{
        
            let triadicArray = color1.colorScheme(type: .Triad)
            let triadColor1 = triadicArray[1]
            let triadColor2 = triadicArray[2]
            
            //check if color2 is near to the two triadic colors
            let check21 = self.isAnalogousAreTwoHuesInRGB(color1: color2, color2: triadColor1, angle: criterias.triadicAngle)
            let check22 = self.isAnalogousAreTwoHuesInRGB(color1: color2, color2: triadColor2, angle: criterias.triadicAngle)
            
            if check21 || check22 {
                return true
            }
            else
            {
                return false
            }
            
        }
        //if black or white it is always matching
        return true
    }
    
    
    func getAnalogousColors(color1:UIColor, angle:CGFloat) -> [UIColor]{
    
       // let angle:CGFloat = 30.0/360.0
        
        var colorMinusAngle:UIColor = UIColor()
        var colorPlusAngle:UIColor = UIColor()
        
        let color1H = color1.hsba().h
        
        var colorMinusH:CGFloat = 0
        if color1H - angle > 0 {
           colorMinusH = color1H - angle
        }
        else{
            colorMinusH = 1 + ( color1H - angle )
        }
        
        var colorPlusH:CGFloat = 0
        if color1H + angle < 1 {
            colorPlusH = color1H + angle
        }
        else{
            colorPlusH = 1 - (color1H + angle)
        }
        
        print(color1H,colorMinusH,colorPlusH)
        
        colorMinusAngle = UIColor(hsba: (h: colorMinusH, s: color1.hsba().s, b: color1.hsba().b, a: color1.hsba().a))
        colorPlusAngle = UIColor(hsba: (h: colorPlusH, s: color1.hsba().s, b: color1.hsba().b, a: color1.hsba().a))

        return [colorMinusAngle,colorPlusAngle]
    }

    func rybColor(red:CGFloat, yellow:CGFloat, blue:CGFloat, alpha: CGFloat)->UIColor{
    
        var r = red
        var y = yellow
        var b = blue
        
        //remove whiteness
        let w = min(r, min(y, b))
        r -= w
        y -= w
        b -= w
    
        let my = max(r, max(y, b))
        
        //Get the green out of yellow and blue
        var g = min(y, b)
        y -= g
        b -= g
        
        if (b != 0 && g != 0) {
            b *= 2.0
            g *= 2.0
        }
        //Redistribute the remaining yellow.
        r += y
        g += y
    
        // Normalize to values.
        let mg = max(r, max(g, b))
        if mg != 0 {
            let n = my / mg
            r *= n
            g *= n
            b *= n
        }
        
        // Add the white back in.
        r += w
        g += w
        b += w

        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    
    }
    
//    + (UIColor*)rybColorWithRed:(CGFloat)red yellow:(CGFloat)yellow blue:(CGFloat)blue alpha:(CGFloat)alpha {
//    
//    float r, y, b, g, w, my, mg, n;
//    r = red;
//    y = yellow;
//    b = blue;
//    
//    // remove whiteness
//    w = MIN(r, MIN(y,b));
//    r -= w;
//    y -= w;
//    b -= w;
//    
//    my = MAX(r, MAX(y,b));
//    
//    // Get the green out of the yellow and blue
//    g = MIN(y, b);
//    y -= g;
//    b -= g;
//    
//    if (b && g) {
//    b *= 2.0;
//    g *= 2.0;
//    }
//    
//    // Redistribute the remaining yellow.
//    r += y;
//    g += y;
//    
//    // Normalize to values.
//    mg = MAX(r, MAX(g, b));
//    if (mg) {
//    n = my / mg;
//    r *= n;
//    g *= n;
//    b *= n;
//    }
//    
//    // Add the white back in.
//    r += w;
//    g += w;
//    b += w;
//    
//    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
//    }
    
    
}