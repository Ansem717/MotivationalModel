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
    @IBOutlet weak var backButton: UIBarButtonItem!
    
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
