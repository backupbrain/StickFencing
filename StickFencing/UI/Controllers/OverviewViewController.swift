//
//  OverviewViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import FacebookCore

class OverviewViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        print("OverviewViewController")
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
        } else {
            self.loadSplashScreen()
        }
    }
    
    @IBAction func onNextButtonTouched(_ sender: Any) {
        userDefaults.set(true, forKey: "Test.StickFencing.wasIntroScreenSeen")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let setGoalViewController = storyBoard.instantiateViewController(withIdentifier: "SetGoalViewController") as! SetGoalViewController
        self.present(setGoalViewController, animated: true, completion: nil)
    }
    
    func loadSplashScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        self.present(splashViewController, animated: true, completion: nil)
    }
}

