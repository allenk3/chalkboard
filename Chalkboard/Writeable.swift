//
//  Writeable.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/11/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

class Writeable {
    
    // nested structure
    
    @IBOutlet weak var textLabel: UILabel!
    
    // stored properties
    let title: String
    var segments: [Segment]
    var pathSet = false
    
    // initializers
    init (title: String, segments: [Segment]) {
        self.title = title
        self.segments = segments
    }
    
    func setShapePath(frame: CGRect) {
        switch title {
        case "A":
            if !pathSet {
                // Get points
                let point1 = CGPoint(x: frame.size.width/8, y: frame.size.height-Config.shapeDistanceFromBottom)
                let point3 = CGPoint(x: frame.size.width/2, y: 10)
                let point5 = CGPoint(x: frame.size.width - (frame.size.width/8), y: frame.size.height-Config.shapeDistanceFromTop)
                let point2 = Segment.pointBetweenLine(point1: point3, point2: point1, percentBetween: 0.45)
                let point4 = Segment.pointBetweenLine(point1: point3, point2: point5, percentBetween: 0.45)
                
                // Get Segments and add to segments
                segments.append(Segment(point1, point3))
                segments.append(Segment(point3, point5))
                segments.append(Segment(point2, point4))
                // set boolean for object
                pathSet = true
            }
        case "B":
            if !pathSet {
                // Get top and bottom point
                let point1 = CGPoint(x: frame.size.width/3, y: frame.size.height-Config.shapeDistanceFromBottom)
                let point4 = CGPoint(x: frame.size.width/3, y: Config.shapeDistanceFromTop)
                // Get center point
                let centerpoint = Segment.pointBetweenLine(point1: point1, point2: point4, percentBetween: 0.5)
                // Get top arc center
                var point3 = Segment.pointBetweenLine(point1: point4, point2: centerpoint, percentBetween: 0.5)
                // Get bottom arc center
                var point2 = Segment.pointBetweenLine(point1: point1, point2: centerpoint, percentBetween: 0.5)
                // Get radius, which is the length between center point and either arc point
                let radius = Line.distanceBetween(point1: point3, point2: centerpoint)
                
                // Extend curves to the right 10-15 starting on bottom left
                // Bottom line
                let ext_10 = point1
                let ext_11 = CGPoint(x: ext_10.x+Config.bExtention, y: ext_10.y)
                // Middle line
                let ext_12 = centerpoint
                let ext_13 = CGPoint(x: ext_12.x+Config.bExtention, y: ext_12.y)
                // Top line
                let ext_14 = point4
                let ext_15 = CGPoint(x: ext_14.x+Config.bExtention, y: ext_14.y)
                
                // Adjust centerpoints for arcs
                point3 = CGPoint(x: point3.x+Config.bExtention, y: point3.y)
                point2 = CGPoint(x: point2.x+Config.bExtention, y: point2.y)
                
                // Get Segments and add to segments
                segments.append(Segment(point4, point1))
                
                segments.append(Segment(startLineStart: ext_14, startLineEnd: ext_15, centerPoint: point3, radius: CGFloat(radius), startAngle: CGFloat.pi*1.5, endAngle: CGFloat.pi/2, clockwise: true, endLineStart: ext_13, endLineEnd: ext_12))
                
                segments.append(Segment(startLineStart: ext_12, startLineEnd: ext_13, centerPoint: point2, radius: CGFloat(radius), startAngle: CGFloat.pi*1.5, endAngle: CGFloat.pi/2, clockwise: true, endLineStart: ext_11, endLineEnd: ext_10))
                // set boolean for object
                pathSet = true
            }
            
        case "C":
            if !pathSet {
                let centerpoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
                let radius = frame.size.width/2.2
                segments.append(Segment(centerPoint: centerpoint, radius: radius, startAngle: CGFloat.pi*7/4, endAngle: CGFloat.pi/4, clockwise: false))
                
                pathSet = true
            }
        
            
        case "0":
            if !pathSet {
                let centerpoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
                let radius = frame.size.width/2.2
                segments.append(Segment(centerPoint: centerpoint, radius: radius, startAngle: CGFloat.pi*2, endAngle: 0, clockwise: false))
                
                pathSet = true
            }
            
            
        case "1":
            if !pathSet {
                let bottomLineLength = frame.size.width/2.3
                let point1 = CGPoint(x: frame.size.width/2, y: frame.size.height - Config.shapeDistanceFromBottom)
                let point2 = CGPoint(x: frame.size.width/2, y: Config.shapeDistanceFromTop)
                let point3 = CGPoint(x: point2.x-bottomLineLength/2, y: point2.y+bottomLineLength/2)
                let point4 = CGPoint(x: point1.x-bottomLineLength/2, y: frame.size.height - Config.shapeDistanceFromBottom)
                let point5 = CGPoint(x: point1.x+bottomLineLength/2, y: frame.size.height - Config.shapeDistanceFromBottom)
                
                segments.append(Segment(point3, point2))
                segments.append(Segment(point2, point1))
                segments.append(Segment(point4, point5))
                pathSet = true
            }
            
        case "2":
            if !pathSet {
                let bottomLineLength = frame.size.width/2
                let radius = bottomLineLength/2
                // Get the top arc point for the '2'
                let topArcPoint = CGPoint(x: frame.size.width/2, y: Config.shapeDistanceFromTop + radius)
                let arcEndPoint = Segment.pointBetweenArc(arcCenter: topArcPoint, radius: radius, startAngle: 5*CGFloat.pi/4, endAngle: CGFloat.pi/4, clockwise: true, percentBetween: 1.00)
                let bottomLineStartPoint = CGPoint(x: frame.size.width/4, y: (frame.size.height - Config.shapeDistanceFromBottom))
                let bottomLineEndPoint = CGPoint(x: (frame.size.width/4) + bottomLineLength, y: frame.size.height - Config.shapeDistanceFromBottom)

                // first segment will consist of a curve and a straight line
                segments.append(Segment(centerPoint: topArcPoint, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi/4, clockwise: true, endLineStart: arcEndPoint, endLineEnd: bottomLineStartPoint))
                // Second segment will just be a line
                segments.append(Segment(bottomLineStartPoint, bottomLineEndPoint))
                pathSet = true
            }
            
        default:
            print("Error in shape")
        }
    }
    
    func getSegments() -> [Segment] {
        return segments
    }
    
    func getSegment(at index: Int) -> Segment? {
        if segments.count > index {
            return segments[index]
        }
        return nil
        
    }
    
    func getNumSegments() -> Int {
        return segments.count
    }
    
    
    /******** HELPER FUNCTIONS *********/
}
