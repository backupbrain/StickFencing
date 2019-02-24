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
    let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/login/")!
    
    var name:String!
    var email:String!
    var age:String!
    var city:String!
    var fbhandle:String!
    
    init() {
        print("initializing profile")
    }
    
    func toJson() -> [String: Any]? {
        let json: [String: Any] = [
            "name": self.name,
            "email": self.email,
            "age": self.age,
            "city": self.city,
            "fbhandle": self.fbhandle
        ]
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return json
    }
    
    func getJsonHandle() -> [String:  Any]? {
        let json: [String: Any] = [
            "fbhandle": self.fbhandle
        ]
        return json
    }
    
    func stringToJson(jsonText:String) -> [String: Any]? {
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
        /*
        self.name = jsonData["name"]
        self.email = jsonData["email"]
        self.age = jsonData["age"]
        self.fbhandle = jsonData["fbhandle"]
        */
        /*
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        */
    }

    func cloud_delete() {
        let parameters = self.getJsonHandle()
        AF.request(self.url, method: .delete, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    func cloud_get(fbhandle:String) {
        let parameters: [String: String] = [
            "fbhandle": fbhandle
        ]
        //AF.request(self.url, method: .get, parameters: parameters, encoding: URLEncoding.httpBody)
        AF.request(self.url, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                print("got response from server")
                if let data = response.result.value{
                    // Response type-1
                    if  (data as? [[String : AnyObject]]) != nil{
                        print("data_1: \(data)")
                    }
                    // Response type-2
                    if  (data as? [String : AnyObject]) != nil{
                        print("data_2: \(data)")
                    }
                }
        }
        //
        
        
        
        //let url:String = "https://httpbin.org/get"
        let url:String = self.url.absoluteString
        print(url)
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    func cloud_insert() {
        let parameters = self.toJson()
        AF.request(self.url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }
    
    
}
