//
//  Profile.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import Alamofire

class Profile {
    //let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/login/")!
    let url = URL(string: "https://httpbin.org/post")!
    
    var name:String?
    var email:String?
    var age:String?
    var city:String?
    var fbhandle:String?
    
    init() {
        print("initializing profile")
    }
    
    func toJson() -> [String: Any]? {
        let json: [String: String?] = [
            "name": self.name,
            "email": self.email,
            "age": self.age,
            "city": self.city,
            "fbhandle": self.fbhandle
        ]
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return json as [String: Any]
    }
    
    func fromJson(json: [String: Any]) {
        self.name = json["name"] as? String
        self.email = json["email"] as? String
        self.age = json["age"] as? String
        self.city = json["city"] as? String
        self.fbhandle = json["fbhandle"] as? String
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
