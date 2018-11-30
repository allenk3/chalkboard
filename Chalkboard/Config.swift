//
//  Config.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/21/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

class Config {
    // Background color
    static var drawScreenBackgroundColor : UIColor = UIColor(red: 0.19, green: 0.62, blue: 0.1, alpha: 1)
    // SubVie
    static var drawScreenLineColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    // Line dash pattern for the chalkboard
    static var lineDashPattern = [20, 8]
    // Top and bottom line on chalkboard
    static var chalkboardSolidlineWidth : CGFloat = 10
    // Dashed line on chalkboard
    static var chalkboardDashedLineWidth : CGFloat = 5
    
    
    
    // Percentage of curve that line will take up.
    static var curvedSegmentLinePercent = 0.05
    static var straightSegmentLinePercent = 0.1
    
    // User drawing configuration
    static var userLineColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static var userLineCap = "round"
    static var userLineWidth : CGFloat = 11
    // Distance shape is from bottom and top
    static var shapeDistanceFromBottom = CGFloat(19.0)
    static var shapeDistanceFromTop = CGFloat(19.0)
    
    
    // User limitation configuration
    
    // Distance from line that user is allowed to err
    static var distanceLimit : Double = 15.0
    // Distance from starting point that user is allowed to err
    static var startRadiusLimit : Double = 15.0
    // Required percentage of the last line the user must complete
    static var requiredPercentageToComplete : Double = 0.90
    // Starting index, dont want magic numbers
    static var startLineIndex : Int = 0
    static var startSegmentIndex : Int = 0
    
    
    
    // Letter specific config
    // B
    static var bExtention : CGFloat = 50
    
}
