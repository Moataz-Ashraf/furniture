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
    var KeyOfProduct : String?
    var CurType : String?
     var CurShop : String?
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
    let BuDelete : UIButton = {
        let bu = UIButton()
        bu.setImage(UIImage(named:"004-cross")!.withRenderingMode(.alwaysOriginal), for: .normal)
        //bu.setTitle("Delete", for: .normal)
       
        
       // bu.layer.cornerRadius = 25
       // bu.addTarget(self, action: #selector(ACDelete), for: .touchUpInside)
        
        
        return bu
    }()
    let BuAccept : UIButton = {
        let bu = UIButton()
        bu.setImage(UIImage(named:"003-tick")!.withRenderingMode(.alwaysOriginal), for: .normal)
        
        return bu
    }()
    @objc func Booked(){
        let vc = BookedVC(curKeyOfProduct: self.KeyOfProduct!)
        vc.curImage = self.imgView.image!
        vc.CurShop = self.CurShop
        vc.CurType = self.CurType
            navigationController?.pushViewController(vc, animated: true)
    
    }
//    @objc func ACDelete() {
//           let alertController = UIAlertController(title: nil, message: "Are you sure you want to Delete?", preferredStyle: .actionSheet)
//           alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
//               self.DeleteAction()
//           }))
//           alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//           present(alertController, animated: true, completion: nil)
//       }
//    func DeleteAction(){
//
//    }
    
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
        view.addSubview(BuDelete)
        view.addSubview(BuAccept)
        //BuHome.anchor(bottom:view.bottomAnchor,paddingBottom: -25,width: 50,height: 50)
       //BuHome.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right:view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:
        UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        MiddleView.anchor( width: UIScreen.main.bounds.width-30, height: 250)
        MiddleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        MiddleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        BuAccept.anchor(top:MiddleView.bottomAnchor,paddingTop: 5,width:50 ,height: 50)
          //BuDelete.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BuDelete.anchor(top:MiddleView.bottomAnchor,left:view.leftAnchor,right: BuAccept.leftAnchor,paddingTop: 5,paddingLeft: (UIScreen.main.bounds.width-view.center.x)-50,paddingRight: 20, width:50 ,height: 50 )
      
        
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
