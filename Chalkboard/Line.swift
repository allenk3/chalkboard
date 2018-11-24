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
        // Check for horizontal line
        if start.y == end.y {
            // Calculate and return distance
            return Double(abs(point.y-start.y))
        }
        
        // Check for vertical line
        if start.x == end.x {
            return Double(abs(point.x-start.x))
        }
        
        
        let numerator = abs((self.end.y - self.start.y)*point.x - (self.end.x-self.start.x)*point.y + self.end.x*self.start.y - self.end.y*self.start.x)
        let denominator = sqrt(pow((self.end.y-self.start.y), 2) + pow((self.end.x-self.start.x), 2))
        return Double(numerator/denominator)
    }
    
    // Equation to calculate slope of line
    func slope() -> Double {
        return Double((end.y - start.y)/(end.x - start.x))
    }
    
    // Equation to calculate closest point on line from a point
    // Equation taken from stackOverflow as sudo code
    func getClosestPoint(from point: CGPoint) -> CGPoint {
        // Vector from start point to point
        let a_to_p = [point.x - start.x, point.y - start.y]
        // Vector from start point to end point
        let a_to_b = [end.x - start.x, end.y - start.y]
        
        // Square a_to_b
        let atb_squared = pow(a_to_b[0], 2) + pow(a_to_b[1], 2)
        
        // Dot product of a_to_p and a_to_b
        let atp_dot_atb = a_to_p[0]*a_to_b[0] + a_to_p[1]*a_to_b[1]
        
        // The normalized distance from start to the closest point
        let t = atp_dot_atb / atb_squared
        
        // Return new point
        return CGPoint(x: (start.x + a_to_b[0]*t),
                       y: start.y + a_to_b[1]*t)
        
    }
    
    func percentCompleteWith(point: CGPoint) -> Double {
        // Get the point on the line nearest to the given point
        let nearestPointOnLine = self.getClosestPoint(from: point)
        // Get the length to that nearest point from the start point
        let lengthToNearestPointOnLine = Line.distanceBetween(point1: self.start, point2: nearestPointOnLine)
        // Get the total length of the line
        let totalLengthOfLine = Line.distanceBetween(point1: self.start, point2: self.end)
        // Calculate the percentage of the line completed
        let percentComplete = lengthToNearestPointOnLine/totalLengthOfLine
        return percentComplete
    }
    
    
    
    // Static functions
    
    // Function to return the distance between two points
    static func distanceBetween(point1 : CGPoint, point2 : CGPoint) -> Double {
        return Double(sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2)))
    }
    
}
