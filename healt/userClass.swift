//
//  userClass.swift
//  healt
//
//  Created by Hriday Chhabria on 12/25/19.
//  Copyright © 2019 Hriday Chhabria. All rights reserved.
//

import Foundation
import UIKit

class Person{
    var firstName = ""
    var lastName = ""
    var lifeStyle = ""
    
    init(_ first: String, _ last: String, _ style: String) {
        self.firstName = first
        self.lastName = last
        self.lifeStyle = style
    }
    
}
