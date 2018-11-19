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
        activeShapeLabel.text = ChalkboardModel.shared.getSelectedShape().title
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


}
