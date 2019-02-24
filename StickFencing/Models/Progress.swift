//
//  Progress.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/24/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import Alamofire

class Progress {
    let url = URL(string: "http://stick.mizcmyrprw.us-west-2.elasticbeanstalk.com/progress/")!
    //let url = URL(string: "https://httpbin.org/post")!
    
    var dates:[String]!

    func fromJson(json: [String: [String]]) {
        self.dates = json["dates"]
    }
    
    func cloudGet(fbhandle:String) {
        let parameters = ["fbhandle": fbhandle] as [String: Any]
        AF.request(self.url.absoluteString, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                let j = json as! [String: Any]
                let p = j["json"] as! [String: [String]]
                self.fromJson(json: p)
            }
        }
    }
}
