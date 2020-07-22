//
//  AddItemsVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class ItemsVC : UIViewController{
    
    
    fileprivate var activityIndicator : UIActivityIndicatorView!

    
    // MARK: - Properties
    var shops = [Shops]()
   
    var shopName : String!
    
    var CollectionView : UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let  myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "MYCell")
        
        return myCollectionView
    }()
    
    
    // MARK: - Init
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        authenticateUserAndConfigureView()
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
         activityIndicator.color = UIColor(named: "Color")!
       activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
    }
    
    
    
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @objc func handleAddCell() {
       
        navigationController?.pushViewController(AddNewItemsVC(shopName: shopName), animated: true)
        
        
    }
    
    @objc func handleLogin() {
        //  alertview.removeFromSuperview()
    }
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginVC())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            configureViewComponents()
            self.LoadData()
        }
    }
    
    // MARK: - API
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    func LoadData() {
      let ref = Database.database().reference().child("Shops").child(Auth.auth().currentUser!.uid)
        ref.observeSingleEvent(of: .value, with: { (Snapshot) in

            guard let shop = Snapshot.value as?[String : Any] else { return }
            self.shopName = shop["NameShops"] as? String

        })
        
            ref.child("Products").observe(.childAdded, with: {(snapshot) in
            guard let shop = snapshot.value as? [String:String] else { return }
              
                
                let NewShop = Shops(Shop: Shop(NameShops: self.shopName , ImageShops: ""), Products: ProductOfShop(Phone: shop["Phone"]!, ProductImage: shop["ProductImage"]!, ProductName: shop["ProductName"]!, ProductPrice: shop["ProductPrice"]!, ProductType: shop["ProductType"]!))
            self.shops.append(NewShop)
            self.CollectionView.reloadData()
            self.activityIndicator.stopAnimating()
            
        })
    }
    
    // MARK: - Helper Functions
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       navigationController?.navigationBar.isHidden = false

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Items"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color2")!]
        
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCell))
       
       navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Color1")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
       navigationItem.leftBarButtonItem?.tintColor = .black
       navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!

    }
    func configureViewComponents() {
     
        
        
        //Set TableView
        
        view.addSubview(CollectionView)
        // CollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        CollectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.06)
        
        CollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
}
extension ItemsVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MYCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.backgroundColor = .white//UIColor(red:0.93, green:0.88, blue:0.68, alpha:1.0)
        cell.layer.cornerRadius = 20
        cell.NameCoachlabel.text = shops[indexPath.row].Products.ProductName
        cell.CoachImage.image = convertBase64StringToImage(imageBase64String:shops[indexPath.row].Products.ProductImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/2.1, height: (view.frame.height)/4.05)
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
        
        let vc = ShowItemVC()
        vc.BuAccept.isHidden = true
        vc.BuDelete.isHidden = true
        vc.BuBooked.isHidden = true
        vc.BuCall.isHidden = true
        //vc.BuContact.setTitle(shops[indexPath.row].Products.Phone, for: .normal)
        vc.imgView.image = convertBase64StringToImage(imageBase64String:shops[indexPath.row].Products.ProductImage)
        vc.title = shops[indexPath.row].Products.ProductName
        vc.phoneNumber = shops[indexPath.row].Products.Phone
        //vc.NameLabel.text = shops[indexPath.row].Products.ProductName
        vc.ShopLabel.text = "Shop : \(shops[indexPath.row].Shop.NameShops)"
        vc.ItemPrice.text = "Price : \(shops[indexPath.row].Products.ProductPrice) $"
        vc.TypeLabel.text = "Type : \(shops[indexPath.row].Products.ProductType.description)"
        vc.BackgroundImageView.image = convertBase64StringToImage(imageBase64String:shops[indexPath.row].Products.ProductImage).blurred(radius: 30)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
               navigationItem.backBarButtonItem = backBarButtonItem
        

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.1)
            navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}




