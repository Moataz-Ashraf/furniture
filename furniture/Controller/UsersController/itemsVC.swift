//
//  itemsVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class itemsVC : UIViewController {

    // MARK: - Properties
    fileprivate var activityIndicator : UIActivityIndicatorView!
    
    var  Items = [Products]()
    //var KeyOfProduct : String!
   
    
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

    private var ProductType : String!
    
    
    init(ProductType : String ){
        self.ProductType = ProductType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       navigationController?.navigationBar.isHidden = false

        //navigationController?.navigationBar.backgroundColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = ProductType
       // navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color3")!]
        
        
      
       
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!

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
            LoadData()
        }
    }

    // MARK: - API
   


     func LoadData() {
        let ref = Database.database().reference().child("Products").child(ProductType)

           
               ref.observe(.childAdded, with: {(snapshot) in
               guard let productsFromType = snapshot.value as? [String:String] else { return }
                 
             //   self.KeyOfProduct = snapshot.key
                
                let NewShop = Products(Phone: productsFromType["Phone"]!, ProductImage: productsFromType["ProductImage"]!, ProductName: productsFromType["ProductName"]!, ProductPrice: productsFromType["ProductPrice"]!, ProductType: productsFromType["ProductType"]!,NameShops : productsFromType["NameShops"]!,KeyOfProduct: snapshot.key)
                
               self.Items.append(NewShop)
               self.CollectionView.reloadData()
               self.activityIndicator.stopAnimating()
               
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
   
    func configureViewComponents() {
 
        //Set CollectioView

        view.addSubview(CollectionView)
        // CollectionView.translatesAutoresizingMaskIntoConstraints = false

        CollectionView.delegate = self
        CollectionView.dataSource = self

        CollectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.06)

        CollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }

}
extension itemsVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
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
        vc.BuAccept.isHidden = true
        vc.BuDelete.isHidden = true
        vc.KeyOfProduct = Items[indexPath.row].KeyOfProduct
        vc.CurType = Items[indexPath.row].ProductType.description
        vc.CurShop = Items[indexPath.row].NameShops
     vc.imgView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage)
      vc.title = Items[indexPath.row].ProductName
      vc.phoneNumber = Items[indexPath.row].Phone
      //vc.NameLabel.text = shops[indexPath.row].Products.ProductName
      vc.ShopLabel.text = "Shop : \(Items[indexPath.row].NameShops)"
      vc.ItemPrice.text = "Price : \(Items[indexPath.row].ProductPrice) $"
        vc.TypeLabel.text = "Type : \(Items[indexPath.row].ProductType.description)"
      vc.BackgroundImageView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage).blurred(radius: 30)
      let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             navigationItem.backBarButtonItem = backBarButtonItem
      

      self.navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.1)
          navigationController?.pushViewController(vc, animated: true)

        

    }



}




//MARK: - Image Picker


