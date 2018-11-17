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
        let shapeLayer = CAShapeLayer()
        let point1 = CGPoint(x: drawView.frame.size.width/8, y: drawView.frame.size.height-5)
        let point3 = CGPoint(x: drawView.frame.size.width/2, y: 5)
        let point5 = CGPoint(x: drawView.frame.size.width - (drawView.frame.size.width/8), y: drawView.frame.size.height-5)
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
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 9.0
        shapeLayer.path = path.cgPath
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
