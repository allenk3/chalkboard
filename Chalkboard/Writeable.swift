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
    
    //type properties
    static let dummyFrame = CGRect(x: 0, y: 0, width: 1, height: 1)
    
    // nested structure
    
    // stored properties
    let title: String
    var segments: [UIBezierPath]
    
    init (title: String, segments: [UIBezierPath]) {
        self.title = title
        self.segments = segments
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPath(withView view: CGRect) {
        if title == "A" {
            let point1 = CGPoint(x: view.size.width/8, y: view.size.height-5)
            let point3 = CGPoint(x: view.size.width/2, y: 5)
            let point5 = CGPoint(x: view.size.width - (view.size.width/8), y: view.size.height-5)
            let point2 = Writeable.midPoint(point1: point1, point2: point3, percentBetween: 0.6)
            let point4 = Writeable.midPoint(point1: point3, point2: point5, percentBetween: 0.4)


            let path1 = UIBezierPath()
            path1.move(to: point1)
            path1.addLine(to: point3)
            
            let path2 = UIBezierPath()
            path2.move(to: point3)
            path2.addLine(to: point5)
            
            let path3 = UIBezierPath()
            path3.move(to: point2)
            path3.addLine(to: point4)
            
            segments = [path1, path2, path3]

        }
    }
    
    
    
    // Supporting methods
    static func midPoint(point1: CGPoint, point2: CGPoint, percentBetween: Double) -> CGPoint {
        return CGPoint(x: point1.x + (point2.x - point1.x) * CGFloat(percentBetween), y: point1.y + (point2.y - point1.y) * CGFloat(percentBetween))
    }
}
