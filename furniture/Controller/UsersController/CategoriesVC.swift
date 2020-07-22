//
//  CategoriesVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseAuth

//@available(iOS 13.0, *)
class CategoriesVC: UIViewController {
    
    //MARK: - Properties
    let reuseIdentifer = "MenuOptionCell"
    var collectionView: UICollectionView!
    
       

    
    //MARK: - load & init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigureView()
        LayoutUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!
        
        view.backgroundColor = UIColor(named: "Color")!
        
        self.tabBarController?.navigationItem.title = " Category "

        
        let backBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "log-out") , style: .plain, target: self, action: #selector(handleSignOut))
        
          self.tabBarController?.navigationItem.leftBarButtonItem = backBarButtonItem
            navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!
      //navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!]
     
     
      //print(  self.navigationController?.navigationBar.frame.height)

        }
    //MARK: - API Methods

    func authenticateUserAndConfigureView() {
                if Auth.auth().currentUser == nil {
                    DispatchQueue.main.async {
                        let navController = UINavigationController(rootViewController: LoginVC())
                        navController.navigationBar.barStyle = .black
                        self.present(navController, animated: true, completion: nil)
                    }
                } else {
                    
                   LayoutUI()
                    
                }
            }
    @objc func handleSignOut() {
           let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
           alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
               self.signOut()
           }))
           alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           present(alertController, animated: true, completion: nil)
       }
    
     func signOut() {
           do {
               try Auth.auth().signOut()
               let navController = UINavigationController(rootViewController: LoginVC())
               navController.navigationBar.barStyle = .black
               self.present(navController, animated: true, completion: nil)
           } catch let error {
               print("Failed to sign out with error..", error)
           }
       }
    
    
           
    //MARK: - Design Methods
    func ConfigureView(){
        
        
        
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
     
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 95, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
        
    }
    func LayoutUI(){
        ConfigureView()
        AddSubView()
        Constraints()
        
    }
    
}
