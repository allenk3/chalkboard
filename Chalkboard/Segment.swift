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
    // Complete line for segment
    var completeLine : UIBezierPath
    
    
    // Straight line initializer
    init(_ point1: CGPoint, _ point2: CGPoint) {
        // make completed line
        completeLine = UIBezierPath()
        completeLine.move(to: point1)
        completeLine.addLine(to: point2)
        var newStart : CGPoint = point1
        var newEnd : CGPoint
        // Populate lines based on if segment is curved or straight.
        for percent in stride(from: 0.1, through: 1.0, by: Config.straightSegmentLinePercent) {
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
        for percent in stride(from: Config.curvedSegmentLinePercent, through: 1.0, by: Config.curvedSegmentLinePercent) {
            //get next point and make line
            endPoint = Segment.pointBetweenArc(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise, percentBetween: percent)
            lines.append(Line(start: startPoint, end: endPoint))
            startPoint = endPoint
        }
    }
    
    // Initializer for segment with 1 straight Line, curve, another straight line
    init(startLineStart: CGPoint, startLineEnd: CGPoint, centerPoint: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, endLineStart: CGPoint, endLineEnd: CGPoint) {
        // Add the complete line in order
        completeLine = UIBezierPath()
        let firstLine = UIBezierPath()
        let lastLine = UIBezierPath()
        
        firstLine.move(to: startLineStart)
        firstLine.addLine(to: startLineEnd)
        lastLine.move(to: endLineStart)
        lastLine.addLine(to: endLineEnd)
        completeLine.append(firstLine)
        completeLine.append(UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise))
        completeLine.append(lastLine)
        
        // Iterate through start line
        var newStart : CGPoint = startLineStart
        var newEnd : CGPoint
        // Populate lines
        for percent in stride(from: 0.1, through: 1.0, by: Config.straightSegmentLinePercent) {
            //get next point and make line
            newEnd = Segment.pointBetweenLine(point1: startLineStart, point2: startLineEnd, percentBetween: percent)
            lines.append(Line(start: newStart, end: newEnd))
            newStart = newEnd
        }
        
        // Iterate through curve
        newStart = Segment.pointBetweenArc(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise, percentBetween: 0.0)
        for percent in stride(from: Config.curvedSegmentLinePercent, through: 1.0, by: Config.curvedSegmentLinePercent) {
            //get next point and make line
            newEnd = Segment.pointBetweenArc(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise, percentBetween: percent)
            lines.append(Line(start: newStart, end: newEnd))
            newStart = newEnd
        }
        
        newStart = endLineStart
        // Iterate through end line
        for percent in stride(from: 0.1, through: 1.0, by: Config.straightSegmentLinePercent) {
            //get next point and make line
            newEnd = Segment.pointBetweenLine(point1: endLineStart, point2: endLineEnd, percentBetween: percent)
            lines.append(Line(start: newStart, end: newEnd))
            newStart = newEnd
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
    
    func getNumLines() -> Int {
        return lines.count
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
        
        // Calculate angle of new point
        var newAngle : CGFloat
        if clockwise {
            newAngle = startAngle + abs(endAngle - startAngle) * CGFloat(percentBetween)
        }else {
            newAngle = startAngle - abs(endAngle - startAngle) * CGFloat(percentBetween)
        }
        let zone = floor(newAngle/(CGFloat.pi/2))

        
        // Calculate zone of reference angle by dividing by 90 degrees or 1.5708 radians
        
        //print("Zone: ")
        //print(zone)
        // Calculate reference angle and set booleans for negatives
        switch zone {
        case 3:
            // Calculate x
            x = radius * cos(newAngle)
            print(radius)
            
            // Calculate y
            y = radius * sin(newAngle)
            //print("x")
            //print(x)
            //print("y: ")
            //print(y)
        case 2:
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
            //print("x")
            //print(x)
            //print("y: ")
            //print(y)
        case 1:
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
            //print("x")
            //print(x)
            //print("y: ")
            //print(y)
        case 0:
            // Calculate x
            x = radius * cos(newAngle)
            // Calculate y
            y = radius * sin(newAngle)
            //print("x")
            //print(x)
            //print("y: ")
            //print(y)
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

    // Get the closest line index and percent of line completed
    // Returns (lineIndex, percentComplete)
    // lineIndex == nil if further away from line then configuration
    // lineIndex == -1 if last line index
    // percentComplete == nil if further away from line than configuration
    func getClosestIndexWith(activeIndex index : Int, point : CGPoint) -> (Int?, Double?) {
        // Placeholder variables
        // Keep track of final index used to see if it is the final line
        var finalIndex : Int = index
        // Index will be used to walk up and down the lines nearest to the current line
        var nextIndex = index + 1
        // Reset next index based on position in array
        nextIndex = nextIndex >= lines.count ? lines.count-1 : nextIndex
        // The closest known line
        // If index == -1, then its the last line
        var closestLine = lines[index == -1 ? lines.count-1 : index]
        // The line that will be compared to
        var nextLine = lines[nextIndex]
        // Each distance will be a totalling of the distance from the given point to the start added to the distance from the given point to the end point.
        var currentDistance = Line.distanceBetween(point1: closestLine.end, point2: point) + Line.distanceBetween(point1: closestLine.start, point2: point)
        var nextDistance = Line.distanceBetween(point1: nextLine.end, point2: point) + Line.distanceBetween(point1: nextLine.start, point2: point)
        // percent complte
        var percentComplete : Double? = nil
        
        // First compare with subsequent lines afte current index
        while  currentDistance > nextDistance {
            // Set closest line to next line
            closestLine = nextLine
            // set the final index
            finalIndex = nextIndex
            // Increment index
            nextIndex += 1
            // Set next line
            // If it is the last line, cant look any higher -> break
            if lines.count <= nextIndex {
                break
            }
            nextLine = lines[nextIndex]
            // Get next distances
            currentDistance = Line.distanceBetween(point1: closestLine.end, point2: point) + Line.distanceBetween(point1: closestLine.start, point2: point)
            nextDistance = Line.distanceBetween(point1: nextLine.end, point2: point) + Line.distanceBetween(point1: nextLine.start, point2: point)
            
        }
        
        // Reset nextIndex, but in the downward direction
        nextIndex = index - 1
        if nextIndex < 0 {
            nextIndex = 0
        }
        // Set next line to the next index
        nextLine = lines[nextIndex]
        nextDistance = Line.distanceBetween(point1: nextLine.end, point2: point) + Line.distanceBetween(point1: nextLine.start, point2: point)
        // Loop to check the downward direction
        while currentDistance > nextDistance {
            // Set closest line to next line
            closestLine = nextLine
            // Set the final index
            finalIndex = nextIndex
            // Increment index
            nextIndex -= 1
            // Set next line
            // If it is the the first line, just keep set at 0
            if nextIndex <= 0 {
                nextIndex = 0
            }
            nextLine = lines[nextIndex]
            // Get next indexes
            currentDistance = Line.distanceBetween(point1: closestLine.end, point2: point) + Line.distanceBetween(point1: closestLine.start, point2: point)
            nextDistance = Line.distanceBetween(point1: nextLine.end, point2: point) + Line.distanceBetween(point1: nextLine.start, point2: point)
            
        }
        
        // Check to see if nearest distance is within limit
        // nil indicates reset the shape with currently completed segments drawn
        if closestLine.distanceTo(point: point) > Config.distanceLimit {
            return (nil, nil)
        }
        
        // Check if it is the last line in the segment
        // -1 represents that the segment is complete. Should have returned in loop in this case, but just in case
        if finalIndex == (lines.count-1) {
            percentComplete = closestLine.percentCompleteWith(point: point)
            return (-1, percentComplete)
        }
        percentComplete = closestLine.percentCompleteWith(point: point)
        return (finalIndex, percentComplete)
    }
    
    // Function to get the starting point of the Line segment
    func getStartingPoint() -> CGPoint {
        return lines[0].start
    }
    
    // Function to get the ending point of the Line segment
    func getEndingPoint() -> CGPoint {
        return lines[lines.count-1].end
    }
    
    
    var description: String {
        var string : String = ""
        for line in lines {
            string = string + line.description
        }
        return string
    }
    
}
