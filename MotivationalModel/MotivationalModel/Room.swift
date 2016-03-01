//
//  Room.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

class Room: NSObject, NSCoding {
    
    var title: String
    var subtitle: String
    var abbreviation: String
    var userText: String?
    var descript: String
    var buttons: [String]
    
    init(title: String, subtitle: String, abbreviation: String, userText: String? = "", descript: String, buttons: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.abbreviation = abbreviation
        self.userText = userText
        self.descript = descript
        self.buttons = buttons
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObjectForKey("title") as? String else { fatalError("Title is not a string") }
        guard let subtitle = aDecoder.decodeObjectForKey("subtitle") as? String else { fatalError("subtitle is not a string") }
        guard let abbreviation = aDecoder.decodeObjectForKey("abbreviation") as? String else { fatalError("abbreviation is not a string") }
        guard let userText = aDecoder.decodeObjectForKey("userText") as? String else { fatalError("User Text is not a string") }
        guard let descript = aDecoder.decodeObjectForKey("descript") as? String else { fatalError("descript is not a string") }
        guard let buttons = aDecoder.decodeObjectForKey("buttons") as? [String] else { fatalError("buttons is not a [string]") }
        
        self.init(title: title, subtitle: subtitle, abbreviation: abbreviation, userText: userText, descript: descript, buttons: buttons)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.subtitle, forKey: "subtitle")
        aCoder.encodeObject(self.abbreviation, forKey: "abbreviation")
        aCoder.encodeObject(self.userText, forKey: "userText")
        aCoder.encodeObject(self.descript, forKey: "descript")
        aCoder.encodeObject(self.buttons, forKey: "buttons")
    }
}


