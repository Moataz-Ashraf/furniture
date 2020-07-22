//
//  UserTabBarVC.swift
//  furniture
//
//  Created by Moataz on 7/20/20.
//  Copyright © 2020 Moataz. All rights reserved.
//
import Foundation
import UIKit
class UserTabBarVC: UITabBarController{
    
    // MARK: - Properties

    let BuHome : UIButton = {
                  let bu = UIButton()
                  bu.setImage(UIImage(named: "shopping-items")!.withRenderingMode(.alwaysOriginal), for: .normal)
                    
            bu.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
                 // bu.backgroundColor = .orange
                  //bu.layer.borderWidth = 0.5
                 // bu.layer.borderColor = UIColor.black.cgColor
                  
                  //bu.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                  //bu.layer.cornerRadius = 25
                  return bu
              }()
    
    
    @objc func ButtonTapped() {
        let vc = ShowUserBookedVC()
         tabBar.backgroundColor = UIColor(named: "Color2")
        vc.LoadData(Accept: true)
        vc.segment.selectedSegmentIndex = 0
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func configureTabBar(){
        
       
        
        view.addSubview(BuHome)
       
        BuHome.anchor(bottom: self.tabBar.topAnchor ,paddingBottom: -20,width: 50,height: 50)
        BuHome.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let firstViewController = UserProfileVC()
        
        firstViewController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "id-card").imageScaled(to: CGSize(width: 32, height: 32)), tag: 0)
        
        
       let secondViewController = CategoriesVC()
              secondViewController.ConfigureView()
        secondViewController.tabBarItem = UITabBarItem(title: "Categories", image:  #imageLiteral(resourceName: "007-armchair-1").imageScaled(to: CGSize(width: 32, height: 32)) , tag: 1)
       
        
        
        let tabBarList = [firstViewController,secondViewController,]
        
        self.viewControllers = tabBarList
       
   
    }
          
    // MARK:- ShowError
    
    func ShowError(message : String){
        
        let alert = UIAlertController(title: "Message For You", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }) )
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       setValue(CustomTabBar(), forKey: "tabBar")
        tabBar.tintColor = UIColor(named: "Color")!
        configureTabBar()
        //configureViewComponents()
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        
        //view.backgroundColor = UIColor.white
        //navigationController?.navigationBar.isHidden = false
       // navigationItem.title = "Program"
       // self.navigationItem.setHidesBackButton(true, animated:true);
        
        // navigationItem.title = "Training Program"
        
        
    }
}

