//
//  ChalkboardModel.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/11/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation

class ChalkboardModel {
    
    // shared instance
    static let shared = ChalkboardModel()
    
    // stored properties
    var writeables: [[Writeable]] = [[]]
    var selectedSet: Int
    var selectedShape: Int?
    
    // initializers
    init () {
        writeables[0] = [
            Writeable(title: "A", segments: []),
            Writeable(title: "B", segments: []),
            Writeable(title: "C", segments: []),
            Writeable(title: "D", segments: []),
            Writeable(title: "E", segments: []),
            Writeable(title: "F", segments: []),
            Writeable(title: "G", segments: []),
            Writeable(title: "H", segments: []),
            Writeable(title: "I", segments: []),
            Writeable(title: "J", segments: []),
            Writeable(title: "K", segments: []),
            Writeable(title: "L", segments: []),
            Writeable(title: "M", segments: []),
            Writeable(title: "N", segments: []),
            Writeable(title: "O", segments: []),
            Writeable(title: "P", segments: []),
            Writeable(title: "Q", segments: []),
            Writeable(title: "R", segments: []),
            Writeable(title: "S", segments: []),
            Writeable(title: "T", segments: []),
            Writeable(title: "U", segments: []),
            Writeable(title: "V", segments: []),
            Writeable(title: "W", segments: []),
            Writeable(title: "X", segments: []),
            Writeable(title: "Y", segments: []),
            Writeable(title: "Z", segments: [])
        ]
        writeables.append([
            Writeable(title: "0", segments: []),
            Writeable(title: "1", segments: []),
            Writeable(title: "2", segments: []),
            Writeable(title: "3", segments: []),
            Writeable(title: "4", segments: []),
            Writeable(title: "5", segments: []),
            Writeable(title: "6", segments: []),
            Writeable(title: "7", segments: []),
            Writeable(title: "8", segments: []),
            Writeable(title: "9", segments: [])
        ])
        selectedSet = 0
        selectedShape = nil
    }
    
    // computed properties
    var writeableCount: Int {
        return writeables[selectedSet].count
    }
    
    // methods
    func getSelectedShape () -> Writeable {
        if let selectedShape = selectedShape {
            return writeables[selectedSet][selectedShape]
        }
        selectRandom()
        return writeables[selectedSet][selectedShape!]
    }
    
    func getWriteableAt (index: Int) -> Writeable {
        return writeables[selectedSet][index]
    }
    
    func randFromZero (to number: Int) -> Int {
        // return random Int between 0 and Int (exclusive)
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func setSelectedSet (to ndx: Int) {
        selectedSet = ndx
        selectedShape = nil
    }
    
    func setSelectedShape (to ndx: Int) {
        selectedShape = ndx
    }
    
    func selectPrevious () {
        if var selectedShape = selectedShape {
            if selectedShape == 0 {
                selectedShape = writeableCount
            }
            selectedShape -= 1
            self.selectedShape = selectedShape
        } else {
            selectedShape = 0
        }
    }
    
    func selectNext () {
        if var selectedShape = selectedShape {
            selectedShape += 1
            self.selectedShape = selectedShape % writeableCount
        } else {
            selectedShape = 0
        }
    }
    
    func selectRandom () {
        selectedShape = randFromZero(to: writeableCount)
    }
    
    func selectRandomLetter () {
        setSelectedSet(to: 0)
        selectRandom()
    }
    
    func selectRandomNumber () {
        setSelectedSet(to: 1)
        selectRandom()
    }
}
