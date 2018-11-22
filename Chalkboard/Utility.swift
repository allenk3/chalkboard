//
//  Utility.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/21/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation


func randomFromZero(to number: Int) -> Int {
    return Int(arc4random_uniform(UInt32(number)))
}
