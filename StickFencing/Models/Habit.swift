//
//  Habit.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/24/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import Alamofire

class Habit {
    let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/habit/")!
    //let url = URL(string: "https://httpbin.org/post")!
    
    var frequency:NSInteger!
    var length:NSInteger!
    var fbhandle:String!
    var geoFenceId:String!
    
    func toJson() -> [String: Any?] {
        let json: [String: Any?] = [
            "frequency": self.frequency,
            "length": self.length,
            "fbhandle": self.fbhandle,
            "geoFenceId": self.geoFenceId
        ]
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return json as [String: Any]
    }
    
    func fromJson(json: [String: Any]) {
        self.frequency = json["frequency"] as? NSInteger
        self.length = json["length"] as? NSInteger
        self.fbhandle = json["fbhandle"] as? String
        self.geoFenceId = json["geoFenceId"] as? String
    }
    
    func getJsonHandle() -> [String: Any]? {
        let json: [String: String?] = [
            "fbhandle": self.fbhandle
        ]
        return json as [String: Any]
    }
    
    func cloudDelete() {
        let parameters = self.getJsonHandle()
        AF.request(
            self.url.absoluteString,
            method: .delete,
            parameters: parameters,
            encoding: JSONEncoding.default
        )
    }
    
    func cloudGet(fbhandle:String) {
        let parameters = ["fbhandle": fbhandle] as [String: Any]
        AF.request(self.url.absoluteString, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                let j = json as! [String: Any]
                let p = j["json"] as! [String: Any]
                self.fromJson(json: p)
            }
        }
    }
    
    func cloudInsert() {
        let parameters = self.toJson()
        AF.request(self.url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
}
