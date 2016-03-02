//
//  AdaptiveViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class AdaptiveViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    
    //MARK: UI ELEMENTS
    @IBOutlet weak var userInputArea: UITextView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet var buttonsUIArray: [UIButton]!
    
    @IBOutlet var bottomButtonConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var leadingButtonConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var leadingUserInputConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingUserInputConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingDescriptionConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingDescriptionConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backMenuButton: UIBarButtonItem!
    
    //MARK: Reference Variables
    var currRoom: Room?
    var animationDuration: Double?
    var soonToBeSubtitle: String = ""
    var roomReferenceName: String = kValueProp
    
    //MARK: Inheritted Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Stylization
        descriptionLabel.backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        descriptionLabel.editable = false
        descriptionLabel.font = UIFont(name: "Helvetica", size: 17.0)
        descriptionLabel.layer.cornerRadius = 5.0
        userInputArea.layer.cornerRadius = 5.0
        view.addSubview(descriptionLabel)
        
        for button in buttonsUIArray {
            button.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.00, alpha: 1.0)
            button.layer.cornerRadius = 10
            button.tintColor = UIColor(red: 0x88, green: 0xC3, blue: 0x87, alpha: 0.8)
        }
        
        setup(roomReferenceName)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.userInputArea.setContentOffset(CGPointZero, animated: false)
        self.descriptionLabel.setContentOffset(CGPointZero, animated: false)
    }
    
    //MARK: Large Setup Function
    func setup(roomName: String) {
        
        self.backMenuButton.enabled = false
        self.backMenuButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Disabled)
        
        print("AdaptVC Setup - parameter roomName: \(roomName)");print("");
        let nextRoom = RoomsCache.shared.findRoom(roomName)
        NavigationStack.shared.addRoomToNavigationStack(roomName)
        NavigationStack.shared.printContents()
        
        let prevRoomName = NavigationStack.shared.findPreviousRoomInNavStack()
        let prevRoomShorthand = RoomsCache.shared.findRoom(prevRoomName).abbreviation
        
        if let current = self.currRoom {
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: current.title)
            }
            for key in current.buttons {
                if roomName == key {
                    soonToBeSubtitle = current.subtitles[key]!
                }
                
                    /*OK HERES A TRIVIA QUESTION!s
                    
                    If I go from Value Prop to Customer Needs, then the above print statement should trigger.
                    If I use GOTO to jump from Value Prop to Partner Types, then it shouldn't trigger.
                    
                    Does it currently trigger if I use GOTO to jump from Value Prop to Customer Needs?
                    */
                
            }
            
            animateLEAVE { (finished) -> () in
                self.currRoom = nextRoom
                
                //Content change while offscreen
                self.userInputArea.text = nextRoom.userText
                self.descriptionLabel.text = nextRoom.descript
                self.navigationItem.title = nextRoom.title
                self.subtitleLabel.text = self.soonToBeSubtitle
                self.backMenuButton.title = "\(Icons.shared.prevArrow) \(prevRoomShorthand)"
                for button in self.buttonsUIArray {
                    button.titleLabel?.lineBreakMode = .ByWordWrapping
                    button.titleLabel?.textAlignment = .Center
                }
                
                var yPos = [CGFloat](count: 5, repeatedValue: 0.0)
                
                for var ii = 0; ii < nextRoom.buttons.count; ii++ {
                    
                    let index = ii
                    self.buttonsUIArray[index].setTitle(nextRoom.buttons[index], forState: .Normal)
                    var xPos = [CGFloat](count: 5, repeatedValue: 0.0)
                    
                    switch nextRoom.buttons.count {
                    case 2:
                        xPos[0] = 50;  xPos[1] = 230
                        yPos[0] = 473; yPos[1] = 473
                    case 3:
                        xPos[0] = 20;  xPos[1] = 140; xPos[2] = 240
                        yPos[0] = 473; yPos[1] = 473; yPos[2] = 473
                    case 4:
                        xPos[0] = 25;  xPos[1] = 99; xPos[2] = 161; xPos[3] = 235
                        yPos[0] = 448; yPos[1] = 515; yPos[2] = 448; yPos[3] = 515
                    case 5:
                        xPos[0] = 20;  xPos[1] = 75;  xPos[2] = 122; xPos[3] = 185; xPos[4] = 240
                        yPos[0] = 448; yPos[1] = 515; yPos[2] = 448; yPos[3] = 515; yPos[4] = 448
                    default:
                        print("WARNING! Going to Home OR only one button IN \n \(nextRoom.title)");print("")
                    }
                    
                    self.leadingButtonConstraints[index].constant = xPos[index]
                    self.trailingDescriptionConstraint.constant = -self.view.bounds.width * 2.0
                    self.leadingDescriptionConstraint.constant = self.view.bounds.width * 2.0
                    self.trailingUserInputConstraint.constant = -self.view.bounds.width * 2.0
                    self.leadingUserInputConstraint.constant = self.view.bounds.width * 2.0
                    self.buttonsUIArray[index].layoutIfNeeded()
                    self.descriptionLabel.layoutIfNeeded()
                    self.userInputArea.layoutIfNeeded()
                }
                
                self.animateAPPEAR(yPos)
            }
            
        } else { //From Home Page to Value Proposition

            self.currRoom = nextRoom
            
            //Content change while offscreen
            self.userInputArea.text = nextRoom.userText
            self.descriptionLabel.text = nextRoom.descript
            self.navigationItem.title = nextRoom.title
            self.subtitleLabel.text = self.soonToBeSubtitle
            self.backMenuButton.title = "\(Icons.shared.prevArrow) \(prevRoomShorthand)"
            for button in self.buttonsUIArray {
                button.titleLabel?.lineBreakMode = .ByWordWrapping
                button.titleLabel?.textAlignment = .Center
            }
            
            for var ii = 0; ii < nextRoom.buttons.count; ii++ {
                self.buttonsUIArray[ii].setTitle(nextRoom.buttons[ii], forState: .Normal)
            }
            
            for var ii = 0; ii < self.buttonsUIArray.count; ii++ {
                let index = ii
                
                switch index {
                case 0:
                    setPosition(50, y: 473, Xconstraint: self.leadingButtonConstraints[index], Yconstraint: self.bottomButtonConstraints[index])
                case 1:
                    setPosition(230, y: 473, Xconstraint: self.leadingButtonConstraints[index], Yconstraint: self.bottomButtonConstraints[index])
                default:
                    setPosition(y: 673, Yconstraint: self.bottomButtonConstraints[index])
                }
                
                self.buttonsUIArray[index].layoutIfNeeded()
                self.backMenuButton.enabled = true
            }
        }
    }
    
    func setPosition(x: CGFloat? = nil, y: CGFloat? = nil, Xconstraint: NSLayoutConstraint? = nil, Yconstraint: NSLayoutConstraint? = nil) {
        if let x = x, let Xconstraint = Xconstraint
        {
            Xconstraint.constant = x
        }
        if let y = y, let Yconstraint = Yconstraint {
            Yconstraint.constant =  520-y
        }
    }
    
    //MARK: Animation Functions
    func animateLEAVE(completion: (finished: Bool) -> ()) {
    
        guard let currentRoomExists = self.currRoom else { return }
        let numOfButtons = currentRoomExists.buttons.count
        let animationDuration = Double(numOfButtons)*0.5
        let lengthOfTimeToRise = (animationDuration) / Double(numOfButtons) / 4
        let lengthOfTimeToFall = lengthOfTimeToRise * 3
        
        
        leadingUserInputConstraint.constant -= view.bounds.width
        trailingUserInputConstraint.constant += view.bounds.width
        
        UIView.animateWithDuration(lengthOfTimeToFall, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.userInputArea.layoutIfNeeded()
        }, completion: nil)
        
        leadingDescriptionConstraint.constant -= view.bounds.width
        trailingDescriptionConstraint.constant += view.bounds.width
        
        UIView.animateWithDuration(lengthOfTimeToFall, delay: 0.1, options: .CurveLinear, animations: { () -> Void in
            self.descriptionLabel.layoutIfNeeded()
        }, completion: nil)
        
        for var ii = 0; ii < numOfButtons; ii++ {
            
            let index = ii
            let adaptDelay = Double(index) * lengthOfTimeToRise
            
            self.bottomButtonConstraints[index].constant += 10
            
            
            UIView.animateWithDuration(lengthOfTimeToRise, delay: adaptDelay, options: .CurveLinear, animations: { () -> Void in
                self.buttonsUIArray[index].layoutIfNeeded()
            }, completion: { (finished) -> Void in
                
                if finished {
                    self.bottomButtonConstraints[index].constant -= 200
                    
                    UIView.animateWithDuration(lengthOfTimeToFall, animations: { () -> Void in
                        self.buttonsUIArray[index].layoutIfNeeded()
                    }, completion: { (finished) -> Void in
                        
                        if index == numOfButtons-1 {
                            completion(finished: finished)
                        }
                    })
                }
            })
        }
    }
    
    func animateAPPEAR(ypos: [CGFloat]) {
        
        guard let currentRoomExists = self.currRoom else { return }
        let numOfButtons = currentRoomExists.buttons.count
        let animationDuration = Double(numOfButtons)*0.25
        let lengthOfTimeToRise = (animationDuration) / Double(currentRoomExists.buttons.count)
        
        leadingUserInputConstraint.constant = 20.0
        trailingUserInputConstraint.constant = 20.0
        
        UIView.animateWithDuration(lengthOfTimeToRise, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.userInputArea.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            self.userInputArea.scrollRangeToVisible(NSRange(location: 0, length: 0))
        })
        
        leadingDescriptionConstraint.constant = 20.0
        trailingDescriptionConstraint.constant = 20.0
        
        UIView.animateWithDuration(lengthOfTimeToRise, delay: 0.3, options: .CurveEaseOut, animations: { () -> Void in
            self.descriptionLabel.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            self.descriptionLabel.scrollRangeToVisible(NSRange(location: 0, length: 0))
        })
        
        for var ii = 0; ii < self.currRoom?.buttons.count; ii++ {
            
            let index = ii
            let adaptDelay = Double(index) * lengthOfTimeToRise
            
            self.bottomButtonConstraints[index].constant = 520 - ypos[index]
            
            UIView.animateWithDuration(lengthOfTimeToRise, delay: adaptDelay, options: .CurveLinear, animations: { () -> Void in
                self.buttonsUIArray[index].layoutIfNeeded()
            }, completion: { (finished) -> Void in
                if index == numOfButtons-1 {
                    self.backMenuButton.enabled = true
                }
            })
        }
    }
    
    //MARK: Button Functions.
    @IBAction func nextpageButtonPressed(sender: UIButton) {
        guard let buttonKey = sender.titleLabel!.text else { fatalError("Uhh?") }
        setup(buttonKey)
    }
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        //1) Remove last (current) from nav stack
        NavigationStack.shared.removeLastFromNavigationStack()
        NavigationStack.shared.printContents()
        
        //2) check if I'm going to kHome.
        let roomKey = NavigationStack.shared.findCurrentRoomInNavStack()
        if roomKey == kHome {
            //REVERSE PUSH?
            performSegueWithIdentifier("AdaptToHomeSegue", sender: nil)
        } else {
            //REVERSE ANIMATE?
            setup(roomKey)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let current = self.currRoom {
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: current.title)
            }
        }
        if segue.identifier == "AdaptToHomeSegue" {
            if let ivc = segue.destinationViewController as? IntroViewController {
                ivc.transitioningDelegate = self
            }
        }
        
    }
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
//    {
//        return ReversePush()
//    }
    
}
















