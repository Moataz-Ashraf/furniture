//
//  ShopsProfileVC+Extention.swift
//  MyInstagram
//
//  Created by Moataz on 4/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit

extension ShopsProfileVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as!CategoryCell
        cell.backgroundColor = .white
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.NameLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/2.109, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
        navigationController?.pushViewController(ItemsVC(), animated: true)
        }else if indexPath.row == 1{
            navigationController?.pushViewController(ShopsBookedVC(NameShop: self.nameLabel.text!), animated: true)
        }
        else if indexPath.row == 2{
            navigationController?.pushViewController(AddNewItemsVC(shopName: self.nameLabel.text!), animated: true)
        }
        
    }
    
    
}
