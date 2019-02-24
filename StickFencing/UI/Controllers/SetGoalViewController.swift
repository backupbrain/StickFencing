//
//  SetGoalViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit

class SetGoalViewController: UIViewController {
    @IBOutlet weak var numGymVisitsInput: UITextField!
    @IBOutlet weak var numWeekCommitmentInput: UITextField!
    @IBOutlet weak var textMessageInput: UITextView!
    @IBOutlet weak var facebookPostInput: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        print("SetGoalViewController")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onNextButtonTouched(_ sender: Any) {
        userDefaults.set(value: true, forKey: "Test.StickFencing.wereGoalsSet")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profileViewController, animated: true, completion: nil)
    }
    
}

