//
//  Line.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/18/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class Line : CustomStringConvertible{
    var start: CGPoint
    var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }
    
    var description: String {
        return "Start point: " + String(Int(start.x)) + ", " + String(Int(start.y)) + "  End Point: " + String(Int(end.x)) + ", " + String(Int(end.y)) + "\n"
    }
}
