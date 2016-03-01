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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupMenu() {
        
    }

    //MARK: Button Function
    
    @IBAction func menuButtonPressed(sender: UIButton) {
        guard let buttonName = sender.titleLabel!.text else { fatalError("Uhh?") }
        
        switch (buttonName) {
            //Home is omitted since we're just using an unwind segue
            case "Go To":
                print("Go to Pressed!!");print("");
            case "E-mail":
                print("E-mail Pressed!!");print("");
            case "Print":
                print("Print Pressed!!");print("");
            case "About":
                print("About Pressed!!");print("");
            case "Close":
                dismissViewControllerAnimated(true, completion: nil)
            default:
                print("Wait, what did you do?");print("");
        }
        
        
    }

    
}
