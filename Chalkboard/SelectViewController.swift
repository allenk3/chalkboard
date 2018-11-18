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
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChalkboardModel.shared.writeableCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.cellLabel.text = ChalkboardModel.shared.getWriteableAt(index: indexPath.item).title
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = ChalkboardModel.shared
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    

}
