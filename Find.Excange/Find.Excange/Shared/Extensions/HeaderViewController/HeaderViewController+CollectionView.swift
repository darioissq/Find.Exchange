//
//  HeaderViewController+CollectionView.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

extension HeaderViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Configuration
    internal func configure(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? HeaderCollectionViewCell {
            if indexPath.row == 0 {
                cell.set(datasource[indexPath.row], true)
            } else {
                cell.set(datasource[indexPath.row], false)
            }
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.width(for: indexPath.row, usingFont: UIFont.boldSystemFont(ofSize: 16)), height: HeaderCollectionViewCell.cellHeight)
    }
}

// MARK: - Utils
extension HeaderViewController {
    private func width(for index : Int, usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = datasource[index].size(withAttributes: fontAttributes)
        return size.width + 40
    }
}
