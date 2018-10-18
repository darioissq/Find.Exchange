//
//  MarketViewController+CollectionView.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

extension MarketViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Configuration
    internal func configure(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "AppStoreCell", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? AppStoreCell {
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: AppStoreCell.cellHeight)
    }
}

//MARK : - UIScrollViewDelegate
extension MarketViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            if self.lastContentOffset - scrollView.contentOffset.y > 10{
                if velocity > 10 {
                    self.showControllersIfNeeded()
                }
            }
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            if self.lastContentOffset - scrollView.contentOffset.y < -10 {
                if velocity < -10 {
                    self.hideControllersIfNeeded()
                }
            }
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

//MARK : - Controllers

extension MarketViewController {
    func showControllersIfNeeded(){
        if !self.areControllersHidden {
            return
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let tabbarController = self.tabBarController as? TabbarController {
            tabbarController.changeTabBar(hidden: false, animated: true) { (finished) in
                if finished {
                    self.areControllersHidden = false
                }
            }
        }
        
        setButtonConstraint(false)
        
    }
    
    func hideControllersIfNeeded(){
        if self.areControllersHidden {
            return
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let tabbarController = self.tabBarController as? TabbarController {
            tabbarController.changeTabBar(hidden: true, animated: true) { (finished) in
                if finished {
                    self.areControllersHidden = true
                }
            }
        }
        
        setButtonConstraint(true)
    }
}
