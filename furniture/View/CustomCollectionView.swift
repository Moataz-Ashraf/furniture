//
//  CustomCollectionViewCell.swift
//  GYM
//
//  Created by Moataz on 2/28/20.
//  Copyright © 2020 Moataz. All rights reserved.
//


import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var CoachImage : UIImageView = {
        let MyimageView = UIImageView()
        MyimageView.contentMode = .scaleAspectFit
        MyimageView.clipsToBounds = true
        MyimageView.layer.cornerRadius = 50
        MyimageView.translatesAutoresizingMaskIntoConstraints = false
        return MyimageView
    }()
    lazy var NameCoachlabel : UILabel = {
        let labelView = UILabel()
        labelView.textColor = .black
        labelView.textAlignment = .center
        labelView.font = UIFont.boldSystemFont(ofSize: 15)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
        
    }()
    
    fileprivate func setup() {
        
        addSubview(CoachImage)
        addSubview(NameCoachlabel)
        
        CoachImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5 , paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: frame.height-(NameCoachlabel.frame.height+50))
        
        
        NameCoachlabel.anchor(top: CoachImage.bottomAnchor, left: nil, bottom: bottomAnchor , right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 0, width: frame.width, height: 0)
        //NameCoachlabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        // MARK: - Configration
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

