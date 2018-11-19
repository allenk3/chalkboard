//
//  HomeViewController.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/18/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func randomLetter(_ sender: Any) {
        ChalkboardModel.shared.selectRandomLetter()
        self.tabBarController?.selectedIndex = 2
        
        // performSegue(withIdentifier: "HomeToDraw", sender: self)
    }
    
    @IBAction func randomNumber(_ sender: Any) {
        ChalkboardModel.shared.selectRandomNumber()
        self.tabBarController?.selectedIndex = 2
        
        // performSegue(withIdentifier: "HomeToDraw", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! DrawViewController
        destinationVc.hidesBottomBarWhenPushed = false
        destinationVc.tabBarController?.tabBar.isHidden = false
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
