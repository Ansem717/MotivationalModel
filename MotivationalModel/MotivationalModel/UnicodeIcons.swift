//
//  UnicodeIcons.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/19/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation
import UIKit

class Icons {
    
    let checkmark = "\u{2714}"
    let redx = "\u{2718}"
    let exclamation = "\u{2757}"
    let nextArrow = "\u{276F}"
    
    static let shared = Icons()
    
    private init() {}
    
    func prefixGreencheckmark(text: String) -> NSMutableAttributedString {
        let applyPrefix = "\(self.checkmark) \(text)"
        let mutableString = NSMutableAttributedString(string: applyPrefix)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, 1))
        return mutableString
    }
}