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
    // Initial shape/screen configuration
    static var drawScreenBackgroundColor : UIColor = UIColor(red: 0.19, green: 0.62, blue: 0.1, alpha: 1)
    static var subViewColor = UIColor(red: 0.6, green: 0.62, blue: 0.4, alpha: 1)
    static var drawScreenLineColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static var lineDashPattern = [20, 8]
    static var lineWidth : CGFloat = 10
    static var chalkboardLineWidth : CGFloat = 5
    
    // User drawing configuration
    static var userLineColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    
    // User limitation configuration
    static var distanceLimit : Double = 15.0
    static var startRadiusLimit : Double = 15.0
    static var requiredPercentageToComplete : Double = 90.0
    static var startLineIndex : Int = 0
    static var startSegmentIndex : Int = 0
    
    // Math config
    static var toDegrees = 57.2958
    static var toRadians = 0.0698132
    
}
