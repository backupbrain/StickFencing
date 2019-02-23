//
//  Profile.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation

class Profile {
    var name:String!
    var email:String!
    var age:String!
    var city:String!
    var fbhandle:String!
    
    func toJson() -> [Data: Any] {
        let json: [String: Any] = [
            "name": self.name,
            "email": self.email,
            "age": self.age,
            "city": self.city,
            "fbhandle": self.fbhandle
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return jsonData
    }
    
    func stringToJson(jsonText:String) {
        if let data = jsonText.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func fromJson(jsonText:String) {
        let jsonData = self.stringToJson(jsonText: jsonText)
        
    }
}
