//
//  HomeVC.swift
//  MyInstagram
//
//  Created by Moataz on 2/7/20.
//  Copyright © 2020 Moataz. All rights reserved.
//
//


import UIKit
import Firebase
import FirebaseAuth


class HomeVC: UIViewController{
    //MARK: - Properties
    let reuseIdentifer = "HomeCell"
    let furniture = ["Bed Rooms","Dining Rooms","Living Rooms","Bed Rooms","Entries","Offices","Kitchens","Gardens","Home Exteriors" ]
    lazy var TableView : UITableView = {
        
        let TV = UITableView()
        TV.register(HomeCell.self, forCellReuseIdentifier: reuseIdentifer)
        TV.translatesAutoresizingMaskIntoConstraints = false
        TV.separatorInset.bottom = 20
        TV.separatorColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        return TV
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureView()
        authenticateUserAndConfigureView()
    
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
    
    //MARK: - Design Methods
    func ConfigureView(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        title = " Furniture "
        
        
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    
    func AddSubView(){
        view.addSubview(TableView)
        
    }
    func Constraints(){
        TableView.translatesAutoresizingMaskIntoConstraints = false
        TableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        TableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        TableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    func LayoutUI(){
        
        AddSubView()
        Constraints()
        
    }
    
}
