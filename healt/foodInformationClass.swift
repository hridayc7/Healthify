//
//  foodInformationClass.swift
//  healt
//
//  Created by Hriday Chhabria on 2/20/20.
//  Copyright © 2020 Hriday Chhabria. All rights reserved.
//

import Foundation
import UIKit

public class FOODDATA
{
    static var food = ""
    static var carbohydrates = 0;
    static var lastPaageWasML: Bool = false;
    
    
    static func getFoodItem() -> String
    {
        return self.food
    }
    
    static func setFoodItem(foo: String)
    {
        self.food = foo
    }
    
    static func getCabrs() -> Int
    {
        switch self.food {
        case "pizza":
            return 36
        default:
            return 0
        }
    }
    
    static func getProteins() -> Int
    {
        switch self.food {
            case "pizza":
                return 12
            default:
                return 0
        }
        
    }
    
    static func getFats() -> Int
    {
        switch self.food {
        case "pizza":
            return 10
        default:
            return 0
        }
        
    }
    
    static func getAddedSugars() -> Int
    {
        switch self.food {
        case "pizza":
            return 5
        default:
            return 90
        }
        
    }
    
    static func getSatFats() -> Int
    {
        switch self.food {
        case "pizza":
            return 5
        default:
            return 90
        }
        
    }
    
    static func getTransFats() -> Int
    {
        switch self.food {
        case "pizza":
            return 1
        default:
            return 90
        }
        
    }
    
    static func getSodium() -> Double
    {
        switch self.food {
        case "pizza":
            return 640
        default:
            return 90
        }
        
    }
}
