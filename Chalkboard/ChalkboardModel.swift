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
    var writeables: [String: [Writeable]] = [:]
    var selectedSet: String
    
    // initializers
    init () {
        writeables["letters"] = [
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
        writeables["numbers"] = [
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
        ]
        selectedSet = "numbers"
    }
    
    // computed properties
    var writeableCount: Int {
        return writeables[selectedSet]!.count
    }
    
    // methods
    func getWriteableAt (index: Int) -> Writeable {
        return writeables[selectedSet]![index]
    }
    
    func getRandInt (to: Int) -> Int {
        // return random Int between 0 and Int (exclusive)
        return 0
    }
    
    func getRandomWriteable () -> Writeable {
        return writeables[selectedSet]![getRandInt (to: writeableCount)]
    }
    
}
