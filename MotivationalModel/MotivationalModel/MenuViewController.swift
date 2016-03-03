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
                print("E-mail Pressed!!");email();
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
    
    func email() {
        confirmUserName()
    }
    
    func makePDF() {
        let pdfdoc = DocumentOutput(userName: RoomsCache.shared.username)
        pdfdoc.generatePDF()
    }

    func confirmUserName() {
        if RoomsCache.shared.username == "" {
            getUserName()
        } else {
            let namePopup = UIAlertController(title: "Name", message: "Is your name \(RoomsCache.shared.username)?", preferredStyle: .Alert)
            namePopup.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) -> Void in
                self.makePDF()
            }))
            namePopup.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
                self.getUserName()
            }))
            self.presentViewController(namePopup, animated: true, completion: nil)
        }
    }
    
    func getUserName() {
        let namePopup = UIAlertController(title: "Name", message: "Enter your full name", preferredStyle: .Alert)
        
        let nameAction = UIAlertAction(title: "Accept", style: .Default) { (action) -> Void in
            let nameTextField = namePopup.textFields![0] as UITextField
            nameTextField.autocapitalizationType = .Words
            guard let name = nameTextField.text else { fatalError("ASKDJFASKDJFSLKFJSDFLDSJFL") }
            RoomsCache.shared.username = name
            NSKeyedArchiver.archiveRootObject(RoomsCache.shared.username, toFile: String.archivePath("username"))
            self.makePDF()
        }
        nameAction.enabled = false
        
        namePopup.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Name"
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textfield, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
                nameAction.enabled = textfield.text != ""
            })
        }

        namePopup.addAction(nameAction)
        namePopup.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        self.presentViewController(namePopup, animated: true, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
