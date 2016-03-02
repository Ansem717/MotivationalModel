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
    
    func printContents() {
        var current: NavigationStackRoom? = head
        
        print("--START--")
        while current != nil {
            print("\(current!.key!)")
            current = current!.next
        }
        print("--END--\n")
    }
    
    func addRoomToNavigationStack(key: String) {
        if self.isEmpty() {
            head.key = key
            return
        }
        var current: NavigationStackRoom? = head
        
        if key == findCurrentRoomInNavStack() {
            return //User is now unable to re-visit the room they are already in (using Menu -> Home / Goto)
        }
        
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
            return
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
            return kHome
        }
        var current: NavigationStackRoom? = head
        
        while current != nil{
            if current?.next == nil {
                guard let currentKey = current?.key else { fatalError() }
                return currentKey
            } else {
                current = current?.next
            }
        }
        print("");print("ERROR - Nav Stack - Current is nil - \(__FUNCTION__)");print("");print("");
        return kHome
    }
    
    func findPreviousRoomInNavStack() -> String {
        if self.isEmpty() {
            return "EMPTY"
        }
        
        var current: NavigationStackRoom? = head
        
        while current != nil{
            if current?.next == nil {
                guard let prevKey = current?.prev?.key else { fatalError() }
                return prevKey
            } else {
                current = current?.next
            }
        }
        print("");print("ERROR - Nav Stack - Current is nil - \(__FUNCTION__)");print("");print("");
        return kHome
        
    }
    
    func count() -> Int {
        if self.isEmpty() {
            return 0
        }
        
        var current: NavigationStackRoom? = head
        var index: Int = 0
        
        while current != nil {
            index++
            current = current!.next
        }
        
        return index
        
    }
    
}











