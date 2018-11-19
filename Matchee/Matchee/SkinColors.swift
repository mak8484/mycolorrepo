//
//  SkinColors.swift
//  Matchee
//
//  Created by Marco Mantegazza on 11/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit

struct SkinColors {

    var caucasian:UIColor = UIColor(red: 255/255.0, green: 219/255.0, blue: 172/255.0, alpha: 1.0)
    var asian:UIColor = UIColor(red: 241/255.0, green: 194/255.0, blue: 125/255.0, alpha: 1.0)
    var soutEastAsian:UIColor = UIColor(red: 224/255.0, green: 172/255.0, blue: 105/255.0, alpha: 1.0)
    var latin:UIColor = UIColor(red: 198/255.0, green: 134/255.0, blue: 66/255.0, alpha: 1.0)
    var northAfrican:UIColor = UIColor(red: 141/255.0, green: 85/255.0, blue: 36/255.0, alpha: 1.0)
    var centralAfrican:UIColor = UIColor(red: 68/255.0, green: 38/255.0, blue: 28/255.0, alpha: 1.0)

    public mutating func getSkinColorArray() -> [UIColor] {
        let skinArray = [caucasian,asian,soutEastAsian,latin,northAfrican,centralAfrican]
        return skinArray
    }
}
