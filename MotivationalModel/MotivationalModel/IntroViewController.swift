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
        self.navigationItem.title = "HOME TO HOME???"  // "Enterprise Business Model"
        viewPropButtonOutlet.layer.cornerRadius = 10
    }
    
    
    // Button Functions & Navigation
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        //
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        //
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let _ = segue.destinationViewController as? MenuViewController else {
            NavigationStack.shared.addRoomToNavigationStack(kHome)
            NavigationStack.shared.contents()
            return
        }
    }
    
}
