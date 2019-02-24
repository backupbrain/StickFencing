//
//  ProfileViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ProfileViewController: UIViewController {
    @IBOutlet weak var numTimesPerWeekLabel: UILabel!
    @IBOutlet weak var numWeeksLabel: UILabel!
    @IBOutlet weak var changeGoalsButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    var habit:Habit!
    var progress:Progress!
    
    override func viewDidLoad() {
        print("ProfileViewController")
        super.viewDidLoad()
        // get updates
        
        if let accessToken = AccessToken.current {
            self.progress = Progress()
            self.progress.cloudGet(fbhandle: accessToken.authenticationToken)
            self.habit = Habit()
            self.habit.cloudGet(fbhandle: accessToken.authenticationToken)
            self.numTimesPerWeekLabel.text = String(habit.frequency)
            self.numWeeksLabel.text = String(habit.length)
        } else {
            self.loadSplashScreen()
        }
    }
    
    func loadSplashScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        self.present(splashViewController, animated: true, completion: nil)
    }
    
    func loadSetGoalsScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let setGoalViewController = storyBoard.instantiateViewController(withIdentifier: "SetGoalViewController") as! SetGoalViewController
        self.present(setGoalViewController, animated: true, completion: nil)
    }
    
    @IBAction func onChangegoalsButtonTouched(_ sender: Any) {
        self.loadSetGoalsScreen()
    }
    
    @IBAction func onLogOutButtonTouched(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        self.loadSplashScreen()
    }
}

