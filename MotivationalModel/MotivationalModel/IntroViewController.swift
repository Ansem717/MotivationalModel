//
//  ViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/13/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    //MARK: UI Elements
    @IBOutlet weak var introBody: UILabel!
    @IBOutlet weak var nobLabel: UILabel!
    @IBOutlet weak var nobInputField: UITextField!
    @IBOutlet weak var viewPropButtonOutlet: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    //MARK: Inheritted Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Notifications from Keyboard to move the view upward
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UIKeyboardWillShowNotificationObserver:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UIKeyboardWillHideNotificationObserver:", name: UIKeyboardWillHideNotification, object: nil)
        
        //Notifications for when applicationWillResignActive
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UIApplicationWillResignActiveNotificationObserver", name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupIntroView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Notifcation for KeyboardWillShow, KeyboardWillHide, applicationWillResignActive, as well as the deinit method
    
    func UIKeyboardWillShowNotificationObserver(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { fatalError("No user info from notification") }
        guard let keyboard = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { fatalError("User info has no key of UUIKeyboardFrameBeginUserInfoKey  OR  It is not of type NSValue") }
        let keyboardSize = keyboard.CGRectValue()
        var selfFrame = self.view.frame
        selfFrame.origin.y -= keyboardSize.height
        
        if let keyboardDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            UIView.animateWithDuration(keyboardDuration.doubleValue, animations: { () -> Void in
                self.view.frame = selfFrame
            })
        } else {
            self.view.frame = selfFrame
        }
    }
    
    func UIKeyboardWillHideNotificationObserver(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { fatalError("No user info from notification") }
        guard let keyboard = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { fatalError("User info has no key of UUIKeyboardFrameBeginUserInfoKey  OR  It is not of type NSValue") }
        let keyboardSize = keyboard.CGRectValue()
        var selfFrame = self.view.frame
        selfFrame.origin.y += keyboardSize.height
        
        if let keyboardDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            UIView.animateWithDuration(keyboardDuration.doubleValue, animations: { () -> Void in
                self.view.frame = selfFrame
            })
        } else {
            self.view.frame = selfFrame
        }
    }
    
    func UIApplicationWillResignActiveNotificationObserver() {
        if let userText = self.nobInputField.text {
            RoomsCache.shared.saveRoom(userText, roomName: kHome)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //Setup UI
    func setupIntroView() {
        let homeRoom = RoomsCache.shared.findRoom(kHome)
        NavigationStack.shared.addRoomToNavigationStack(kHome)
        
        if NavigationStack.shared.count() == 1 {
            self.backButton.title = ""
        } else {
            let prevRoomName = NavigationStack.shared.findPreviousRoomInNavStack()
            let prevRoom = RoomsCache.shared.findRoom(prevRoomName)
            self.backButton.title = "\(Icons.shared.prevArrow) \(prevRoom.abbreviation)"
        }
        self.navigationItem.title = homeRoom.title
        self.nobInputField.text = homeRoom.userText
        introBody.layer.cornerRadius = 10
        viewPropButtonOutlet.layer.cornerRadius = 10

        NavigationStack.shared.printContents()
    }
    
    
    // Button Functions & Navigation
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        //
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        //Seuge id is HomeToViewPropSegue
    }
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        if self.backButton.title == "" { return }
        NavigationStack.shared.removeLastFromNavigationStack()
        NavigationStack.shared.printContents()
        performSegueWithIdentifier("HomeToAdaptSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userText = self.nobInputField.text {
            RoomsCache.shared.saveRoom(userText, roomName: kHome)
        }
        if segue.identifier == "HomeToAdaptSegue" {
            if self.backButton.title != "" {
                if let AVC = segue.destinationViewController as? AdaptiveViewController {
                    let newRoomName = NavigationStack.shared.findCurrentRoomInNavStack()
                    AVC.roomReferenceName = RoomsCache.shared.findRoom(newRoomName).title
                }
            }
        }
    }
}

extension IntroViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


