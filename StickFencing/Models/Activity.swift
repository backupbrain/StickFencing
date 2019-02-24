//
//  Habit.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/24/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import Alamofire

class Activity {
    //let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/activity/")!
    let url = URL(string: "https://httpbin.org/post")!
    
    var fbhandle:String!
    var lat:Float!
    var long:Float!
    
    func toJson() -> [String: Any?] {
        let json: [String: Any?] = [
            "fbhandle": self.fbhandle,
            "lat": self.lat,
            "long": self.long
        ]
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return json
    }
    
    func cloudInsert() {
        let parameters = self.toJson()
        AF.request(self.url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
}
