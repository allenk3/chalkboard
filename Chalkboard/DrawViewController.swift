//
//  DrawViewController.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/18/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    
    
    @IBOutlet weak var activeShapeLabel: UILabel!
    
    // functions
    @IBAction func prevButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectPrevious()
        updateView()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectNext()
        updateView()
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
    }
    
    @IBAction func randomButtonAction(_ sender: Any) {
        ChalkboardModel.shared.selectRandom()
        updateView()
    }
    
    func updateView () {
        let activeShape = ChalkboardModel.shared.getSelectedShape()
        activeShapeLabel.text = activeShape.title
        // activeShape.useFrame(UIView)
        // render shape on screen
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
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
