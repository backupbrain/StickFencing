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
import CoreLocation

/*
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
 */


class ProfileViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var numTimesPerWeekLabel: UILabel!
    @IBOutlet weak var numWeeksLabel: UILabel!
    @IBOutlet weak var changeGoalsButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var messageTypeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var habit:Habit!
    var progress:Progress!
    
    let gymGeofenceNames = [
        "Equinox": "48fc0182-bf28-40a3-9e4a-150e2d0dca2a",
        "Mission Cliffs": "f554237d-599a-49b4-9f09-8a7e4b61ba34",
        "24 Hour Fitness": "4bfa67da-f3bf-47f1-803b-4ca0a7c0c14b"
    ]
    
    override func viewDidLoad() {
        print("ProfileViewController")
        super.viewDidLoad()
    
        
        
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        if let accessToken = AccessToken.current {
            self.progress = Progress()
            self.progress.cloudGet(fbhandle: accessToken.authenticationToken)
            self.habit = Habit()
            self.habit.cloudGet(fbhandle: accessToken.authenticationToken)
            
            
            
            let numGymVisits = userDefaults.integer(forKey: "Test.StickFencing.numGymVisits")
            let numWeekCommitment = userDefaults.integer(forKey: "Test.StickFencing.numWeekCommitment")
            let textMessage = userDefaults.string(forKey: "Test.StickFencing.textMessage")
            let messageType = userDefaults.string(forKey: "Test.StickFencing.messageType")
            let gymGeofenceId = userDefaults.string(forKey: "Test.StickFencing.geofenceId")
            
            var gymName = "Gym name"
            for (gn, gid) in self.gymGeofenceNames {
                if gymGeofenceId == gid {
                    gymName = gn
                }
            }
            
            
            self.numTimesPerWeekLabel.text = String(numGymVisits)
            self.numWeeksLabel.text = String(numWeekCommitment)
            self.gymNameLabel.text = gymName
            self.messageTypeLabel.text = messageType
            self.messageLabel.text = textMessage
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // you're good to go!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        if let location = locations.last {
            let activity = Activity()
            activity.fbhandle = AccessToken.current?.authenticationToken
            activity.lat = Float(location.coordinate.latitude)
            activity.long = Float(location.coordinate.longitude)
            activity.cloudInsert()
            print("New location is \(location)")
        }
    }
}

