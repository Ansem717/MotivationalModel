//
//  StackedRoomDataStructure.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import Foundation

class NavigationStack {
    
    static let shared = NavigationStack()
    private init() {}
    
    let head = NavigationStackRoom()
    
    func isEmpty() -> Bool {
        return head.key == nil
    }
    
    
    func addRoomToNavigationStack(key: String) {
        if self.isEmpty() {
            head.key = key
            return
        }
        
        var current: NavigationStackRoom? = head
        
        while current != nil {
            if current?.next == nil {
                
                let newRoom = NavigationStackRoom()
                
                newRoom.prev = current
                newRoom.key = key
                current!.next = newRoom
                break
            } else {
                current = current?.next
            }
        }
    }
    
    func removeLastFromNavigationStack() {
        
        if self.isEmpty() {
            return //Can't remove a stack that is empty!
        }
        
        var current: NavigationStackRoom? = head
        
        while current != nil {
            if current?.next == nil {
                
                let parent = current?.prev
                
                current!.key = nil
                current!.prev = nil
                parent!.next = nil
                
                break
            } else {
                current = current?.next
            }
        }
    }
    
    func findCurrentRoomInNavStack() -> String {
        
        if self.isEmpty() {
            return kHome //If the NavStack has nothing in it, then we're on the home page.
        }
        
        var current: NavigationStackRoom? = head
        
        while current != nil{
            if current?.next == nil {
                //Here is last item. Curernt Room should always be last item. All we need to do now is return the key
                
                guard let currentKey = current?.key else { fatalError() }
                
                return currentKey
            } else {
                current = current?.next
            }
        }
        print("");print("");print("ERROR CODE 73 - Nav Stack??");print("");print("");
        return kHome //If the while fails for some reason (it should never fail), then we'll just say our current item is "Home"
    }
    
}











