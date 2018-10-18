//
//  MarketViewController.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {
    internal let reuseIdentifier = "AppStoreCell"
    
    /// CollectionView
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            configure(collectionView: self.collectionView)
        }
    }
    
    /// Constraints
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var compareButtonBottomConstraint: NSLayoutConstraint!
    
    /// Views
    @IBOutlet weak var containerView: UIView!
    
    /// Buttons
    @IBOutlet weak var compareButton: UIButton!{
        didSet{
            configure(compareButton)
        }
    }
    
    /// Bools
    internal var areControllersHidden : Bool = false
    
    ///Floats
    internal var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK :  Configurations
extension MarketViewController {
    private func configure(_ button : UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .black
        button.setTitle("Compare Money Transfer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
}

//MARK : - Animations
extension MarketViewController {
    internal func setButtonConstraint(_ hidden : Bool) {
        if hidden {
            moveButtonToBottom()
            moveCollectionView()
        } else {
            resetButtonPosition()
            resetCollectionViewPosition()
        }
    }
    
    private func moveButtonToBottom() {
        UIView.animate(withDuration: 0.5, animations: {
            self.compareButton.transform = CGAffineTransform(translationX: 0, y: 70)
        })
    }
    
    private func resetButtonPosition(){
        UIView.animate(withDuration: 0.5, animations: {
            self.compareButton.transform = CGAffineTransform.identity
        })
    }
    
    private func moveCollectionView(){
        if let tabbar = self.tabBarController {
            collectionViewBottomConstraint.constant = tabbar.tabBar.frame.size.height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func resetCollectionViewPosition(){
        if self.tabBarController != nil {
            collectionViewBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

//MARK : - Selectors
extension MarketViewController {
    @objc public func handleTap(_ button : UIButton) {
        
    }
}
