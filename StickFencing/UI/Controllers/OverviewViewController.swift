//
//  OverviewViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        print("OverviewViewController")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onNextButtonTouched(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let setGoalViewController = storyBoard.instantiateViewController(withIdentifier: "setGoalViewController") as! SetGoalViewController
        self.present(setGoalViewController, animated: true, completion: nil)
    }
    
}

