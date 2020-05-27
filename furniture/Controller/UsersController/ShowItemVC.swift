//
//  ShowItemVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit

class ShowItemVC: UIViewController {
    
    
    var imgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "a50291cf7baa9d43d3880c734be9efb7")
        
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.white//.darken(byPercentage: 0.1)
        iv.layer.cornerRadius = 50
        //iv.layer.borderColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).cgColor
        iv.clipsToBounds = true
        //iv.layer.borderWidth = 2
        return iv
    }()
    let NameLabel: UILabel = {
        let label = UILabel()        
       label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .red
        label.text = "Moka Sofa"
        return label
    }()
    var DescriptionLabel : UILabel!
    
    
    let ItemType: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Type  :  Sofa"
        return label
    }()
    let ItemPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Price  :  3.4 $"
        return label
    }()
    let NameShop: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Shop  :  Shahen Shops"
        return label
    }()
    let BuContact: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Contact ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.flatGreenColorDark()
       // button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    let BuTry: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)//UIColor(red:0.42, green:0.79, blue:0.43, alpha:1.0)
       // button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LayoutUI()
    }
    
    //MARK: - Design Methods
    func ConfigureView(){
        
        view.backgroundColor = UIColor.white.darken(byPercentage: 0.005)
        
        title = "Item"

        DescriptionLabel = UILabel()
        
    
        
        DescriptionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        DescriptionLabel.textColor = .black
        DescriptionLabel.numberOfLines = 0
        DescriptionLabel.lineBreakMode = .byWordWrapping
        
    }
    
    func AddSubView(){
        view.addSubview(imgView)
        view.addSubview(NameLabel)
        view.addSubview(ItemType)
        view.addSubview(ItemPrice)
        view.addSubview(NameShop)
        view.addSubview(BuContact)
        view.addSubview(BuTry)

       // view.addSubview(DescriptionLabel)
    }
    func Constraints(){
        
        imgView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        NameLabel.anchor(top: imgView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        NameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        ItemType.translatesAutoresizingMaskIntoConstraints = false
        ItemType.anchor(top: NameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
         ItemPrice.anchor(top: ItemType.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
         NameShop.anchor(top: ItemPrice.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        BuContact.anchor(top: NameShop.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
        
         BuTry.anchor(top: BuContact.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 50)
        
    }
    func LayoutUI(){
        ConfigureView()
        AddSubView()
        Constraints()
        
    }
   
    
}
