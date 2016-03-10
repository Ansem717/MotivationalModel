//
//  GotoViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 3/3/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit



class GotoViewController: UIViewController {
    
    //MARK: UI elements
    @IBOutlet var gotoButtonsCollection: [UIButton]!
    
    
    //MARK: Inheritted functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupButtonPrefix()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: Setup function
    func setupButtonPrefix() {
        for var ii = 0; ii < gotoButtonsCollection.count; ii++ {
            let gotoIndex = ii
            let roomsIndex = ii+1
            let thisRoom = RoomsCache.shared.rooms[roomsIndex]
            
            let prefixedTitle = thisRoom.userText!.isEmpty ? Icons.shared.prefixRedWarning(thisRoom.title) : Icons.shared.prefixGreencheckmark(thisRoom.title)
            
            gotoButtonsCollection[gotoIndex].setAttributedTitle(prefixedTitle, forState: .Normal)
        }
    }
    
    
    //MARK: One button function... to rule them all!
    @IBAction func globalGotoButtonFunction(sender: UIButton) {
        guard let buttonKey = sender.titleLabel?.text else { fatalError("22") }
        if buttonKey == "Close" {
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        performSegueWithIdentifier("GotoToAdaptView", sender: buttonKey)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GotoToAdaptView" {
            guard var buttonKey = sender as? String else { fatalError("103") }
            
            //remove first two characters of string (checkmark or !, and whitespace)
            buttonKey.removeAtIndex(buttonKey.startIndex);buttonKey.removeAtIndex(buttonKey.startIndex)
            if let AVC = segue.destinationViewController as? AdaptiveViewController {
                AVC.roomReferenceName = buttonKey
            }
        }
    }
    
    
}
