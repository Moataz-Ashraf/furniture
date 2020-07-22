//
//  ShowUserBookedVC.swift
//  furniture
//
//  Created by Moataz on 7/21/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ShowUserBookedVC : UIViewController {

    // MARK: - Properties
    fileprivate var activityIndicator : UIActivityIndicatorView!
    
    var  Items = [Products]()
   // var KeyOfProduct : String!
   var segment = UISegmentedControl(items: ["Accepted","Request"])
    
    var imagePicker = UIImagePickerController()

    var img  = UIImage()
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
        
       
    
    }
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       navigationController?.navigationBar.isHidden = false

        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Booked Items"
      
        
      //  self.navigationController?.navigationItem.backBarButtonItem?.action = #selector(backbuttonAction)
        
       
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!

    }
    
   
//    @objc func backbuttonAction (){
//        self.navigationController?.popToRootViewController(animated: true)
//       }
    

   
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginVC())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            configureViewComponents()
           
            //LoadData(Accept: true)
              
        }
    }

    // MARK: - API
   
//    func LoadDataFromShops(CurUser:String ,NameShop : String) {
//
//   activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
//
//                       activityIndicator.hidesWhenStopped = true
//                        activityIndicator.startAnimating()
//                        view.addSubview(activityIndicator)
//                        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//                        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//             let ref2 = Database.database().reference().child("BookedItems").child(CurUser).child("Shops").child("MMMM")
//
//              ref2.observe(.childAdded, with: {(snapshot) in
//
//                 guard let productsFromType = snapshot.value as? [String:String] else { return }
//
//
//
//                               let NewShop = Products(Phone: productsFromType["Phone"]!, ProductImage: productsFromType["ProductImage"]!, ProductName: productsFromType["ProductName"]!, ProductPrice: productsFromType["ProductPrice"]!, ProductType: productsFromType["ProductType"]!,NameShops : productsFromType["NameShop"]!)
//
//                              self.Items.append(NewShop)
//
//                              self.CollectionView.reloadData()
//
//                     self.activityIndicator.stopAnimating()
//
//              })
//
//
//
//
//    }

    func LoadData(Accept : Bool) {
          Items = []
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
          activityIndicator.color = UIColor(named: "Color")!
        activityIndicator.hidesWhenStopped = true
         activityIndicator.startAnimating()
         view.addSubview(activityIndicator)
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
         guard let CurUser = Auth.auth().currentUser?.uid else{return}
        let ref = Database.database().reference().child("BookedItems").child(CurUser).child("Shops")

           
               ref.observe(.childAdded, with: {(snapshot) in
               // guard let shops = snapshot.children as? [String : [String:String]] else { return }
                let ref2 = Database.database().reference().child("BookedItems").child(CurUser).child("Shops").child(snapshot.key)
                
                 ref2.observe(.childAdded, with: {(snapshot) in
                   
                    guard let productsFromType = snapshot.value as? [String:Any] else { return }
                                  
                    if productsFromType["Accept"]as? Bool == Accept {
                   
                                  
                    let NewShop = Products(Phone: productsFromType["Phone"]! as! String, ProductImage: productsFromType["ProductImage"]! as! String, ProductName: productsFromType["ProductName"]! as! String, ProductPrice: productsFromType["ProductPrice"]! as! String, ProductType: productsFromType["ProductType"]! as! String,NameShops : productsFromType["NameShop"]! as! String)
                                  
                                 self.Items.append(NewShop)
                   
                                 self.CollectionView.reloadData()
                                 
                    }
                    self.activityIndicator.stopAnimating()
                 })
             
               
           })
       }
    // MARK: - Helper Functions
    
    func convertImageToBase64String (img: UIImage) -> String {
           return img.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
       }

       func convertBase64StringToImage (imageBase64String:String) -> UIImage {
           let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
           let image = UIImage(data: imageData!)
           return image!
       }
   @objc func changeVC(sender: UISegmentedControl) {
        
         switch sender.selectedSegmentIndex {
         case 0:
             self.Items = []
            //self.CollectionView.reloadData()
             LoadData(Accept: true)
           // self.CollectionView.reloadData()
             
         case 1:
              self.Items = []
              // self.CollectionView.reloadData()
              LoadData(Accept: false)
            
         default:
             print("3")
             
         }
     }
   
    func configureViewComponents() {
 
        
       //  segment.layer.cornerRadius = 5.0
        segment.backgroundColor = UIColor(named: "Color")
        segment.tintColor = .white
         segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeVC), for: .valueChanged)
        //Set CollectioView
       
        view.addSubview(CollectionView)
         view.addSubview(segment)
        // CollectionView.translatesAutoresizingMaskIntoConstraints = false

        
        
        CollectionView.delegate = self
        CollectionView.dataSource = self

        CollectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.06)

        CollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: segment.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        segment.anchor(top:  nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }

}
extension ShowUserBookedVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MYCell", for: indexPath) as! CustomCollectionViewCell

        cell.backgroundColor = .white//UIColor(red:0.93, green:0.88, blue:0.68, alpha:1.0)
        cell.layer.cornerRadius = 20
        cell.NameCoachlabel.text = Items[indexPath.row].ProductName
        cell.CoachImage.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage)
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
        
        vc.BuBooked.isHidden = true
        vc.BuAccept.isHidden = true
        vc.BuDelete.isHidden = true
       
     vc.imgView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage)
      vc.title = Items[indexPath.row].ProductName
      vc.phoneNumber = Items[indexPath.row].Phone
      
      vc.ShopLabel.text = "Shop : \(Items[indexPath.row].NameShops)"
      vc.ItemPrice.text = "Price : \(Items[indexPath.row].ProductPrice)"
        vc.TypeLabel.text = "Type : \(Items[indexPath.row].ProductType.description)"
      vc.BackgroundImageView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage).blurred(radius: 30)
        
        
      let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             navigationItem.backBarButtonItem = backBarButtonItem


      self.navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.1)
          navigationController?.pushViewController(vc, animated: true)

        

    }



}





