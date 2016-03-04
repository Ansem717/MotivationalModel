//
//  Additions.swift
//  MotivationalModel
//
//  Created by Andy Malik on 3/1/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func archivePath(optionalPath: String = "archived") -> String {
        guard let archivePath = NSURL.archiveURL(optionalPath).path else { fatalError("Can't get archive path?") }
        return archivePath
    }
}

extension NSURL {
    class func documentsDirectory() -> NSURL {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError("Error getting documents directory?") }
        return documentsDirectory
    }
    
    class func archiveURL(optionalPath: String = "archived") -> NSURL
    {
        return self.documentsDirectory().URLByAppendingPathComponent("motivational-model-\(optionalPath)")
    }
}
