//
//  SplashViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var jsonTestButton: UIButton!
    
    override func viewDidLoad() {
        print("SplashViewController")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onFacebookLaginButtonTouched(_ sender: Any) {
        print("Facebook button")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let overviewViewController = storyBoard.instantiateViewController(withIdentifier: "overviewViewController") as! NewViewController
        self.present(overviewViewController, animated: true, completion: nil)
    }
    
    @IBAction func onJsonTestButtonTouched(_ sender: Any) {
        let json: [String: Any] = [
            "title": "ABC",
            "dict": ["1":"First", "2":"Second"]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "http://httpbin.org/post")!
        var request = URLRequest(url: url)
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
    }
    
}

