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
    var activeLineIndex : Int?
    var percentComplete : Double?
    var shapeComplete : Bool = false
    
    
    // Shapes needed for removal later
    var userInputShape : CAShapeLayer?
    var completeSegmentsShape : CAShapeLayer?
    var backgroundShape : CAShapeLayer?
    
    var startCircle : CAShapeLayer?
    var endCircle : CAShapeLayer?
    
    
    // User path drawing
    

    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    @IBOutlet weak var drawView: UIView!
    
    
    // functions
    @IBAction func prevButtonAction(_ sender: Any) {
        // Select shape in model
        ChalkboardModel.shared.selectPrevious()
        // Set activeShape to model selectedShape
        activeShape = ChalkboardModel.shared.getSelectedShape()
        // Clear completedSegments
        completedSegments = []
        // Clear user input layer
        completeSegmentsShape?.removeFromSuperlayer()
        // Clear background shape layer
        backgroundShape?.removeFromSuperlayer()
        // Set finished to false
        shapeComplete = false
        // Set layer need to appear
        drawView.layer.setNeedsDisplay()
        // Draw new background shape
        drawSelectedShapeOutline()
        // Draw indication circles
        drawIndicationCircles()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectNext()
        // Set activeShape to model selectedShape
        activeShape = ChalkboardModel.shared.getSelectedShape()
        // Clear completedSegments
        completedSegments = []
        // Clear user input layer
        completeSegmentsShape?.removeFromSuperlayer()
        // Clear background shape layer
        backgroundShape?.removeFromSuperlayer()
        // Set finished to false
        shapeComplete = false
        // Set layer need to appear
        drawView.layer.setNeedsDisplay()
        // Draw new background shape
        drawSelectedShapeOutline()
        // Draw indication circles
        drawIndicationCircles()
        
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
        // Clear completedSegments
        completedSegments = []
        // Clear drawn layer
        completeSegmentsShape?.removeFromSuperlayer()
        // set active segment
        activeSegment = activeShape?.getSegment(at: completedSegments.count)
        drawView.layer.setNeedsDisplay()
        // Set finished to false
        shapeComplete = false
        // Draw indication circles
        drawIndicationCircles()
    }
    
    @IBAction func randomButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectRandom()
        // Set activeShape to model selectedShape
        activeShape = ChalkboardModel.shared.getSelectedShape()
        // Clear completedSegments
        completedSegments = []
        // Clear user input layer
        completeSegmentsShape?.removeFromSuperlayer()
        // Clear background shape layer
        backgroundShape?.removeFromSuperlayer()
        // Set layer need to appear
        drawView.layer.setNeedsDisplay()
        // Set finished to false
        shapeComplete = false
        // Draw new background shape
        drawSelectedShapeOutline()
        // Draw indication circles
        drawIndicationCircles()
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // If touch ends, set activeSegment to correct segment
        // set line index to nil
        if let activeShape = activeShape {
            self.activeLineIndex = nil
            self.activeSegment = activeShape.getSegment(at: completedSegments.count)
            
        }
        
        // Draw background with completed segments only
        userInputShape?.removeFromSuperlayer()
        drawView.layer.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // if interrupted, do same as if error
        if let activeShape = activeShape {
            self.activeLineIndex = nil
            self.activeSegment = activeShape.getSegment(at: completedSegments.count)
            
        }
        
        // Draw background with completed segments only
        userInputShape?.removeFromSuperlayer()
        drawView.layer.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: drawView)
        let recentPoint = touchPoint
        // Set active segment
        // Check if point is within config radius of start point
        if (recentPoint != nil) && !shapeComplete {
            activeSegment = activeShape?.getSegment(at: completedSegments.count)
            if Line.distanceBetween(point1: activeSegment!.getStartingPoint(), point2: recentPoint!) < Config.startRadiusLimit {
                // Set the active index to the start index
                activeLineIndex = Config.startLineIndex
            }else {
                activeSegment = nil
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: drawView)
        let recentPoint = touchPoint
        
        // Check to see that the active index has been set
        if let activeLineIndex = activeLineIndex, let recentPoint = recentPoint {
            // Get next activeLineIndex
            // Will return (index, percentComplete)
            let nextIndex = activeSegment?.getClosestIndexWith(activeIndex: activeLineIndex, point: recentPoint)
            // Check to see if index is nil, meaning that the drag was outside of line
            if nextIndex != nil && nextIndex!.0 != nil && nextIndex!.1 != nil {
                //print(nextIndex)
                // Check if nextIndex is final line and if the percentage is greater than limit
                if nextIndex!.0 == -1 && nextIndex!.1! > Config.requiredPercentageToComplete {
                    // Add segment to complted segments
                    completedSegments.append(activeSegment!)
                    
                    // Check to see if shape is completed
                    if completedSegments.count == activeShape?.getNumSegments() {
                        // Set boolean to true
                        shapeComplete = true
                        Config.userLineColor = UIColor.red
                        // Set index and segment to nil to indicate completion
                        self.activeLineIndex = nil
                        activeSegment = nil
                        drawCompletedSegments()
                        Config.userLineColor = UIColor.white
                        // Return
                        return
                    }
                    
                    // Set activeSegment to next segment
                    activeSegment = activeShape?.getSegment(at: completedSegments.count)
                    self.activeLineIndex = 0
                    // If the shape is not complete, redraw based on newly completed segemnt
                    drawCompletedSegments()
                    return
                }
                // If the index is not nil, set activeLine index
                self.activeLineIndex = nextIndex!.0
                // set percentComplete
                percentComplete = nextIndex!.1
                // Redraw users progress
                updateInputSegment()
            }else {
                // If users drag is outside limit
                // set index to nil
                self.activeLineIndex = nil
                self.activeSegment = nil
                // Draw background with completed segments only
                userInputShape?.removeFromSuperlayer()
                drawView.layer.setNeedsDisplay()
                
            }
            
        }
    }
 





    /****************** Support methods ********************/
    // Sets up the initial view based on the state of the model
    func setupView() {
        // Set active shape
        activeShape = ChalkboardModel.shared.getSelectedShape()
        // Draw Background
        drawBackground()
        // Draw the selected shape outline
        drawSelectedShapeOutline()
        // Set the active segment depending on if the shape is completed
        if !shapeComplete {
            activeSegment = activeShape?.getSegment(at: completedSegments.count)
        }
        // Draw the completed segments
        drawCompletedSegments()
    }
    
    func updateInputSegment() {
        // Check if activeSegment
        if let activeSegment = activeSegment, let activeLineindex = activeLineIndex {
            // Draw lines up to the activeLineIndex
            if let userInputShape = userInputShape {
                userInputShape.removeFromSuperlayer()
            }
            // Configure shape
            userInputShape = CAShapeLayer()
            userInputShape!.lineWidth = Config.userLineWidth
            userInputShape!.strokeColor = Config.userLineColor.cgColor
            userInputShape!.fillColor = UIColor.clear.cgColor
            userInputShape!.lineCap = Config.userLineCap
            
            // Append all lines up to activeLineIndex to path
            let path = UIBezierPath()
            var counterIndex = 0
            for line in activeSegment.getLines() {
                // Check for the last line to draw
                if counterIndex == activeLineindex {
                    // Make sure percentComplete is set, if not, just draw full line
                    if let percentComplete = percentComplete {
                        // Get end point based on percentComplete
                        let newEndPoint = Segment.pointBetweenLine(point1: line.start, point2: line.end, percentBetween: percentComplete)
                        // Draw line
                        let partialPath = UIBezierPath()
                        partialPath.move(to: line.start)
                        partialPath.addLine(to: newEndPoint)
                        
                        // add line to overall path
                        path.append(partialPath)
                        // Break from loop
                        break
                    }
                    
                }
                
                // Construct line
                let newPath = UIBezierPath()
                newPath.move(to: line.start)
                newPath.addLine(to: line.end)
                // Append new line to path
                path.append(newPath)
                counterIndex += 1
            }
            // Add path to shape layer
            userInputShape!.path = path.cgPath
            
            // Add shape to drawView
            drawView.layer.addSublayer(userInputShape!)
        }else {
            print("no active Segment to draw")
        }
        
    }
    
    
    func drawBackground() {
        // Background colors
        self.view.backgroundColor = Config.drawScreenBackgroundColor
        drawView.backgroundColor = Config.drawScreenBackgroundColor
        // Draw chalkboard guide lines
        // Total solid background lines config
        let chalkboardLines = CAShapeLayer()
        chalkboardLines.lineWidth = Config.chalkboardSolidlineWidth
        chalkboardLines.strokeColor = Config.drawScreenLineColor.cgColor
        chalkboardLines.fillColor = UIColor.clear.cgColor
        
        // Middle dashed background line config
        let chalkboardDashed = CAShapeLayer()
        chalkboardDashed.lineWidth = Config.chalkboardDashedLineWidth
        chalkboardDashed.strokeColor = Config.drawScreenLineColor.cgColor
        chalkboardDashed.fillColor = UIColor.clear.cgColor
        chalkboardDashed.lineDashPattern = Config.lineDashPattern as [NSNumber]
        
        // Draw top line
        let topLinePath = UIBezierPath()
        topLinePath.move(to: CGPoint(x: 0, y: 5))
        topLinePath.addLine(to: CGPoint(x: drawView.frame.width, y: 5))
        
        // Draw dashed line
        let dashedLine = UIBezierPath()
        dashedLine.move(to: CGPoint(x: 10, y: drawView.frame.height/2 + 20))
        dashedLine.addLine(to: CGPoint(x: drawView.frame.width, y: drawView.frame.height/2 + 20   ))
        
        // Draw bottom line
        let bottomLInePath = UIBezierPath()
        bottomLInePath.move(to: CGPoint(x: 0, y: drawView.frame.height - 10))
        bottomLInePath.addLine(to: CGPoint(x: drawView.frame.width, y: drawView.frame.height - 10))
        
        // Add paths to background shape layer
        topLinePath.append(bottomLInePath)
        chalkboardLines.path = topLinePath.cgPath
        chalkboardDashed.path = dashedLine.cgPath
        
        // render background layers
        drawView.layer.addSublayer(chalkboardLines)
        drawView.layer.addSublayer(chalkboardDashed)
        
    }
    
    func drawSelectedShapeOutline() {
        if let activeShape = activeShape {
            // Letter shape layer
            activeShape.setShapePath(frame: drawView.frame)
            let segments = activeShape.getSegments()
            // remove old shape if needed
            backgroundShape?.removeFromSuperlayer()
            // Configure new shape
            backgroundShape = CAShapeLayer()
            backgroundShape!.strokeColor = Config.drawScreenLineColor.cgColor
            backgroundShape!.lineWidth = Config.userLineWidth
            backgroundShape!.lineDashPattern = Config.lineDashPattern as [NSNumber]
            backgroundShape!.fillColor = UIColor.clear.cgColor
            // Declare path to append to
            let path = UIBezierPath()
            // Iterate through segments
            for segment in segments {
                path.append(segment.completeLine)
            }
            // Add path to shape layer
            backgroundShape?.path = path.cgPath
            // Add shape layer to drawView
            drawView.layer.addSublayer(backgroundShape!)
        }
    }
    
    func drawCompletedSegments() {
        
        if completedSegments.count > 0 {
            
            // Remove old segment layer
            completeSegmentsShape?.removeFromSuperlayer()
            // User completed segments config
            completeSegmentsShape = CAShapeLayer()
            completeSegmentsShape!.lineWidth = Config.userLineWidth
            completeSegmentsShape!.strokeColor = Config.userLineColor.cgColor
            completeSegmentsShape!.fillColor = UIColor.clear.cgColor
            completeSegmentsShape!.lineCap = Config.userLineCap
            
            // Draw user lines
            let userPath = UIBezierPath()
            for segment in completedSegments {
                userPath.append(segment.getCompleteLine())
            }
            // Add path to shape layer
            completeSegmentsShape!.path = userPath.cgPath
            // Add shape layer to drawView
            drawView.layer.addSublayer(completeSegmentsShape!)
        }
        // draw indication circles
        drawIndicationCircles()
    }
    
    // Function to setup and draw the start and end circles
    func drawIndicationCircles() {
        startCircle?.removeFromSuperlayer()
        endCircle?.removeFromSuperlayer()
        if !shapeComplete {
            // start circle config
            startCircle = CAShapeLayer()
            startCircle?.fillColor = Config.scFillColor.cgColor
            startCircle?.strokeColor = Config.scLineColor.cgColor
            startCircle?.lineWidth = Config.scLineWidth
            // end circle config
            endCircle = CAShapeLayer()
            endCircle?.fillColor = Config.ecFillColor.cgColor
            endCircle?.strokeColor = Config.ecLineColor.cgColor
            endCircle?.lineWidth = Config.ecLineWidth
            // start circle path
            startCircle?.path = UIBezierPath(arcCenter: activeShape?.getSegment(at: completedSegments.count)?.getStartingPoint() ?? CGPoint(x: 0, y: 0), radius: Config.scStartRadius, startAngle: CGFloat(0), endAngle: CGFloat.pi*2, clockwise: true).cgPath
            // end circle path
            endCircle?.path = UIBezierPath(arcCenter: activeShape?.getSegment(at: completedSegments.count)?.getEndingPoint() ?? CGPoint(x: 0, y: 0), radius: Config.ecStartRadius, startAngle: CGFloat(0), endAngle: CGFloat.pi*2, clockwise: true).cgPath
            
            // add sublayers to drawView
            drawView.layer.addSublayer(startCircle!)
            drawView.layer.addSublayer(endCircle!)
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
