//
//  ConsentViewController.swift
//  StickFencing
//
//  Created by Adonis Gaitatzis on 2/23/19.
//  Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit

class ConsentViewController: UIViewController {
    @IBOutlet weak var iAgreeToggle: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var numWeeksLabel: UILabel!
    
    override func viewDidLoad() {
        print("ConsentViewController")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onIAgreeToggleChanged(_ sender: Any) {
    }
    
    @IBAction func onNextButtonTouched(_ sender: Any) {
    }
    
}

