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
    
    init(userName: NSString) {
        self.userName = userName
    }
    
    func generatePDF() {
        let pageSize: CGSize = CGSizeMake(850, 1100)     // 8 ½ by 11 paper? So I've been told...
        let sentenceWidth = 160
        
        if let businessName = RoomsCache.shared.findRoom(kHome).userText {
            
            //MARK: Create file path in this app's unique directory
            let dashedBusinessName = businessName.stringByReplacingOccurrencesOfString(" ", withString: "-")
            let fileName = "\(dashedBusinessName)-Business-Model.pdf"
            let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectory = path.objectAtIndex(0)
            let pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
            print("")
            print("==========================================");print(pdfPathWithFileName);print("==========================================")
            print("")
            
            //MARK: Needed for PDF Creation. Defines size of file based on pageSize constant above.
            UIGraphicsBeginPDFContextToFile(pdfPathWithFileName, CGRectZero, nil)
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil)
            
            //MARK: Define font-types - H1 is used for the Business Name, H2 is used for Section headers and Normal is used for everything else
            let normalFont: UIFont = UIFont(name: "Helvetica", size: 14) ?? UIFont.systemFontOfSize(14)
            let H1Font: UIFont = UIFont(name: "Helvetica", size: 39) ?? UIFont.systemFontOfSize(22)
            let H2Font: UIFont = UIFont(name: "Helvetica", size: 20) ?? UIFont.systemFontOfSize(18)
            
            
            //MARK: Define area for Left Heading (Date), Center Heading (Name of Business Model) and Right Heading (User's real name)
            let leftHeadingRect: CGRect = CGRectMake(10, 20, 150, 50)
            let centerHeadingRect: CGRect = CGRectMake(240, 20, 360, 50)
            let rightHeadingRect: CGRect = CGRectMake(pageSize.width-200, 20, 190, 50)
            
            //MARK: Specify Formatting for all headings. Only one format change necessary: alignment to Center
            guard let headingParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("1") }
            headingParagraphStyle.alignment = .Center
            let headingAttributes = [NSFontAttributeName : normalFont, NSParagraphStyleAttributeName : headingParagraphStyle]
            
            //MARK: Create Date String, and format it for professionality
            let dateString = NSDate().description
            let dateStringArray = dateString.componentsSeparatedByString(" ").first!.componentsSeparatedByString("-")
            let year = dateStringArray[0]
            let month = monthFinder(dateStringArray[1])
            let day = findDayPrefix(dateStringArray[2])
            let formattedDateString: NSString = "\(month) \(day), \(year)"
            
            let businessHeader: NSString = "\(businessName) Business Model - Page 1"
            
            //MARK:  'Draw' in the text to their specified areas.
            formattedDateString.drawInRect(leftHeadingRect, withAttributes: headingAttributes)
            businessHeader.drawInRect(centerHeadingRect, withAttributes: headingAttributes)
            self.userName.drawInRect(rightHeadingRect, withAttributes: headingAttributes)
            
            //MARK: Define rect for large centered business name.
            let businessNameRect: CGRect = CGRectMake(0, 80, pageSize.width, 50)
            
            //MARK: Specify formatting for this header - uses same headingParagraphStyle as above (line 50)
            let businessNameAttrib = [NSFontAttributeName : H1Font, NSParagraphStyleAttributeName : headingParagraphStyle]
            
            //MARK: Create String to NSString and Draw it in
            NSString(string: businessName).drawInRect(businessNameRect, withAttributes: businessNameAttrib)
            
            
            var theNextSectionSpacing: CGFloat = 0
            var numOfPages: CGFloat = 0
            var theNextPageSpacing: CGFloat = 0
            
            //MARK: Now comes the fun part. We iterate through each room and print it's title and information.
            for var ii = 1; ii < RoomsCache.shared.rooms.count; ii++ {
                guard let contentString = RoomsCache.shared.rooms[ii].userText else { fatalError("4") }
                
                let numberOfChars = contentString.characters.count
                let numberOfLines = CGFloat(numberOfChars/sentenceWidth)
                let pointsPerLine: CGFloat = 33.0
                
                let spacing = pointsPerLine * numberOfLines
                
                //MARK: Prepare! We need a consistant distance between text.
                var yPosSection = CGFloat(ii*90) + 70.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                var yPosContent = CGFloat(ii*90) + 103.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                
                if yPosContent+spacing >= pageSize.height-70 {
                    //MARK: Looks like our content has been pushed off the page. NEW PAGE!
                    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil)
                    
                    numOfPages++
                    theNextPageSpacing += pageSize.height - yPosSection + 140.0
                    
                    yPosSection = CGFloat(ii*90) + 70.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                    yPosContent = CGFloat(ii*90) + 103.0 + (theNextSectionSpacing * 0.77) - (pageSize.height * numOfPages) + theNextPageSpacing
                    
                    
                    //MARK: Reprint Headers on new page
                    
                        //Define area for Left Heading (Date), Center Heading (Name of Business Model) and Right Heading (User's real name)
                        let leftHeadingRect: CGRect = CGRectMake(10, 20, 150, 50)
                        let centerHeadingRect: CGRect = CGRectMake(240, 20, 360, 50)
                        let rightHeadingRect: CGRect = CGRectMake(pageSize.width-200, 20, 190, 50)
                        
                        //Specify Formatting for all headings. Only one format change necessary: alignment to Center
                        guard let headingParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("1") }
                        headingParagraphStyle.alignment = .Center
                        let headingAttributes = [NSFontAttributeName : normalFont, NSParagraphStyleAttributeName : headingParagraphStyle]
                        
                        //Create Date String, and format it for professionality
                        let dateString = NSDate().description
                        let dateStringArray = dateString.componentsSeparatedByString(" ").first!.componentsSeparatedByString("-")
                        let year = dateStringArray[0]
                        let month = monthFinder(dateStringArray[1])
                        let day = findDayPrefix(dateStringArray[2])
                        let formattedDateString: NSString = "\(month) \(day), \(year)"
                        
                        let businessHeader: NSString = "\(businessName) Business Model - Page \(Int(numOfPages)+1)"
                        
                        // 'Draw' in the text to their specified areas.
                        formattedDateString.drawInRect(leftHeadingRect, withAttributes: headingAttributes)
                        businessHeader.drawInRect(centerHeadingRect, withAttributes: headingAttributes)
                        self.userName.drawInRect(rightHeadingRect, withAttributes: headingAttributes)
                        
                        //Define rect for large centered business name.
                        let businessNameRect: CGRect = CGRectMake(0, 80, pageSize.width, 50)
                        
                        //Specify formatting for this header - uses same headingParagraphStyle as above (line 50)
                        let businessNameAttrib = [NSFontAttributeName : H1Font, NSParagraphStyleAttributeName : headingParagraphStyle]
                        
                        //Create String to NSString and Draw it in
                        NSString(string: businessName).drawInRect(businessNameRect, withAttributes: businessNameAttrib)
                    
                    //MARK: END Header Reprint
                }
                
                //MARK: 1) Define rect
                let sectionTitleRect: CGRect = CGRectMake(50, yPosSection, pageSize.width-100, 50)
                let contentRect: CGRect = CGRectMake(100, yPosContent, pageSize.width-200, spacing+50)
                
                //MARK: 2) Specify Formatting
                guard let sectionTitleParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("2") }
                sectionTitleParagraphStyle.lineBreakMode = .ByWordWrapping
                sectionTitleParagraphStyle.alignment = .Left
                let sectionTitleAttributes = [NSFontAttributeName : H2Font, NSParagraphStyleAttributeName : sectionTitleParagraphStyle]
                
                guard let contentParagraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle else { fatalError("3") }
                contentParagraphStyle.lineBreakMode = .ByWordWrapping
                contentParagraphStyle.alignment = .Left
                let contentAttributes = [NSFontAttributeName : normalFont, NSParagraphStyleAttributeName : contentParagraphStyle]
                
                //MARK: 3) Create NSString
                let sectionTitle: NSString = "  \(RoomsCache.shared.rooms[ii].title)"
                let contentText: NSString = "\(Icons.shared.bullet)\t\(contentString)"
                
                //MARK: 4) Draw the text! HERE GOES!
                sectionTitle.drawInRect(sectionTitleRect, withAttributes: sectionTitleAttributes)
                contentText.drawInRect(contentRect, withAttributes: contentAttributes)
                
                
                theNextSectionSpacing += spacing
                
            }
            
            UIGraphicsEndPDFContext()
            
        } else { fatalError("Somehow not even \"\" was returned for RoomsCache.shared.findRoom(kHome).userText") }
    }
    
    func monthFinder(numberInFormOfString: String) -> String {
        switch numberInFormOfString {
        case "01":
            return "Janurary"
        case "02":
            return "Feburary"
        case "03":
            return "March"
        case "04":
            return "April"
        case "05":
            return "May"
        case "06":
            return "June"
        case "07":
            return "July"
        case "08":
            return "August"
        case "09":
            return "September"
        case "10":
            return "October"
        case "11":
            return "November"
        case "12":
            return "December"
        default:
            return numberInFormOfString
        }
    }

    func findDayPrefix(numberInFormOfString: String) -> String {
        switch numberInFormOfString {
        case "01":
            return "1st"
        case "02":
            return "2nd"
        case "03":
            return "3rd"
        case "04":
            return "4th"
        case "05":
            return "5th"
        case "06":
            return "6th"
        case "07":
            return "7th"
        case "08":
            return "8th"
        case "09":
            return "9th"
        default:
            return "\(numberInFormOfString)th"
        }
    }
    
    
}




















