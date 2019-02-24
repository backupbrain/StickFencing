//
//  ApiHandler.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/24/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation

class ApiHandler {
    
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
    
    func request(url: String, method: String, parameters: [String: Any]) -> String {
        let headers = [
            "x-auth-params-email": "tester@tester",
            "x-auth-params-groups": "michelangelo",
            "Content-Type": "application/json",
            "cache-control": "no-cache",
            "Postman-Token": "c92d1d65-aaff-4a25-981a-bd0768d1a239"
        ]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as! Data
        
        var result = ""
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
                //result = ""
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                //result = httpResponse
            }
        })
        
        dataTask.resume()
        return result
    }
}



