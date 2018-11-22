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
    
    // initializers
    init (title: String, segments: [Segment]) {
        self.title = title
        self.segments = segments
    }
    
    func setShapePath(frame: CGRect) {
        switch title {
        case "A":
            // Get points
            let point1 = CGPoint(x: frame.size.width/8, y: frame.size.height-7)
            let point3 = CGPoint(x: frame.size.width/2, y: 10)
            let point5 = CGPoint(x: frame.size.width - (frame.size.width/8), y: frame.size.height-7)
            let point2 = Segment.pointBetweenLine(point1: point3, point2: point1, percentBetween: 0.45)
            let point4 = Segment.pointBetweenLine(point1: point3, point2: point5, percentBetween: 0.45)
            
            // Get Segments and add to segments
            segments.append(Segment(point1, point3))
            segments.append(Segment(point3, point5))
            segments.append(Segment(point2, point4))
            
        default:
            print("Error")
        }
    }
    
    func getSegments() -> [Segment] {
        return segments
    }
    
    
    
    /******** HELPER FUNCTIONS *********/
}
