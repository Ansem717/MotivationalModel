//
//  AdaptiveViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class AdaptiveViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: UI ELEMENTS
    @IBOutlet weak var userInputArea: UITextView!
    @IBOutlet weak var subtitleLabel: UILabel!
    var descriptionLabel: UITextView!
    
    @IBOutlet var buttonsUIArray: [UIButton]!
    
    @IBOutlet var bottomButtonConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var leadingButtonConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var backMenuButton: UIBarButtonItem!
    
    //MARK: Reference Variables
    var currRoom: Room?
    var animationDuration: Double?
    
    //MARK: Visual Triggered Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Create scroll-able text field
        let viewWidth = view.bounds.width - 40
        let viewHeight = view.bounds.height - 400
        descriptionLabel = UITextView(frame: CGRect(x: 20, y: 260, width: viewWidth, height: viewHeight))
        descriptionLabel.backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        descriptionLabel.editable = false
        descriptionLabel.font = UIFont(name: "Helvetica", size: 17.0)
        view.addSubview(descriptionLabel)
        
        for button in buttonsUIArray {
            button.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.00, alpha: 1.0)
            button.layer.cornerRadius = 10
            button.tintColor = UIColor(red: 0x88, green: 0xC3, blue: 0x87, alpha: 0.8)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.userInputArea.setContentOffset(CGPointZero, animated: false)
    }
    
    //MARK: Setup (
    func setup(roomName: String = kValueProp) {
        
        print("AdaptVC Setup - parameter roomName: \(roomName)");print("");
        let nextRoom = RoomsCache.shared.currentRoom(roomName)
        NavigationStack.shared.addRoomToNavigationStack(roomName)
        NavigationStack.shared.contents()
        
        // What happens when a user already set a room value, then went to Home in the menu, then pressed the Value Prop button? I'll just have to find out.
        // Seems it kills the <#currRoom#> variable
        
        var prevRoomShorthand: String
        
        if let current = self.currRoom {
            prevRoomShorthand = current.abbreviation
            if let userText = self.userInputArea.text {
                RoomsCache.shared.saveRoom(userText, roomName: roomName)
            }
            for key in current.buttons {
                if roomName == key {
                    print("ADD SUBTITLE - destination: \(key) - source: \(current.title)");print("");
                    
                    /*OK HERES A TRIVIA QUESTION!s
                    
                    If I go from Value Prop to Customer Needs, then the above print statement should trigger.
                    If I use GOTO to jump from Value Prop to Partner Types, then it shouldn't trigger.
                    
                    Does it currently trigger if I use GOTO to jump from Value Prop to Customer Needs?
                    */
                }
            }
            
            animateLEAVE { (finished) -> () in
                self.currRoom = nextRoom
                
                //Content change while offscreen
                self.userInputArea.text = nextRoom.userText
                self.descriptionLabel.text = nextRoom.descript
                self.navigationItem.title = nextRoom.title
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
                    self.buttonsUIArray[index].layoutIfNeeded()
                }
                
                self.animateAPPEAR(yPos)
            }
            
        } else { //From Home Page to Value Proposition
            prevRoomShorthand = "EBM"
            self.currRoom = nextRoom
            //Content change while offscreen
            self.userInputArea.text = nextRoom.userText
            self.descriptionLabel.text = nextRoom.descript
            self.navigationItem.title = nextRoom.title
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
        let animationDuration = Double(numOfButtons)*0.5
        let lengthOfTimeToRise = (animationDuration) / Double(currentRoomExists.buttons.count)
        
        for var ii = 0; ii < self.currRoom?.buttons.count; ii++ {
            
            let index = ii
            let adaptDelay = Double(index) * lengthOfTimeToRise
            
            self.bottomButtonConstraints[index].constant = 520 - ypos[index]
            
            UIView.animateWithDuration(lengthOfTimeToRise, delay: adaptDelay, options: .CurveLinear, animations: { () -> Void in
                self.buttonsUIArray[index].layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    //MARK: Button Function. Only one function, reused for all buttons.
    @IBAction func nextpageButtonPressed(sender: UIButton) {
        guard let buttonKey = sender.titleLabel!.text else { fatalError("Uhh?") }
        setup(buttonKey)
    }
    
    
    
    
}
















