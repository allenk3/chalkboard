//
//  MainDrawView.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/21/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class MainDrawView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 49, green: CGFloat(158), blue: CGFloat(19), alpha: CGFloat(1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: CGFloat(49), green: CGFloat(158), blue: CGFloat(19), alpha: CGFloat(1))
        //fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
