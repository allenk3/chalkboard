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
    
}
