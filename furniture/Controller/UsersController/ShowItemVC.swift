//
//  ShowItemVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit

class ShowItemVC: UIViewController {
    var phoneNumber : String?
    
    let BackgroundImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
       
        
        return iv
    }()
    
    let MiddleView : UIView = {
           let v = UIView()
        v.backgroundColor = UIColor.white//.darken(byPercentage: 0.09)//(white: 0.9, alpha: 0.5)
            
           
            v.clipsToBounds = true
            //v.layer.borderWidth = 2
            //v.layer.borderColor = UIColor.blue.cgColor
            v.layer.cornerRadius = 20
            v.layer.shadowRadius = 5
            
            return v
        }()
    let imgView : UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "p2")
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
        let NameLabel : UILabel = {
            let l = UILabel()
            l.text = "Details"
            l.font = UIFont.boldSystemFont(ofSize: 30)
            l.textColor = UIColor.red
            return l
        }()
        let ItemPrice : UILabel = {
            let l = UILabel()
            l.text = "300$"
            l.font = UIFont.systemFont(ofSize: 20)
            l.textColor = UIColor.darkGray
            return l
        }()
    let ShopLabel : UILabel = {
        let l = UILabel()
        l.text = "NameShop"
        l.font = UIFont.systemFont(ofSize: 20)
        return l
    }()
    let TypeLabel : UILabel = {
           let l = UILabel()
           l.text = "Type"
           l.font = UIFont.systemFont(ofSize: 20)
           return l
       }()
    
    let BuCall : UIButton = {
               let bu = UIButton()
               bu.setImage(UIImage(named: "Call2")!.withRenderingMode(.alwaysOriginal), for: .normal)
              
               bu.addTarget(self, action: #selector(Call), for: .touchUpInside)
              
               return bu
           }()
    let BuBooked : UIButton = {
                  let bu = UIButton()
                  bu.setImage(UIImage(named: "shopping-items")!.withRenderingMode(.alwaysOriginal), for: .normal)
                  bu.addTarget(self, action: #selector(Booked), for: .touchUpInside)
                  
                  
                  return bu
              }()
    @objc func Booked(){
        let vc = BookedVC(CurImage: self.imgView.image!)
        
            navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @objc func Call(){
         if let phoneCallURL = URL(string: "telprompt://\(phoneNumber!)") {

               let application:UIApplication = UIApplication.shared
               if (application.canOpenURL(phoneCallURL)) {
                   if #available(iOS 10.0, *) {
                       application.open(phoneCallURL, options: [:], completionHandler: nil)
                   } else {
                       // Fallback on earlier versions
                        application.openURL(phoneCallURL as URL)

                   }
               }
           }
          

//          if let url = URL(string: "tel://\(phoneNumber!)"),
//          UIApplication.shared.canOpenURL(url) {
//          UIApplication.shared.open(url, options: [:], completionHandler: nil)
//          }else{
//            print("Call error !!")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       CreateUI()
        //view.backgroundColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.1)//UIColor.white.darken(byPercentage: 0.9)
        
       
       
    
    }
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
             
      
       
        //navigationController?.navigationBar.barTintColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
       
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
            navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!

          }
    
    func CreateUI(){
        
        view.addSubview(BackgroundImageView)
        view.addSubview(MiddleView)
        view.addSubview(imgView)
         view.addSubview(NameLabel)
        view.addSubview(ItemPrice)
        view.addSubview(ShopLabel)
        view.addSubview(TypeLabel)
        view.addSubview(BuCall)
         view.addSubview(BuBooked)
        //BuHome.anchor(bottom:view.bottomAnchor,paddingBottom: -25,width: 50,height: 50)
       //BuHome.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right:view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:
        UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        MiddleView.anchor( width: UIScreen.main.bounds.width-30, height: 250)
        MiddleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        MiddleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        imgView.anchor(bottom:NameLabel.topAnchor,paddingBottom: 0,width: UIScreen.main.bounds.width-60,height: 260)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NameLabel.anchor(left: MiddleView.leftAnchor, bottom:ShopLabel.topAnchor,paddingLeft: 5 ,paddingBottom: 5)
       // NameLabel.centerXAnchor.constraint(equalTo: MiddleView.centerXAnchor).isActive = true
        
        ShopLabel.anchor(left: MiddleView.leftAnchor,bottom:TypeLabel.topAnchor,paddingLeft: 15 ,paddingBottom: 5)
       // ShopLabel.centerXAnchor.constraint(equalTo: MiddleView.centerXAnchor).isActive = true
        
        TypeLabel.anchor(left: MiddleView.leftAnchor,bottom:ItemPrice.topAnchor,paddingLeft: 15 ,paddingBottom: 5)
        //TypeLabel.centerXAnchor.constraint(equalTo: MiddleView.centerXAnchor).isActive = true
        
       ItemPrice.anchor(left: MiddleView.leftAnchor,bottom:MiddleView.bottomAnchor,paddingLeft: 15 ,paddingBottom: 10)
        //ItemPrice.centerXAnchor.constraint(equalTo: MiddleView.centerXAnchor).isActive = true
        BuCall.anchor(bottom: MiddleView.bottomAnchor, right: MiddleView.rightAnchor,paddingBottom: 10 ,paddingRight: 10,width: 50,height: 50)
        BuBooked.anchor(bottom: BuCall.topAnchor, right: MiddleView.rightAnchor,paddingBottom: 10 ,paddingRight: 10,width: 50,height: 50)
    }
}
//    var imgView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "a50291cf7baa9d43d3880c734be9efb7")
//
//        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = UIColor.white//.darken(byPercentage: 0.1)
//        iv.layer.cornerRadius = 50
//        //iv.layer.borderColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).cgColor
//        iv.clipsToBounds = true
//        //iv.layer.borderWidth = 2
//        return iv
//    }()
//    let NameLabel: UILabel = {
//        let label = UILabel()
//       label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.textColor = .red
//        label.text = "Moka Sofa"
//        return label
//    }()
//    var DescriptionLabel : UILabel!
//
//
//    let ItemType: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.text = "Type  :  Sofa"
//        return label
//    }()
//    let ItemPrice: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.text = "Price  :  3.4 $"
//        return label
//    }()
//    let NameShop: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.text = "Shop  :  Shahen Shops"
//        return label
//    }()
//    let BuContact: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Contact ", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor.flatGreenColorDark()
//       // button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        button.layer.cornerRadius = 5
//        return button
//    }()
//    let BuTry: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Try", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)//UIColor(red:0.42, green:0.79, blue:0.43, alpha:1.0)
//       // button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        button.layer.cornerRadius = 5
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        LayoutUI()
//    }
//
//    //MARK: - Design Methods
//    func ConfigureView(){
//
//        view.backgroundColor = UIColor.white.darken(byPercentage: 0.005)
//
//        title = "Item"
//
//        DescriptionLabel = UILabel()
//
//
//
//        DescriptionLabel.font = UIFont.boldSystemFont(ofSize: 15)
//        DescriptionLabel.textColor = .black
//        DescriptionLabel.numberOfLines = 0
//        DescriptionLabel.lineBreakMode = .byWordWrapping
//
//    }
//
//    func AddSubView(){
//        view.addSubview(imgView)
//        view.addSubview(NameLabel)
//        view.addSubview(ItemType)
//        view.addSubview(ItemPrice)
//        view.addSubview(NameShop)
//        view.addSubview(BuContact)
//        view.addSubview(BuTry)
//
//       // view.addSubview(DescriptionLabel)
//    }
//    func Constraints(){
//
//        imgView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
//        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//
//        NameLabel.anchor(top: imgView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        NameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//
//        ItemType.translatesAutoresizingMaskIntoConstraints = false
//        ItemType.anchor(top: NameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
//
//         ItemPrice.anchor(top: ItemType.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
//
//         NameShop.anchor(top: ItemPrice.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
//
//        BuContact.anchor(top: NameShop.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
//
//         BuTry.anchor(top: BuContact.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 50)
//
//    }
//    func LayoutUI(){
//        ConfigureView()
//        AddSubView()
//        Constraints()
//
//    }
   
    
