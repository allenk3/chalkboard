//
//  SelectViewController.swift
//  Chalkboard
//
//  Created by Kyle Allen on 11/11/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
}

class SelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    @IBAction func segControlSelect(_ sender: UISegmentedControl) {
        ChalkboardModel.shared.setSelectedSet(to: sender.selectedSegmentIndex)
        updateView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChalkboardModel.shared.writeableCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.cellLabel.text = ChalkboardModel.shared.getWriteableAt(index: indexPath.item).title
        
        let bColor : UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        cell.layer.borderColor = bColor.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ChalkboardModel.shared.setSelectedShape(to: indexPath.item)
        // force segue
        self.tabBarController?.selectedIndex = 2
        // performSegue(withIdentifier: "SelectToDraw", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = ChalkboardModel.shared
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentControlOutlet.selectedSegmentIndex = ChalkboardModel.shared.selectedSet
        updateView()
    }
    
    

}
