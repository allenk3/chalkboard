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
    var segments: [UIBezierPath]
    
    // initializers
    init (title: String, segments: [UIBezierPath]) {
        self.title = title
        self.segments = segments
    }
}
