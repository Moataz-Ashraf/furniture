//
//  HomeCell.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit

class  HomeCell: UITableViewCell {
    
    // MARK: - Properties
    
   
    lazy var Name : UILabel = {
        let labelView = UILabel()
        labelView.textColor = UIColor.black
        labelView.font = UIFont.boldSystemFont(ofSize: 22)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
        
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: - Configration
        
        addSubview(Name)
        
        
        
        
        
        Name.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop:10, paddingLeft: 20, paddingBottom: 10, paddingRight: 5, width: 0, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
