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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupIntroView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Setup UI
    func setupIntroView() {
        self.navigationItem.title = "Enterprise Business Model"
        viewPropButtonOutlet.layer.cornerRadius = 10
        
    }
    
    
    // Button Functions
    @IBAction func menuButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("MenuViewController", sender: nil)
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        //
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.navigationItem.title = "EBM"
    }
    
}
