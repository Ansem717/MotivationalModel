//
//  RoomData.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

//MARK: Room Constants - Titles of rooms, used to mark each Room with a 'key' as to reference the room with the constant.
let kHome = "Enterprise Business Model" //isn't really a room.
let kValueProp = "Value Proposition"         // VP -> RC, CN
let kRequiredComp = "Required Competency"    // RC -> VP, R/A, PT, P&S
let kCustomerNeeds = "Customer Needs"        // CN -> CT, P&S, VP
let kProdAndServ = "Products And Services"   //P&S -> CN, C, CT, RC
let kChannels = "Channels"                   //  C -> P&S, C&R, CT, G&L, PT
let kResourceAsset = "Resource / Asset"      //R/A -> RC, C&R
let kPartnerType = "Partner Type"            // PT -> C&R, G&L, C, RC
let kGeoAndLocal = "Geographies And Locales" //G&L -> PT, C
let kCustomerType = "Customer Type"          // CT -> C, P&S, CN
let kCostAndRev = "Cost And Revenue"         //C&R -> R/A, C, PT

class RoomsCache { //Singleton to form the rooms - permanently
    
    static let shared = RoomsCache()
    private init()
    {
        guard let data = NSData(contentsOfURL: NSURL.archiveURL()) else { return }
        
        guard let archivedRooms = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Room] else { return }
        
