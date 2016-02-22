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
    @IBOutlet weak var viewPropButtonOutlet: UIButton!
    
    //UIViewController inheritance functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIntroView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Setup UI
    func setupIntroView() {
        self.navigationItem.title = "Introduction"
        viewPropButtonOutlet.layer.cornerRadius = 10
        
    }
    
    
    // Button Functions
    @IBAction func menuButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("MenuViewController", sender: nil)
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        self.introBody.text = "View prop button pressed."
    }
    
}
