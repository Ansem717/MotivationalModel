//
//  Additions.swift
//  MotivationalModel
//
//  Created by Andy Malik on 3/1/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

extension String {
    static func archivePath() -> String {
        guard let archivePath = NSURL.archiveURL().path else { fatalError("Can't get archive path?") }
        return archivePath
    }
}

extension NSURL {
    class func documentsDirectory() -> NSURL {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError("Error getting documents directory?") }
        return documentsDirectory
    }
    
    class func archiveURL() -> NSURL
    {
        return self.documentsDirectory().URLByAppendingPathComponent("motivational-model-archived")
    }
}