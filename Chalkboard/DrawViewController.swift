//
//  DrawViewController.swift
//  Chalkboard
//
//  Created by Benjamin Purtzer on 11/16/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    @IBOutlet weak var drawView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let demoView = Writeable(title: "hi", segments: [], frame: drawView.frame)
        //create shape layer to add to subview's mask
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 9.0
        
        //get letter wanted to display
        let letter = ChalkboardModel.shared.writeables["letters"]![0]
        letter.setPath(withView: drawView.frame)
        
        //construct path to draw full letter
        let white = UIColor.white
        let red = UIColor.red
        
        let path1 = letter.segments[0]
        red.setStroke()
        path1.stroke()
        let path2 = letter.segments[1]
        white.setStroke()
        let path3 = letter.segments[2]
        
        // PROBLEM
        // Can only add one shapeLayer to the view maybe, Going to try to fix now
        let path = path1
        path.append(path2)
        path.append(path3)
        shapeLayer.fillColor = UIColor.clear.cgColor
        path.stroke()
        shapeLayer.path = path.cgPath
        
        
        // Trying to add another path to show drawing progress
        // Might have to draw model shape with draw: in view, then add CAShape for the progress of the user.

        drawView.layer.mask = shapeLayer
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
