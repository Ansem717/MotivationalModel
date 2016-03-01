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
    
    func contents() {
        var current: NavigationStackRoom? = head
        var index: Int = 0
        
        print("--START--")
        while current != nil {
            print("\(current!.key) at position \(index)")
            index++
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
        print("");print("ERROR CODE 73 - Nav Stack - Current is nil");print("");print("");
        return kHome
    }
    
}











