//
//  nutriontionInformation.swift
//  healt
//
//  Created by Hriday Chhabria on 1/4/20.
//  Copyright © 2020 Hriday Chhabria. All rights reserved.
//

import Foundation
import UIKit

class foodItem{
    
    
    
    var carbohydrates = 0
    var poroetins = 0
    var fats = 0
    var addedSugars = 0
    var saturatedFats = 0
    var transFats = 0
    var sodidum = 0
    
    init(name: String) {
        switch name {
        case "apple_pie":
            carbohydrates = 1
            poroetins = 1
            fats = 1
            addedSugars = 121
            saturatedFats = 0
            transFats = 1
            sodidum = 1000
        default:
            carbohydrates = 0
            poroetins = 0
            fats = 0
            addedSugars = 0
            saturatedFats = 0
            transFats = 0
            sodidum = 121
        }
    }
    
}
