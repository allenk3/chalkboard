//
//  Writeable.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/11/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

class Writeable: UICollectionViewCell {
    
    // nested structure
    
    // stored properties
    let title: String
    var segments: [UIBezierPath]
    
    // initializers
    init (title: String, segments: [UIBezierPath]) {
        self.title = title
        self.segments = segments
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
