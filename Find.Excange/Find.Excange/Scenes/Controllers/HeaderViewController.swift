//
//  HeaderCollectionViewController.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    internal let reuseIdentifier = "HeaderCollectionViewCell"
    
    /// Datasource
    let datasource = ["Money Transfer","Loans","Investment","Credit"]

    /// CollectionView
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            configure(collectionView: collectionView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
