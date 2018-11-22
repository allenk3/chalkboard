//
//  Segment.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/21/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

class Segment : CustomStringConvertible {
    
    
    var lines : [Line] = []
    //complete line for 
    var completeLine : UIBezierPath

    
    // Straight line initializer
    init(_ point1: CGPoint, _ point2: CGPoint) {
        // make completed line
        completeLine = UIBezierPath()
        completeLine.move(to: point1)
        completeLine.addLine(to: point2)
        var newStart : CGPoint = point1
        var newEnd : CGPoint
        for percent in stride(from: 0.1, through: 1.0, by: 0.1) {
            //get next point and make line
            newEnd = Segment.pointBetweenLine(point1: point1, point2: point2, percentBetween: percent)
            lines.append(Line(start: newStart, end: newEnd))
            newStart = newEnd
        }
    }
    // Circle initializer
    init(centerPoint: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        completeLine = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        var startPoint : CGPoint = Segment.pointBetweenArc(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise, percentBetween: 0.0)
        var endPoint : CGPoint
        for percent in stride(from: 0.1, through: 0.9, by: 0.05) {
            //get next point and make line
            endPoint = Segment.pointBetweenArc(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise, percentBetween: percent)
            lines.append(Line(start: startPoint, end: endPoint))
            startPoint = endPoint
        }
    }
    
    
    
    func addLine(_ line : Line) {
        lines.append(line)
    }
    
    func setCompleteLine(with path: UIBezierPath) {
        completeLine = path
    }
    
    func getLines() -> [Line] {
        return lines
    }
    
    func getCompleteLine() -> UIBezierPath {
        return completeLine
    }
    
    /*************** HELPER FUNCTIONS *******************/
    static func pointBetweenLine(point1: CGPoint, point2: CGPoint, percentBetween: Double) ->CGPoint {
        return CGPoint(x: point1.x + (point2.x - point1.x) * CGFloat(percentBetween), y: point1.y + (point2.y - point1.y) * CGFloat(percentBetween))
    }
    
    static func pointBetweenArc(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, percentBetween: Double) -> CGPoint {
        var x : CGFloat
        var y : CGFloat
        
        // Calculate angle from radians to degrees
        let startAngleDegrees = startAngle * 57.2958
        let endAngleDegrees = endAngle * 57.2958
        // Calculate angle of new point
        let newAngle = startAngleDegrees + (endAngleDegrees - startAngleDegrees) * CGFloat(percentBetween)
        let zone = floor(newAngle/90.0)
        // Calculate reference angle and set booleans for negatives
        switch zone {
        case 0:
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
        case 1:
            // Calculate x
            x = -1 * radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
        case 2:
            // Calculate x
            x = -1 * radius * cos(newAngle)
            // Calculate y
            y = -1 * radius * sin(newAngle)
        case 3:
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = -1 * radius * sin(newAngle)
        default:
            //will never call
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
        }
        
        //return new point
        return CGPoint(x: (arcCenter.x + x), y: (arcCenter.y + y))
    }
    
    
    var description: String {
        var string : String = ""
        for line in lines {
            string = string + line.description
        }
        return string
    }
    
}