        self.rooms = archivedRooms
    }
    
    var rooms = [
        Room(
            title: kHome,
            subtitle: "",
            abbreviation: "EBM",
            descript: "",
            buttons: [kValueProp]
        ),
        Room(
            title: kValueProp,
            subtitle: "",
            abbreviation: "VP",
            descript: "The central notion of a business model, the value proposition describes how the enterprise, through its activities, adds value to the consumer or marketplace. The Value proposition binds together the notions of customer demands, required competencies, revenue models and business partnerships. It is a statement from the viewpoint of the target customers that informs everyone \"why\" the business' products and services are valuable.",
            buttons: [kRequiredComp, kCustomerNeeds]
        ),
        Room(
            title: kRequiredComp,
            subtitle: "",
            abbreviation: "RC",
            descript: "An area or group of business capabilities where the business must excel in order for this business model to be successful.  This is a general concept, not a specific grouping of business capabilities.  This part of the business model drives the need for specific business unit capabilities to perform at higher-than-average levels of effectiveness and efficiency.",
            buttons: [kValueProp, kResourceAsset, kPartnerType, kProdAndServ]
        ),
        Room(
            title: kCustomerNeeds,
            subtitle: "",
            abbreviation: "CN",
            descript: "The customer needs element describes in precise terms, the motivations that lead specific types of customers to buy or use products and services from the enterprise, and how the enterprise nurtures those motivations through marketing and support activities.  Note that this is not a list of customer types, but rather a list of \"customer value statements\" that one or more types of customers may align to.",
            buttons: [kCustomerType, kProdAndServ, kValueProp]
        ),
        Room(
            title: kProdAndServ,
            subtitle: "",
            abbreviation: "P&S",
            descript: "This element of the business model contains a description of the specific products and/or services offered by the business. It is important to recognize that the specific products or services developed must derive from customer demands in order to effectively provide value. This relationship, between customers demands and the products offered, is the central focus of marketing in many organizations.",
            buttons: [kCustomerNeeds, kChannels, kCustomerType, kRequiredComp]
        ),
        Room(
            title: kChannels,
            subtitle: "",
            abbreviation: "C",
            descript: "This entity represents sales, distribution and communication channels in the business model. Distribution channels are the mechanisms by which the customer's product or service reaches the customer.\n\n\(Icons.shared.bullet)  For products, the distribution channels element will describe the flow of goods from manufacturing to market, including inventory and retailing.\n\n\(Icons.shared.bullet)  For manufacturing organizations, this element also describes the sourcing of parts and construction of the product or products themselves. \n\n\(Icons.shared.bullet)  For services, this element describes the location, management, and provisioning of service resources to the customers on an as-needed basis. Sales channels are the mechanisms by which the product or service is sold to the customer. This typically includes owned retail, owned online, partner retail, partner online, and mobile salesforce.\n\nCommunication channels include the mechanisms by which the product's availability and features are described to the customer.  This includes advertising (TV, Radio, Print, Internet, Mobile, Billboard, Direct mail, In-store, In-partner-store) as well as word of mouth, event promotions, and seminars.",
            buttons: [kCostAndRev, kProdAndServ, kCustomerType, kGeoAndLocal, kPartnerType]
        ),
        Room(
            title: kResourceAsset,
            subtitle: "",
            abbreviation: "R/A",
            descript: "Part of a business model, a resource can represent anything that the business must employ, possess, or control in order to deliver on a required competency.  Examples of a resource may be: \n\n \(Icons.shared.bullet)  a person or group of people able to fulfill a particular role or mission; \n \(Icons.shared.bullet)  a building, office, suite, or store in which some activities are performed;\n \(Icons.shared.bullet)  a physical asset used in the process of fulfilling a capability;\n \(Icons.shared.bullet)  materials or inputs to manufacturing;\n \(Icons.shared.bullet)  inventory of goods to be sold or distributed;\n \(Icons.shared.bullet)  inventory of services ready to be provisioned or provided; cash or equities;\n \(Icons.shared.bullet)  Intellectual Property",
            buttons: [kRequiredComp, kCostAndRev]
        ),
        Room(
            title: kPartnerType,
            subtitle: "",
            abbreviation: "PT",
            descript: "The business partner type describes the relationship between the enterprise and external entities that that cooperate to provide value. Partner types include: suppliers, vendors, sales partners, agents, service providers, distributors, retailers, and value-added resellers. \n\nThese connections can define success for a business by allowing for specific efficiencies of capital, resources, and shared risk. They can also provide a disincentive to competition against a key parther, therefore constraining the activities and strategies of an enterprise.",
            buttons: [kCostAndRev, kGeoAndLocal, kChannels, kRequiredComp]
        ),
        Room(
            title: kGeoAndLocal,
            subtitle: "",
            abbreviation: "G&L",
            descript: "The geographies and locales element describes the specific physical locations and contexts in which the products and services will be offered. This is a critical and necessary part of the business model as it is both enabled by, and directly impacted by, the abilities of various business partners as well as the demands of the customers. Many evaluations of a business model will focus on opportunities to extend the business through the consideration of additional geographies.",
            buttons: [kPartnerType, kChannels]
        ),
        Room(
            title: kCustomerType,
            subtitle: "",
            abbreviation: "CT",
            descript: "A customer type is a segment or grouping of customers based on common attributes, useful for the sake of documenting and describing shared demands, interactions, concerns, or assets.  Examples: \"Large volume distributor,\" \"Merchant Bank,\" \"Small office / home office,\" \"General E-mail user\"",
            buttons: [kChannels, kProdAndServ, kCustomerNeeds]
        ),
        Room(
            title: kCostAndRev,
            subtitle: "",
            abbreviation: "C&R",
            descript: "The cost and revenue models represent both the costs and revenues that are indicated by the business model.  This provides an understanding of what costs that the model requires and the revenues that it will generate from various channels.",
            buttons: [kResourceAsset, kChannels, kPartnerType]
        )
    ]
    
    func currentRoom(roomName: String) -> Room {
        let currRoom_ArrayOfOne = rooms.filter { $0.title == roomName }
        guard let currRoom = currRoom_ArrayOfOne.first else { fatalError("currRoom did not match: \"\(roomName)\"") }
        return currRoom
    }
    
    func saveRoom(textFromUser: String, roomName: String) {
        let currRoom = currentRoom(roomName)
        currRoom.userText = textFromUser //Temporary Save by updating array
        
        NSKeyedArchiver.archiveRootObject(self.rooms, toFile: String.archivePath()) //Save the entire array to NSKeyedArchiver
        
    }
    
}

















