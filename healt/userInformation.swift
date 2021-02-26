//
//  userInformation.swift
//  healt
//
//  Created by Hriday Chhabria on 12/25/19.
//  Copyright © 2019 Hriday Chhabria. All rights reserved.
//

import Foundation
import UIKit

var firstName = ""
var lastName = ""
var lifeStyle = ""

class userInfo{
    
    
    
    static func setInformation(name: String, lastNameA: String, lyf: String)
    {
        firstName = name
        lastName = lastNameA
        lifeStyle = lyf
        
    }
    static func getFirstName() -> String
    {
        return firstName
    }
    
    static func getLastName() -> String
    {
        return lastName
    }
    
}
