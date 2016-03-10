//
//  AdaptiveViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class AdaptiveViewController: UIViewController {
    
    //MARK: UI Elements
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
    @IBOutlet weak var subtitleTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backMenuButton: UIBarButtonItem!
    
    //MARK: Reference Variables
    var currRoom: Room?
    var animationDuration: Double?
    var soonToBeSubtitle: String = ""
    var roomReferenceName: String = kValueProp
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    //MARK: Inheritted Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UIApplicationWillResignActiveNotificationObserver", name: UIApplicationWillResignActiveNotification, object: nil)
        
        descriptionLabel.backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        descriptionLabel.editable = false
        
        let fontSize: CGFloat = screenHeight > 660 ? 18 : 14
        
        descriptionLabel.font = UIFont(name: "Helvetica", size: fontSize)
        descriptionLabel.layer.cornerRadius = 5.0
        userInputArea.layer.cornerRadius = 5.0
        userInputArea.font = UIFont(name: "Helvetica", size: fontSize)
        view.addSubview(descriptionLabel)
        
        for button in buttonsUIArray {
            button.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.00, alpha: 1.0)
            button.layer.cornerRadius = 10
            button.tintColor = UIColor(red: 0x88, green: 0xC3, blue: 0x87, alpha: 0.8)
            button.transform = CGAffineTransformScale(button.transform, (screenHeight*(-0.0002))+1.0, (screenHeight*(-0.0002))+1.0)
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
    
    //MARK: Resign Active Notification Observer & Deinit
    func UIApplicationWillResignActiveNotificationObserver() {
        if let current = self.currRoom {
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: current.title)
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: Setup Function
    func setup(roomName: String) {
        
        self.backMenuButton.enabled = false
        
        let nextRoom = RoomsCache.shared.findRoom(roomName)
        NavigationStack.shared.addRoomToNavigationStack(roomName)
        NavigationStack.shared.printContents()
        
        let prevRoomName = NavigationStack.shared.findPreviousRoomInNavStack()
        let previousRoom = RoomsCache.shared.findRoom(prevRoomName)
        let prevRoomShorthand = previousRoom.abbreviation
        
        for key in previousRoom.buttons {
            var found = false
            if roomName == key {
                soonToBeSubtitle = previousRoom.subtitles[key]!
                found = true
            }
            if found { break }
        }
        
        if let current = self.currRoom {
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: current.title)
            }
            self.animateLEAVE { (finished) -> () in
                self.changeContent(nextRoom, prevRoomShorthand: prevRoomShorthand)
                let yPos = self.readyButtonPositions(nextRoom, currRoomExists: true)
                self.animateAPPEAR(yPos)
            }
        } else {
            self.changeContent(nextRoom, prevRoomShorthand: prevRoomShorthand)
            self.readyButtonPositions(nextRoom, currRoomExists: false)
            self.backMenuButton.enabled = true
        }
    }
    
    //MARK: Setup Helper Functions
    func changeContent(nextRoom: Room, prevRoomShorthand: String) {
        self.currRoom = nextRoom
        self.userInputArea.text = nextRoom.userText
        self.descriptionLabel.text = nextRoom.descript
        self.navigationItem.title = nextRoom.title
        self.subtitleLabel.text = self.soonToBeSubtitle
        self.backMenuButton.title = "\(Icons.shared.prevArrow) \(prevRoomShorthand)"
        for button in self.buttonsUIArray {
            button.titleLabel?.lineBreakMode = .ByWordWrapping
            button.titleLabel?.textAlignment = .Center
        }
    }
    
    func readyButtonPositions(nextRoom: Room, currRoomExists: Bool) -> [CGFloat] {
        let buttonWidth = self.buttonsUIArray[0].frame.width                    // Width of button
        let numOfButtons = CGFloat(nextRoom.buttons.count)                      // number of buttons in CGFloat form
        let margin = self.screenWidth*0.04                                      // Margin relative to screen width (also b for line)
        let maxAllocatedWidth = self.screenWidth - (margin * 3) - buttonWidth   // Numerator of Slope
        let evenSpacing = maxAllocatedWidth / (numOfButtons - 1.0)              // SLOPE (m) for linear equation
        
        var yPos = [CGFloat](count: 5, repeatedValue: 0.0)
        var xPos = [CGFloat](count: 5, repeatedValue: 0.0)
        var isHigh = true
        
        for var index = 0; index < self.buttonsUIArray.count; index++ {
            
            let thisXConstraint = (evenSpacing * CGFloat(index)) + margin       // y = mx + b
            
            xPos[index] = index < nextRoom.buttons.count ? thisXConstraint : -self.screenHeight
            yPos[index] = -200
            
            if index < nextRoom.buttons.count {
                self.buttonsUIArray[index].setTitle(nextRoom.buttons[index], forState: .Normal)
                yPos[index] = (numOfButtons == 2.0 || numOfButtons == 3.0) ? 47 : (isHigh ? 72 : 5)
                isHigh = !isHigh
            }
            
            if !currRoomExists {
                self.bottomButtonConstraints[index].constant = yPos[index]
            }
            self.leadingButtonConstraints[index].constant = xPos[index]
            self.buttonsUIArray[index].layoutIfNeeded()
        }

        
        if currRoomExists {
            self.trailingDescriptionConstraint.constant = -self.screenWidth * 2.0
            self.leadingDescriptionConstraint.constant = self.screenWidth * 2.0
            self.trailingUserInputConstraint.constant = -self.screenWidth * 2.0
            self.leadingUserInputConstraint.constant = self.screenWidth * 2.0
            self.descriptionLabel.layoutIfNeeded()
            self.userInputArea.layoutIfNeeded()
        }
        
        return yPos
    }
    
    
    //MARK: Animation Functions
    func animateLEAVE(completion: (finished: Bool) -> ()) {
        
        guard let currentRoomExists = self.currRoom else { return }
        let numOfButtons = currentRoomExists.buttons.count
        let lengthOfTimeToRise = (Double(numOfButtons)*0.5) / Double(numOfButtons) / 4
        let lengthOfTimeToFall = lengthOfTimeToRise * 3
        
        leadingUserInputConstraint.constant -= screenWidth
        trailingUserInputConstraint.constant += screenWidth
        
        UIView.animateWithDuration(lengthOfTimeToFall, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.userInputArea.layoutIfNeeded()
            }, completion: nil)
        
        leadingDescriptionConstraint.constant -= screenWidth
        trailingDescriptionConstraint.constant += screenWidth
        
        UIView.animateWithDuration(lengthOfTimeToFall, delay: 0.2, options: .CurveLinear, animations: { () -> Void in
            self.descriptionLabel.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.subtitleLabel.alpha = 0.0
            self.subtitleLabel.transform = CGAffineTransformTranslate(self.subtitleLabel.transform, 0.0, -30.0)
        })
        
        for var ii = 0; ii < numOfButtons; ii++ {
            
            let index = ii
            let adaptDelay = Double(index) * lengthOfTimeToRise
            
            self.bottomButtonConstraints[index].constant += 15
            
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
        let lengthOfTimeToRise = (Double(numOfButtons)*0.3) / Double(currentRoomExists.buttons.count)
        
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
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.subtitleLabel.alpha = 1.0
            self.subtitleLabel.transform = CGAffineTransformTranslate(self.subtitleLabel.transform, 0.0, 30.0)
        }
        
        for var ii = 0; ii < self.currRoom?.buttons.count; ii++ {
            
            let index = ii
            self.bottomButtonConstraints[index].constant = ypos[index]
            
            UIView.animateWithDuration(lengthOfTimeToRise, delay: (Double(index) * lengthOfTimeToRise), options: .CurveLinear, animations: { () -> Void in
                self.buttonsUIArray[index].layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    if index == numOfButtons-1 {
                        self.backMenuButton.enabled = true
                    }
            })
        }
    }
    
    //MARK: Button Functions
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
            performSegueWithIdentifier("AdaptToHomeSegue", sender: nil)
            return
        }
        setup(roomKey)
    }
    
    //MARK: Navigation functions:
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let current = self.currRoom {
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: current.title)
            }
        }
    }
    
}

extension AdaptiveViewController: UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
