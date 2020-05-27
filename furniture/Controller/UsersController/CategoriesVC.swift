//
//  CategoriesVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import ChameleonFramework
class CategoriesVC: UIViewController {
    
    //MARK: - Properties
    let reuseIdentifer = "MenuOptionCell"
    var collectionView: UICollectionView!
    
    //MARK: - load & init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LayoutUI()
        
    }
    
    //MARK: - Design Methods
    func ConfigureView(){
        
        title = " Category "
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.04)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func AddSubView(){
        view.addSubview(collectionView)

    }
    func Constraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    func LayoutUI(){
        ConfigureView()
        AddSubView()
        Constraints()
        
    }
    
}
