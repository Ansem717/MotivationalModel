//
//  MenuViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/19/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let detail: String = Icons.shared.nextArrow

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupMenu() {
        
    }
    
    @IBAction func homeButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
