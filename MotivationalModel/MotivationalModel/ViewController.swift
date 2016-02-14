//
//  ViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/13/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    // Storyboard Items
    
    @IBOutlet weak var introBody: UILabel!
    @IBOutlet weak var nobLabel: UILabel!
    @IBOutlet weak var nobInputField: UITextField!

    
    //UIViewController inheritance functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Introduction"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Button Functions
    @IBAction func menuButton(sender: UIBarButtonItem) {
        let label = "  MENU BUTTON PRESSED  "
        self.introBody.text = "\(self.introBody.text!) \(label)"
        self.nobLabel.text = label
        self.nobInputField.placeholder = label
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        let label = "  VIEW PROP BUTTON PRESSED  "
        self.introBody.text = "\(self.introBody.text!) \(label)"
        self.nobLabel.text = label
        self.nobInputField.placeholder = label
    }
    
}

