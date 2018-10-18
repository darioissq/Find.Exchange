//
//  AppStoreCell.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit
import CoreMotion

class AppStoreCell: UICollectionViewCell {
    
    internal static let cellHeight: CGFloat = 470.0
    
    private static let kInnerMargin: CGFloat = 20.0
    
    /// Core Motion Manager
    private let motionManager = CMMotionManager()
    
    /// Shadow View
    private weak var shadowView: UIView?

    /// Image View
    @IBOutlet private weak var imageView: UIImageView!{
        didSet{
            configure(imageView)
        }
    }
    
    /// Title Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    /// Button
    @IBOutlet private weak var button: UIButton!{
        didSet{
            configure(button)
        }
    }
    
    /// View
    @IBOutlet weak var view: UIView!{
        didSet{
            configureBasicView()
        }
    }
    
    /// ContainerView
    @IBOutlet weak var containerView: UIView!{
        didSet{
            configure(containerView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
}

// MARK : - Configurations
extension AppStoreCell {
    private func configure(_ view : UIView) {
        containerView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(blurEffectView)
        containerView.sendSubviewToBack(blurEffectView)
    }
    
    private func configure(_ button : UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = .white
        button.setTitle("Go transfer", for: .normal)
    }
    
    private func configure(_ label : UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.sizeToFit()
        label.minimumScaleFactor = 0.65
        label.textColor = .black
    }
    
    private func configureBasicView(){
        view.layer.cornerRadius = 16.0
        view.clipsToBounds = true
    }
}

// MARK : - Effects
extension AppStoreCell {
    // MARK: - Shadow
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: AppStoreCell.kInnerMargin,
                                              y: AppStoreCell.kInnerMargin,
                                              width: bounds.width - (2 * AppStoreCell.kInnerMargin),
                                              height: bounds.height - (2 * AppStoreCell.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        
        // Roll/Pitch Dynamic Shadow
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: { (motion, error) in
                if let motion = motion {
                    let pitch = motion.attitude.pitch * 10 // x-axis
                    let roll = motion.attitude.roll * 10 // y-axis
                    self.applyShadow(width: CGFloat(roll), height: CGFloat(pitch))
                }
            })
        }
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.35
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
}
