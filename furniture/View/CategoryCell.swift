//
//  CategoryCell.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit


class CategoryCell: UICollectionViewCell{
    
    // MARK: - Properties
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Sample text"
        return label
    }()
    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.darken(byPercentage: 0.1)?.cgColor
        layer.cornerRadius = 20
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 32, height: 32)
        
        
        addSubview(NameLabel)
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NameLabel.anchor(top: iconImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        // MARK: - Configration
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
}
