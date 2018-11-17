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
        self.backgroundColor = UIColor.clear
        //calculate points
        
    }
    
    
    
    
    
    // Supporting methods
    static func midPoint(point1: CGPoint, point2: CGPoint, percentBetween: Double) -> CGPoint {
        return CGPoint(x: point1.x + (point2.x - point1.x) * CGFloat(percentBetween), y: point1.y + (point2.y - point1.y) * CGFloat(percentBetween))
    }
}
