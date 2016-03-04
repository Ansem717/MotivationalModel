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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: Button Function
    
    @IBAction func menuButtonPressed(sender: UIButton) {
        guard let buttonName = sender.titleLabel!.text else { fatalError("Uhh?") }
        
        switch (buttonName) {
            //Home is omitted since we're just using an unwind segue
        case "Go To": self.performSegueWithIdentifier("MenuToGotoSegue", sender: nil)
        case "E-mail": confirmBusinessName("email")
        case "Print": confirmBusinessName("print")
        case "About": self.performSegueWithIdentifier("MenuToAboutSegue", sender: nil)
        case "Close": dismissViewControllerAnimated(true, completion: nil)
        default: print("Default was hit?")
        }
    }
    
    func confirmBusinessName(destination: String) {
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            if businessName == "" {
               
                let namePopup = UIAlertController(title: "Business Name", message: "Please put in a name for your business on the Home page.", preferredStyle: .Alert)
                namePopup.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(namePopup, animated: true, completion: nil)
                
            } else {
                self.confirmEmptyFields(destination)
            }
        }
    }
    
    func confirmEmptyFields(destination: String) {
        var message = ""
        var isSafe = true
        for currRoom in RoomsCache.shared.rooms {
            if let thisRoomUserInput = currRoom.userText where thisRoomUserInput.isEmpty {
                message = "\(message)\n\(currRoom.title)"
                isSafe = false
            }
        }
        
        let emptyFieldPopup = UIAlertController(title: "Are you sure?", message: "The following fields are empty:\n\(message)", preferredStyle: .Alert)
        emptyFieldPopup.addAction(UIAlertAction(title: "Continue", style: .Default, handler: { (action) -> Void in
            self.confirmUserName(destination)
        }))
        emptyFieldPopup.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        
        if !isSafe {
            presentViewController(emptyFieldPopup, animated: true, completion: nil)
        } else {
            self.confirmUserName(destination)
        }
        
    }
    
    
    func confirmUserName(destination: String) {
        if RoomsCache.shared.username == "" {
            getUserName(destination)
        } else {
            let namePopup = UIAlertController(title: "Name", message: "Is your name \(RoomsCache.shared.username)?", preferredStyle: .Alert)
            namePopup.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) -> Void in
                self.makePDF(destination)
            }))
            namePopup.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
                self.getUserName(destination)
            }))
            namePopup.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
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
            self.makePDF(destination)
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
//                print(pdfPathWithFileName);print("")
                
                guard let fileData = NSData(contentsOfFile: pdfPathWithFileName) else { fatalError("6") }
                let mimeType = "application/pdf"
                
                mailComposer.addAttachmentData(fileData, mimeType: mimeType, fileName: fileName)
                self.presentViewController(mailComposer, animated: true, completion: nil)
                
            } else {
                noEmailFound()
            }
            
        } else { fatalError("20319") }
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
    
    //MARK: AirPrint
    func printWithPDF() {
        
        
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            
            let dashedBusinessName = businessName.stringByReplacingOccurrencesOfString(" ", withString: "-")
            let fileName = "\(dashedBusinessName)-Business-Model.pdf"
            let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectory = path.objectAtIndex(0)
            let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
            guard let pdfDATA = NSData(contentsOfFile: pdfPathWithFileName) else { fatalError("SO CLOSE") }
            
            if UIPrintInteractionController.isPrintingAvailable() && UIPrintInteractionController.canPrintData(pdfDATA) {
                
                let printController = UIPrintInteractionController.sharedPrintController()
                
                let printInfo = UIPrintInfo(dictionary: nil)
                printInfo.outputType = .Grayscale
                printInfo.jobName = "\(fileName)"
                printController.printInfo = printInfo
                printController.showsPageRange = true
                printController.printingItem = pdfDATA
                
                printController.presentAnimated(true, completionHandler: nil)
            
            }
            
        }
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
