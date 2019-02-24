//
//  SetGoalViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import FacebookCore

class SetGoalViewController: UIViewController {
    @IBOutlet weak var numGymVisitsInput: UITextField!
    @IBOutlet weak var numWeekCommitmentInput: UITextField!
    @IBOutlet weak var textMessageInput: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var gymPicker: UIPickerView!
    @IBOutlet weak var messageTypeToggle: UISegmentedControl!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var habit:Habit!
    let messageType_text = "text"
    let messageType_facebook = "facebook"
    
    let gymGeofenceIds  = [
        ["displayValue":"--Select--" as AnyObject,"id":"" as AnyObject],
        ["displayValue":"Jame" as AnyObject,"id":"100" as AnyObject],
        ["displayValue":"Enamul" as AnyObject,"id":"201" as AnyObject]
    ]
    
    override func viewDidLoad() {
        print("SetGoalViewController")
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            // attemp to delete any habits that already exist
            self.habit = Habit()
            self.habit.fbhandle = accessToken.authenticationToken
            if (habit.frequency != nil) {
                self.numGymVisitsInput.text = String(habit.frequency)
            }
            if (habit.length != nil) {
                self.numWeekCommitmentInput.text = String(habit.length)
            }
            if (habit.geoFenceId != nil) {
                self.gymPicker.selectRow(row, inComponent: 0, animated: true)
            }
            let textMessage = userDefaults.string(forKey: "Test.StickFencing.textMessage") as String?
            if (textMessage != nil) {
                self.textMessageInput.text = textMessage
            }
            let messageType = userDefaults.string(forKey: "Test.StickFencing.messageType") as String?
            if (messageType == self.messageType_text) {
                self.messageTypeToggle.selectedSegmentIndex = 0
            } else if (messageType == self.messageType_facebook) {
                self.messageTypeToggle.selectedSegmentIndex = 1
            }
            /*
            @IBOutlet weak var mPicker: UIPickerView!
            var items: [String] = ["NoName1","NoName2","NoName3"] // Set through another ViewController
            var itemAtDefaultPosition: String?  //Set through another ViewController
            
            //..
            //..
            
            var defaultRowIndex = find(items,itemAtDefaultPosition!)
            if(defaultRowIndex == nil) { defaultRowIndex = 0 }
            mPicker.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
            */
        } else {
            self.loadSplashScreen()
        }
    }
    
    @IBAction func onNextButtonTouched(_ sender: Any) {
        self.habit.cloudDelete()
        self.habit.frequency = NSInteger(self.numGymVisitsInput.text!)
        self.habit.length = NSInteger(self.numGymVisitsInput.text!)
        //self.habit.geoFenceId = self.gymPicker.selectedRow(inComponent: <#T##Int#>)
        self.habit.fbhandle = AccessToken.current!.authenticationToken
        self.habit.cloudInsert()
        
        userDefaults.set(true, forKey: "Test.StickFencing.wereGoalsSet")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    
    func loadSplashScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        self.present(splashViewController, animated: true, completion: nil)
    }
    
    @IBAction func onMessageTypeSegmentChanged(_ sender: Any) {
        if (self.messageTypeToggle.selectedSegmentIndex == 0) {
            userDefaults.set(self.messageType_text, forKey: "Test.StickFencing.messageType")
        } else {
            userDefaults.set(self.messageType_facebook, forKey: "Test.StickFencing.messageType")
        }
    }
}

