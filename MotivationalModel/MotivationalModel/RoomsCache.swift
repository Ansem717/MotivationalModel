//
//  RoomData.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

//MARK: Room Constants - Titles of rooms, used to mark each Room with a 'key' as to reference the room with the constant.
let kHome = "Home" //isn't really a room. Not sure how I'm going to apply the Home Page to the navigation stack!
let kValueProp = "Value Proposition"         // VP -> RC, CN
let kRequiredComp = "Required Competency"    // RC -> VP, R/A, PT, P&S
let kCustomerNeeds = "Customer Needs"        // CN -> CT, P&S, VP
let kProdAndServ = "Products And Services"   //P&S -> CN, C, CT, RCI
let kChannels = "Channels"                   //  C -> P&S, C&R, CT, G&L, PT
let kResourceAsset = "Resource / Asset"      //R/A -> RC, C&R
let kPartnerType = "Partner Type"            // PT -> C&R, G&L, C, RC
let kGeoAndLocal = "Geographies And Locales" //G&L -> PT, C
let kCustomerType = "Customer Type"          // CT -> C, P&S, CN
let kCostAndRev = "Cost And Revenue"         //C&R -> R/A, C, PT

class RoomsCache { //Singleton to form the rooms - permanently
    
    static let shared = RoomsCache()
    private init() {}
    
    var rooms = [
        Room(title: kHome, subtitle: "", descript: "", buttons: [kValueProp]),
        Room(title: kValueProp, subtitle: "", descript: "", buttons: [kRequiredComp, kCustomerNeeds]),
        Room(title: kRequiredComp, subtitle: "", descript: "", buttons: [kValueProp, kResourceAsset, kPartnerType, kProdAndServ]),
        Room(title: kCustomerNeeds, subtitle: "", descript: "", buttons: [kCustomerType, kProdAndServ, kValueProp]),
        Room(title: kProdAndServ, subtitle: "", descript: "", buttons: [kCustomerNeeds, kChannels, kCustomerType, kRequiredComp]),
        Room(title: kChannels, subtitle: "", descript: "", buttons: [kCostAndRev, kProdAndServ, kCustomerType, kGeoAndLocal, kPartnerType]),
        Room(title: kResourceAsset, subtitle: "", descript: "", buttons: [kRequiredComp, kCostAndRev]),
        Room(title: kPartnerType, subtitle: "", descript: "", buttons: [kCostAndRev, kGeoAndLocal, kChannels, kRequiredComp]),
        Room(title: kGeoAndLocal, subtitle: "", descript: "", buttons: [kPartnerType, kChannels]),
        Room(title: kCustomerType, subtitle: "", descript: "", buttons: [kChannels, kProdAndServ, kCustomerNeeds]),
        Room(title: kCostAndRev, subtitle: "", descript: "", buttons: [kResourceAsset, kChannels, kPartnerType])
    ]
    
    
    
}

















