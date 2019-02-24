//
//  Habit.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/24/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation

class Habit {
    let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/habit/")!
    
    var frequency:NSInteger!
    var length:NSInteger!
    var fbhandle:String!
    var geoFenceId:String!

}
