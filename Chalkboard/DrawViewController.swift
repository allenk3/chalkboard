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
        let recentPoint = touchPoint
        // Check if point is within config radius of start point
        if let activeSegment = activeSegment, let recentPoint = recentPoint {
            if Line.distanceBetween(point1: activeSegment.getStartingPoint(), point2: recentPoint) < Config.startRadiusLimit {
                // Set the active index to the start index
                activeLineIndex = Config.startLineIndex
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
            if let nextIndex = nextIndex {
                print(nextIndex)
                // Check if nextIndex is final line and if the percentage is greater than limit
                if nextIndex.0 == -1 && nextIndex.1! > Config.requiredPercentageToComplete {
                    // Add segment to complted segments
                    completedSegments.append(activeSegment!)
                    // Check to see if shape is completed
                    if completedSegments.count == activeShape?.getNumSegments() {
                        // Set boolean to true
                        shapeComplete = true
                        // Set index and segment to nil to indicate completion
                        self.activeLineIndex = nil
                        activeSegment = nil
                        setupView()
                        // Return
                        return
                    }
                    // Set activeSegment to next segment
                    activeSegment = activeShape?.getSegment(at: completedSegments.count)
                    // If the shape is not complete, redraw based on newly completed segemnt
                    setupView()
                    return
                }
                // If the index is not nil, set activeLine index
                self.activeLineIndex = nextIndex.0
                // set percentComplete
                percentComplete = nextIndex.1
                // Redraw users progress
                updateInputSegment()
            }else {
                // If users drag is outside limit
                // set index to nil
                self.activeLineIndex = nil
                // Draw background with completed segments only
                setupView()
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
            
            // Configure shape
            let progressShape = CAShapeLayer()
            progressShape.lineWidth = Config.lineWidth
            progressShape.strokeColor = Config.userLineColor.cgColor
            progressShape.fillColor = UIColor.clear.cgColor
            
            
            
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
            progressShape.path = path.cgPath
            
            // Add shape to drawView
            drawView.layer.addSublayer(progressShape)
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
        chalkboardLines.lineWidth = Config.lineWidth
        chalkboardLines.strokeColor = Config.drawScreenLineColor.cgColor
        chalkboardLines.fillColor = UIColor.clear.cgColor
        
        // Middle dashed background line config
        let chalkboardDashed = CAShapeLayer()
        chalkboardDashed.lineWidth = Config.chalkboardLineWidth
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
            for segment in segments {
                let shapeLayer = CAShapeLayer()
                shapeLayer.strokeColor = Config.drawScreenLineColor.cgColor
                shapeLayer.lineWidth = Config.lineWidth
                shapeLayer.lineDashPattern = Config.lineDashPattern as [NSNumber]
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.path = segment.completeLine.cgPath
                drawView.layer.addSublayer(shapeLayer)
            }
        }
    }
    
    func drawCompletedSegments() {
        if completedSegments.count > 0 {
            // User completed segments config
            let userShape = CAShapeLayer()
            userShape.lineWidth = Config.lineWidth
            userShape.strokeColor = Config.userLineColor.cgColor
            userShape.fillColor = UIColor.clear.cgColor
            
            // Draw user lines
            let userPath = UIBezierPath()
            for segment in completedSegments {
                userPath.append(segment.getCompleteLine())
            }
            // Add path to shape layer
            userShape.path = userPath.cgPath
            // Add shape layer to drawView
            drawView.layer.addSublayer(userShape)
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
