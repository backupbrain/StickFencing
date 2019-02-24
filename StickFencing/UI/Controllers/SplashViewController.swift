//
//  SplashViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import CoreLocation

class SplashViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var jsonTestButton: UIButton!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        print("SplashViewController")
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        if let accessToken = AccessToken.current {
            print(accessToken)
            self.loadNextScreen()
        }
    }
    
    func loadNextScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if (userDefaults.bool(forKey: "Test.StickFencing.wasIntroScreenSeen") == true) {
            if (userDefaults.bool(forKey: "Test.StickFencing.wereGoalsSet") == true) {
                let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.present(profileViewController, animated: true, completion: nil)
            } else {
                let setGoalViewController = storyBoard.instantiateViewController(withIdentifier: "SetGoalViewController") as! SetGoalViewController
                self.present(setGoalViewController, animated: true, completion: nil)
            }
        } else {
            let overviewViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewViewController") as! OverviewViewController
            self.present(overviewViewController, animated: true, completion: nil)
        }
    }
        
    @IBAction func onFacebookLaginButtonTouched(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile], viewController : self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.loadNextScreen()
            }
        }
    }
    
    @IBAction func onJsonTestButtonTouched(_ sender: Any) {
        print("creating profile")
        let profile:Profile = Profile()
        profile.fbhandle = "bhavya6187" // AccessToken.current?.userId
        print("getting profile from cloud")
        profile.cloudGet(fbhandle: "bhavya6187")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // you're good to go!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

