//
//  Room.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

class Room {
    
    var title: String
    var subtitle: String
    var userText: String?
    var descript: String
    var buttons: [String]
    
    init(title: String, subtitle: String, userText: String? = "", descript: String, buttons: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.userText = userText
        self.descript = descript
        self.buttons = buttons
    }
    
}


