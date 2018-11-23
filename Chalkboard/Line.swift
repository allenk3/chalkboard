//
//  Line.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/18/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

struct Line : CustomStringConvertible{
    var start: CGPoint
    var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }
    
    var description: String {
        return "Start point: " + String(Int(start.x)) + ", " + String(Int(start.y)) + "  End Point: " + String(Int(end.x)) + ", " + String(Int(end.y)) + "\n"
    }
    
    // Equation taken from wikipedia
    func distanceTo(point: CGPoint) -> Double{
        let numerator = abs((self.end.y - self.start.y)*point.x - (self.end.x-self.start.x)*point.y + self.end.x*self.start.y - self.end.y*self.start.x)
        let denominator = sqrt(pow((self.end.y-self.start.y), 2) + pow((self.end.x-self.start.x), 2))
        return Double(numerator/denominator)
    }
    
    // Static functions
    
    // Function to return the distance between two points
    static func distanceBetween(point1 : CGPoint, point2 : CGPoint) -> Double {
        return Double(sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2)))
    }
    
}
