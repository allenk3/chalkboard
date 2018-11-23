//
//  DrawViewController.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/18/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    var activeShape : Writeable?
    var completedSegments : [Segment] = []
    var activeSegment : Segment?
    var activeLineIndex : Int = 0
    var recentPoint : CGPoint?
    
    // User path drawing
    

    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    @IBOutlet weak var drawView: UIView!
    
    
    // functions
    @IBAction func prevButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectPrevious()
        setupView()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectNext()
        setupView()
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
    }
    
    @IBAction func randomButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectRandom()
        setupView()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        drawView.clipsToBounds = true
        drawView.isMultipleTouchEnabled = false
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
    
    
    /************** TOUCHES ****************/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: drawView)
        recentPoint = touchPoint
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: drawView)
        recentPoint = touchPoint
        let index = activeSegment?.getClosestIndexWith(activeIndex: activeLineIndex, point: recentPoint ?? CGPoint(x:0,y:0))
        print(index?.0 ?? "index nil")
        print(index?.1 ?? "percent nil")
        print(activeSegment?.lines[0].distanceTo(point: recentPoint ?? CGPoint(x:0,y:0)))
        
    }
 





    /****************** Support methods ********************/
    // Sets up the user's drawn letters
    func updateShape(point : CGPoint) {
        
    }
    
    
    // Sets up the initial view based on the state of the model
    func setupView() {
        
        // Background
        self.view.backgroundColor = Config.drawScreenBackgroundColor
        drawView.backgroundColor = Config.drawScreenBackgroundColor
        // Set active shape
        activeShape = ChalkboardModel.shared.getSelectedShape()
        
        
        //Draw shape
        if let activeShape = activeShape {
            print("Shape Initialized")
            // Set active segments
            activeSegment = activeShape.getSegment(at: 0)
            activeLineIndex = 0
            // Draw chalkboard guide lines
            let chalkboardLines = CAShapeLayer()
            chalkboardLines.lineWidth = Config.lineWidth
            chalkboardLines.strokeColor = Config.drawScreenLineColor.cgColor
            chalkboardLines.fillColor = UIColor.clear.cgColor
            
            let chalkboardDashed = CAShapeLayer()
            chalkboardDashed.lineWidth = Config.chalkboardLineWidth
            chalkboardDashed.strokeColor = Config.drawScreenLineColor.cgColor
            chalkboardDashed.fillColor = UIColor.clear.cgColor
            chalkboardDashed.lineDashPattern = Config.lineDashPattern as [NSNumber]
            
            let topLinePath = UIBezierPath()
            topLinePath.move(to: CGPoint(x: 0, y: 5))
            topLinePath.addLine(to: CGPoint(x: drawView.frame.width, y: 5))
            
            let dashedLine = UIBezierPath()
            dashedLine.move(to: CGPoint(x: 10, y: drawView.frame.height/2 + 20))
            dashedLine.addLine(to: CGPoint(x: drawView.frame.width, y: drawView.frame.height/2 + 20   ))
            
            let bottomLInePath = UIBezierPath()
            bottomLInePath.move(to: CGPoint(x: 0, y: drawView.frame.height - 10))
            bottomLInePath.addLine(to: CGPoint(x: drawView.frame.width, y: drawView.frame.height - 10))
            
            // Add paths to shape layer
            topLinePath.append(bottomLInePath)
            chalkboardLines.path = topLinePath.cgPath
            chalkboardDashed.path = dashedLine.cgPath
            
            // Add shape layers to drawView
            drawView.layer.addSublayer(chalkboardLines)
            drawView.layer.addSublayer(chalkboardDashed)
            
            
            
            // Letter shape
            activeShape.setShapePath(frame: drawView.frame)
            let segments = activeShape.getSegments()
            for segment in segments {
                let shapeLayer = CAShapeLayer()
                shapeLayer.strokeColor = Config.drawScreenLineColor.cgColor
                shapeLayer.lineWidth = Config.lineWidth
                shapeLayer.lineDashPattern = Config.lineDashPattern as [NSNumber]
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.path = segment.completeLine.cgPath
                drawView.layer.addSublayer(shapeLayer)
            }
        } else {
            //if shape is not set, set randomly
        }
    }
    
    /*
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        self.view.setNeedsDisplay()
    }
 */



    /*
        pseudocode for progress checking
        checking started by touch event within X distance of active segment start point
     
     
            if within X distance of checkpoint
                if currentCheckpoint = segmentEndpoint
                    segmentComplete
                else
                    currentCheckpoint = nextCheckpoint (shade previous sub-segment)
            else if > X distance from prev checkpoint
                segment.reset (all progress lost,  must release to re-start)
                break
     
    */


}
