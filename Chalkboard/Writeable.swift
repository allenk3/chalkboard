//
//  Writeable.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/11/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

class Writeable: UIView {
    
    //type properties
    static let dummyFrame = CGRect(x: 0, y: 0, width: 1, height: 1)
    
    // nested structure
    
    // stored properties
    let title: String
    var segments: [UIBezierPath]
    
    
    
    // initializers
    init (title: String, segments: [UIBezierPath], frame: CGRect) {
        print(frame)
        self.title = title
        self.segments = segments
        super.init(frame: frame)
    }
    
    init (title: String, segments: [UIBezierPath]) {
        self.title = title
        self.segments = segments
        super.init(frame: Writeable.dummyFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect : CGRect) {
        //calculate points
        let point1 = CGPoint(x: rect.size.width/8, y: rect.size.height-5)
        let point3 = CGPoint(x: rect.size.width/2, y: 5)
        let point5 = CGPoint(x: rect.size.width - (rect.size.width/8), y: rect.size.height-5)
        let point2 = Writeable.midPoint(point1: point1, point2: point3, percentBetween: 0.6)
        let point4 = Writeable.midPoint(point1: point3, point2: point5, percentBetween: 0.4)
        
        
        
        
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        let crossLine = UIBezierPath()
        crossLine.move(to: point2)
        crossLine.addLine(to: point4)
        path.append(crossLine)
        UIColor.clear.setFill()
        UIColor.white.setStroke()
        path.stroke()
    }
    
    
    
    
    
    // Supporting methods
    static func midPoint(point1: CGPoint, point2: CGPoint, percentBetween: Double) -> CGPoint {
        return CGPoint(x: point1.x + (point2.x - point1.x) * CGFloat(percentBetween), y: point1.y + (point2.y - point1.y) * CGFloat(percentBetween))
    }
}
