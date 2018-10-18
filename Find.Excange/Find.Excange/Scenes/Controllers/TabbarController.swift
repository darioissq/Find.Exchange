//
//  TabbarController.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    private var raisedButtonY : CGFloat = 55.0
    
    private let tabbarTintColor : UIColor = .black
    
    //Controllers
    private let accountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
    
    private let marketViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketViewController") as! MarketViewController
    
    private let moreViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
    
    private let cardsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardsViewController") as! CardsViewController
        
    //UI Component
    private let button = RaisedButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        insertEmptyTabItem("QRCode", atIndex: 2)
        addRaisedButton(UIImage.init(named: "qr"), highlightImage: UIImage.init(named: "qr"))
        self.tabBar.tintColor = tabbarTintColor
    }
}

//MARK : - Raised Button
extension TabbarController {
    private func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = UIViewController()
        let tabBarItem : UITabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        vc.tabBarItem = tabBarItem
        vc.tabBarItem.isEnabled = false
        self.viewControllers?.insert(vc, at: atIndex)
    }
    
    private func addRaisedButton(_ buttonImage: UIImage?, highlightImage: UIImage?, offset:CGFloat? = nil) {
        if let buttonImage = buttonImage {
            button.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    raisedButtonY = 0
                case 1334:
                    raisedButtonY = 0
                case 1920, 2208:
                    raisedButtonY = 0
                case 2436:
                    raisedButtonY = 55
                case 2688:
                    raisedButtonY = 55
                case 1792:
                    raisedButtonY = 55
                default:
                    print("Device unknown")
                }
            }
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
            button.imageEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
            button.setImage(buttonImage, for: .normal)
            button.setImage(highlightImage, for: .normal)
            
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = button.frame.size.height / 2
            
            
            let heightDifference = button.frame.size.height - self.tabBar.frame.size.height
            
            if (heightDifference < 0) {
                button.center = self.tabBar.center
            }
            else {
                var center = self.tabBar.center
                center.y -= (heightDifference / 2.0) + raisedButtonY
                button.center = center
            }
            
            if offset != nil
            {
                //Add offset
                var center = button.center
                center.y = center.y + offset!
                button.center = center
            }
            
            button.addTarget(self, action: #selector(onRaisedButton(_:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
}

//MARK : - Aniamtions
extension TabbarController {
    public func changeTabBar(hidden:Bool, animated: Bool, with completition : @escaping (_ finished: Bool) -> Void){
        if tabBar.isHidden == hidden && self.button.isHidden == hidden { return }
        
        let tabbarFrame = tabBar.frame
        let tabbarOffset = hidden ? tabbarFrame.size.height : 0
        
        let raisedButtonFrame = self.button.frame
        let raisedButtonOffset = hidden ? raisedButtonFrame.size.height : 0
        
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        
        tabBar.isHidden = false
        self.button.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.tabBar.frame = tabbarFrame.offsetBy(dx: 0, dy: tabbarOffset)
            self.button.transform = raisedButtonOffset == 0 ? CGAffineTransform.identity
                :CGAffineTransform(translationX: 0, y: raisedButtonOffset + self.raisedButtonY)
        }, completion: { (true) in
            self.tabBar.isHidden = hidden
            self.button.isHidden = hidden
            completition(true)
        })
    }
}

//MARK : - Selectors
extension TabbarController {
    @objc private func onRaisedButton(_ sender: UIButton!) {
        self.presentQRCodeViewController()
    }
}

//MARK : - View Controllers
extension TabbarController {
    internal func setViewControllers(){
        
        let accountTabBarItem:UITabBarItem = UITabBarItem(title: "Account", image: UIImage(named: "wallet")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "wallet"))
        let marketTabBarItem:UITabBarItem = UITabBarItem(title: "Market", image: UIImage(named: "market")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "market"))
        let cardsTabBarItem:UITabBarItem = UITabBarItem(title: "Card", image: UIImage(named: "Card")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Card"))
        let moreTabBarItem:UITabBarItem = UITabBarItem(title: "More", image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "more"))
 
        accountViewController.tabBarItem = accountTabBarItem
        marketViewController.tabBarItem = marketTabBarItem
        cardsViewController.tabBarItem = cardsTabBarItem
        moreViewController.tabBarItem = moreTabBarItem
        
        let tabBarList = [accountViewController,cardsViewController,marketViewController,moreViewController]
        
        viewControllers = tabBarList
    }
    
    private func presentQRCodeViewController(){
        if let qrCodeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController {
            present(qrCodeViewController, animated: true, completion: nil)
        }
    }
}

// MARK : - Navigation Bar

extension TabbarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Market" {
            configureNavigationBar()
        } else {
            self.navigationItem.rightBarButtonItem  = nil
        }
    }
    
    private func configureNavigationBar(){
        configureNavigationItem()
    }
    
    private func configureNavigationItem(){
        let magnifierButton = UIBarButtonItem(image: UIImage(named: "magnifier")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(MarketViewController.handleTap(_:)))
        self.navigationItem.rightBarButtonItem  = magnifierButton
    }
}

///MARK : - Selectors
extension TabbarController {
    @objc private func handleTap(_ button : UIButton) {
        
    }
}
