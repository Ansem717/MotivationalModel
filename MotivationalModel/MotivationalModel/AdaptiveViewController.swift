//
//  AdaptiveViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class AdaptiveViewController: UIViewController {

    //MARK: UI ELEMENTS
    @IBOutlet weak var userInputArea: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    
    //MARK: Reference Variables
    var currRoom: Room?
    
    
    //MARK: Visual Triggered Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.userInputArea.setContentOffset(CGPointZero, animated: false)
    }
    
    //MARK: Setup (
    func setup() {
        
        
//        guard let prevRoom = self.currRoom else {
        
            //FIRST TIME - Home to Value Prop.
        
            /* Wait- What happens when a user already set a room value, then went to Home in the menu, then came back?
                --What happens when they press Home's "Go to Value Prop" button?
                --What happens when they press a button in the "Go To" menu from Home? 
            */
        
//            return
//        }
        
        
        
    }
    
    //MARK: Button Function. Only one function, reused for all buttons.
    @IBAction func nextpageButtonPressed(sender: UIButton) {
        guard let buttonKey = sender.titleLabel!.text else { fatalError("Uhh?") }
        
        print(buttonKey)
    }
    
    


}
















