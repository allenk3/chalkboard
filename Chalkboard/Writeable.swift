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
                let point1 = CGPoint(x: frame.size.width/2.5, y: frame.size.height-Config.shapeDistanceFromBottom)
                let point4 = CGPoint(x: frame.size.width/2.5, y: Config.shapeDistanceFromTop)
                // Get center point
                let centerpoint = Segment.pointBetweenLine(point1: point1, point2: point4, percentBetween: 0.5)
                // Get top arc center
                let point3 = Segment.pointBetweenLine(point1: point4, point2: centerpoint, percentBetween: 0.5)
                // Get bottom arc center
                let point2 = Segment.pointBetweenLine(point1: point1, point2: centerpoint, percentBetween: 0.5)
                // Get radius, which is the length between center point and either arc point
                let radius = Line.distanceBetween(point1: point3, point2: centerpoint)

                // Get Segments and add to segments
                segments.append(Segment(point1, point4))
                segments.append(Segment(centerPoint: point3, radius: CGFloat(radius), startAngle: CGFloat.pi*1.5, endAngle: CGFloat.pi/2, clockwise: true))
                segments.append(Segment(centerPoint: point2, radius: CGFloat(radius), startAngle: CGFloat.pi*1.5, endAngle: CGFloat.pi/2, clockwise: true))
                // set boolean for object
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
