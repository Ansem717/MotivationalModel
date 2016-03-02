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
        let homeRoom = RoomsCache.shared.currentRoom(kHome)
        self.navigationItem.title = homeRoom.title
        self.nobInputField.text = homeRoom.userText
        introBody.layer.cornerRadius = 10
        viewPropButtonOutlet.layer.cornerRadius = 10
        NavigationStack.shared.addRoomToNavigationStack(kHome)
        NavigationStack.shared.printContents()
    }
    
    
    // Button Functions & Navigation
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        //
    }
    
    @IBAction func viewPropButton(sender: UIButton) {
        //
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userText = self.nobInputField.text {
            RoomsCache.shared.saveRoom(userText, roomName: kHome)
        }
    }
    
}
