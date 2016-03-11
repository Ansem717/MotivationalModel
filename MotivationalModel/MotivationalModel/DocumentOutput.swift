//
//  DocumentOutput.swift
//  MotivationalModel
//
//  Created by Andy Malik on 3/2/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation
import UIKit

class DocumentOutput {
    
    var userName: NSString
    let pageSize: CGSize = CGSizeMake(850, 1100)
    let normalFont: UIFont = UIFont(name: "Helvetica", size: 14) ?? UIFont.systemFontOfSize(14)
    let H1Font: UIFont = UIFont(name: "Helvetica", size: 39) ?? UIFont.systemFontOfSize(22)
    let H2Font: UIFont = UIFont(name: "Helvetica", size: 20) ?? UIFont.systemFontOfSize(18)
    var numOfPages: CGFloat = 0
    
    init(userName: NSString) {
        self.userName = userName
    }
    
    func generatePDF() {
        let sentenceWidth = 160
        
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            
            let dashedBusinessName = businessName.stringByReplacingOccurrencesOfString(" ", withString: "-")
            let fileName = "\(dashedBusinessName)-Business-Model.pdf"
            let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectory = path.objectAtIndex(0)
            let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
            print("\n==========================================\n\(pdfPathWithFileName)\n==========================================\n")
            
            UIGraphicsBeginPDFContextToFile(pdfPathWithFileName, CGRectZero, nil)
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil)
            
            self.drawInHeaders(businessName)
            
            var theNextSectionSpacing: CGFloat = 0
            var theNextPageSpacing: CGFloat = 0
            
            for var ii = 1; ii < RoomsCache.shared.rooms.count; ii++ {
                guard let contentString = RoomsCache.shared.rooms[ii].userText else { fatalError("4") }
                
                let numberOfChars = contentString.characters.count
                let numberOfLines = CGFloat(numberOfChars/sentenceWidth)
                let pointsPerLine: CGFloat = 33.0
                
                let spacing = pointsPerLine * numberOfLines
                
                var yPosSection = CGFloat(ii*90) + 70.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                var yPosContent = yPosSection + pointsPerLine
                
                if yPosContent+spacing >= pageSize.height-70 {
                    
                    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil)
                    
                    numOfPages++
                    theNextPageSpacing += pageSize.height - yPosSection + 140.0
                    
                    yPosSection = CGFloat(ii*90) + 70.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                    yPosContent = CGFloat(ii*90) + 103.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                    
                    drawInHeaders(businessName)
                }
                
                let sectionTitleRect: CGRect = CGRectMake(50, yPosSection, pageSize.width-100, 50)
                let contentRect: CGRect = CGRectMake(100, yPosContent, pageSize.width-200, spacing+50)
                
                guard let sectionTitleParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("2") }
                sectionTitleParagraphStyle.lineBreakMode = .ByWordWrapping
                sectionTitleParagraphStyle.alignment = .Left
                let sectionTitleAttributes = [NSFontAttributeName : H2Font, NSParagraphStyleAttributeName : sectionTitleParagraphStyle]
                
                guard let contentParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("3") }
                contentParagraphStyle.lineBreakMode = .ByWordWrapping
                contentParagraphStyle.alignment = .Left
                let contentAttributes = [NSFontAttributeName : normalFont, NSParagraphStyleAttributeName : contentParagraphStyle]
                
                let sectionTitle: NSString = "  \(RoomsCache.shared.rooms[ii].title)"
                let contentText: NSString = "\(Icons.shared.bullet)\t\(contentString)"
                
                sectionTitle.drawInRect(sectionTitleRect, withAttributes: sectionTitleAttributes)
                contentText.drawInRect(contentRect, withAttributes: contentAttributes)
                
                theNextSectionSpacing += spacing
            }
            
            UIGraphicsEndPDFContext()
            
        } else { fatalError("Somehow not even \"\" was returned for RoomsCache.shared.findRoom(kHome).userText") }
    }
    
    func drawInHeaders(businessName: String) {
        let leftHeadingRect: CGRect = CGRectMake(10, 20, 150, 50)
        let centerHeadingRect: CGRect = CGRectMake(240, 20, 360, 50)
        let rightHeadingRect: CGRect = CGRectMake(pageSize.width-200, 20, 190, 50)
        let businessNameRect: CGRect = CGRectMake(0, 80, pageSize.width, 50)
        
        guard let headingParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("1") }
        headingParagraphStyle.alignment = .Center
        let headingAttributes = [NSFontAttributeName : normalFont, NSParagraphStyleAttributeName : headingParagraphStyle]
        let businessNameAttrib = [NSFontAttributeName : H1Font, NSParagraphStyleAttributeName : headingParagraphStyle]
        
        let dateString = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, \nMMMM d yyyy"
        let formattedDateString: NSString = dateFormatter.stringFromDate(dateString)
        
        let businessHeader: NSString = "\(businessName) Business Model - Page \(Int(numOfPages)+1)"
        
        formattedDateString.drawInRect(leftHeadingRect, withAttributes: headingAttributes)
        businessHeader.drawInRect(centerHeadingRect, withAttributes: headingAttributes)
        self.userName.drawInRect(rightHeadingRect, withAttributes: headingAttributes)
        
        NSString(string: businessName).drawInRect(businessNameRect, withAttributes: businessNameAttrib)

    }
    
}





