//
//  HeaderCollectionViewCell.swift
//  Find.Excange
//
//  Created by Dario Langella on 17/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    internal static let cellHeight: CGFloat = 56.0
    
    /// Label
    @IBOutlet private weak var titleLabel: UILabel!
    
    ///Bool
    private var isEnabled: Bool = false {
        didSet{
            configure(isEnabled)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure(titleLabel)
    }
}

//MARK : - Configurations

extension HeaderCollectionViewCell {
    private func configure(_ label : UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = label.frame.size.height / 2
    }
    
    private func configure(_ highlighted : Bool) {
        if highlighted {
            self.titleLabel.backgroundColor = .black
            self.titleLabel.textColor = .white
        } else {
            self.titleLabel.backgroundColor = .clear
            self.titleLabel.textColor = .lightGray
        }
    }
}

//MARK : - Setter

extension HeaderCollectionViewCell {
    public func set(_ title : String, _ enabled : Bool) {
        isEnabled = enabled
        titleLabel.text = title
    }
}
