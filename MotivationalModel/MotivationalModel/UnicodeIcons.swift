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
    let exclamation = "\u{2757}"
    let prevArrow = "\u{276E}"
    let bullet = "\u{204D}"
    
    static let shared = Icons()
    
    private init() {}
    
    func prefixGreencheckmark(text: String) -> NSMutableAttributedString {
        let applyPrefix = "\(self.checkmark) \(text)"
        let mutableString = NSMutableAttributedString(string: applyPrefix)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0), range: NSMakeRange(0, 1))
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(1, mutableString.length-1))
        return mutableString
    }
    
    func prefixRedWarning(text: String) -> NSMutableAttributedString {
        let applyPrefix = "\(self.exclamation) \(text)"
        let mutableString = NSMutableAttributedString(string: applyPrefix)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 1))
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(1, mutableString.length-1))
        return mutableString
    }
}