//
//  Person.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation


class Person {
    var hairLength:NSInteger!
    var age:NSInteger!
    var name:String!
    let eyeColor:String!
    
    func takeAShit(foodType:String) -> String {
        var poopColor:String!
        if (foodType == "vegetables") {
            poopColor = "brown"
        } else if (foodType == "leafy greens") {
            poopColor = "black"
        } else {
            poopColor = "green"
        }
        return poopColor
    }
    
    func eatFood(appetizer:String, meal:String, dessert:String) {
        
    }
}

poopColor = person.takeAShit("vegetables")
