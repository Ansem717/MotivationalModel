//
//  MenuViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/19/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit
import MessageUI

class MenuViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
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
        case "Go To": print("Go To Pressed")
        case "E-mail": confirmUserName("email")
        case "Print": printWithPDF()
        case "About": print("About Pressed")
        case "Close": dismissViewControllerAnimated(true, completion: nil)
        default: print("Default was hit?")
        }
        
        
    }
    
    
    func confirmUserName(destination: String) {
        if RoomsCache.shared.username == "" {
            getUserName(destination)
        } else {
            let namePopup = UIAlertController(title: "Name", message: "Is your name \(RoomsCache.shared.username)?", preferredStyle: .Alert)
            namePopup.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) -> Void in
                self.confirmBusinessName(destination)
            }))
            namePopup.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
                self.getUserName(destination)
            }))
            self.presentViewController(namePopup, animated: true, completion: nil)
        }
    }
    
    func getUserName(destination: String) {
        let namePopup = UIAlertController(title: "Name", message: "Enter your full name", preferredStyle: .Alert)
        
        let nameAction = UIAlertAction(title: "Accept", style: .Default) { (action) -> Void in
            let nameTextField = namePopup.textFields![0] as UITextField
            nameTextField.autocapitalizationType = .Words
            guard let name = nameTextField.text else { fatalError("11") }
            RoomsCache.shared.username = name
            NSKeyedArchiver.archiveRootObject(RoomsCache.shared.username, toFile: String.archivePath("username"))
            self.confirmBusinessName(destination)
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
    
    func confirmBusinessName(destination: String) {
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            if businessName == "" {
                let namePopup = UIAlertController(title: "Business Name", message: "Please put in a name for your business on the Home page.", preferredStyle: .Alert)
                namePopup.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(namePopup, animated: true, completion: nil)
            } else {
                self.makePDF(destination)
            }
        }
    }
    
    func confirmMissingSections(destination: String) {
        //MARK: Save for later...
    }
    
    func makePDF(destination: String) {
        let pdfdoc = DocumentOutput(userName: RoomsCache.shared.username)
        pdfdoc.generatePDF()
        if destination == "email" {
            showEmailWithPDF()
        } else if destination == "print" {
            printWithPDF()
        }
    }
    
    //MARK: Email view controller is created and presented here.
    func showEmailWithPDF() {
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            
            if MFMailComposeViewController.canSendMail() {
                
                let emailTitle = "\(businessName) Business Model"
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setSubject(emailTitle)
                
                let dashedBusinessName = businessName.stringByReplacingOccurrencesOfString(" ", withString: "-")
                let fileName = "\(dashedBusinessName)-Business-Model.pdf"
                let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                let documentDirectory = path.objectAtIndex(0)
                let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
                print(pdfPathWithFileName);print("")
                
                guard let fileData = NSData(contentsOfFile: pdfPathWithFileName) else { fatalError("6") }
                let mimeType = "application/pdf"
                
                mailComposer.addAttachmentData(fileData, mimeType: mimeType, fileName: fileName)
                self.presentViewController(mailComposer, animated: true, completion: nil)
                
            } else {
                noEmailFound()
            }
            
        }
    }
    
    func noEmailFound() {
        let noEmailFoundPopup = UIAlertController(title: "No emails found", message: "Please go to your settings and login to your e-mail.", preferredStyle: .Alert)
        noEmailFoundPopup.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(noEmailFoundPopup, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        alertEmail(result)
    }
    
    func alertEmail(result: MFMailComposeResult) {
        var alertTitle = ""
        
        switch result {
        case MFMailComposeResultCancelled: alertTitle = "Email cancelled."
        case MFMailComposeResultSaved: alertTitle = "Email saved."
        case MFMailComposeResultSent: alertTitle = "Email sent."
        case MFMailComposeResultFailed: alertTitle = "Warning! Your email message failed to send."
        default: print("Default???")
        }
        
        let emailResultpopup = UIAlertController(title: alertTitle, message: "", preferredStyle: .Alert)
        emailResultpopup.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(emailResultpopup, animated: true, completion: nil)
        
    }
    
    //MARK: Print coming soon.
    func printWithPDF() {
        let namePopup = UIAlertController(title: "Coming Soon!", message: "", preferredStyle: .Alert)
        namePopup.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(namePopup, animated: true, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
