//
//  SetGoalViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import FacebookCore

class SetGoalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
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
    
    let gymGeofenceNames = [
        "Equinox": "48fc0182-bf28-40a3-9e4a-150e2d0dca2a",
        "Mission Cliffs": "f554237d-599a-49b4-9f09-8a7e4b61ba34",
        "24 Hour Fitness": "4bfa67da-f3bf-47f1-803b-4ca0a7c0c14b"
    ]
    var gymNamePickerData: [String] = [String]()
    
    override func viewDidLoad() {
        print("SetGoalViewController")
        super.viewDidLoad()
        
        for (gymName, _) in self.gymGeofenceNames {
            self.gymNamePickerData.append(gymName)
        }
        self.gymPicker.delegate = self
        self.gymPicker.dataSource = self
        
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
            var selectedRowIndex = 0
            if (habit.geoFenceId != nil) {
                var row = 0
                for (_, geofenceId) in self.gymGeofenceNames {
                    if habit.geoFenceId == geofenceId {
                        selectedRowIndex = row
                        break
                    }
                    row = row + 1
                }
            }
            self.gymPicker.selectRow(selectedRowIndex, inComponent: 0, animated: false)
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
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.gymNamePickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.gymNamePickerData[row]
    }
}

