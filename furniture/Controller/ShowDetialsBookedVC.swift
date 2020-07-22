//
//  ShowDetialsBookedVC.swift
//  furniture
//
//  Created by Moataz on 7/21/20.
//  Copyright © 2020 Moataz. All rights reserved.
//



import UIKit
import Firebase
import FirebaseAuth

class ShowDetialsBookedVC: UIViewController {

    // MARK: - Properties
    //var  UserData = ClientData()
    var  Items = [Products]()
    var curKey :String?
    var CurUser:String!
    var NameShop : String!
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Color")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.05)
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view.ProfileView(view: view, profileImageView: profileImageView, messageButton: AddImgButton, followButton: CurLocationButton, nameLabel: nameLabel, emailLabel: emailLabel)
    }()
    
    
    lazy var DowncontainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.flatGreenColorDark()?.darken(byPercentage: 0.3)
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "furniture-logo")
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    let AddImgButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "backbutton"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(BackBu), for: .touchUpInside)
        //handleMessageUser
        return button
    }()
    
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = " Shop Name "
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        //label.textAlignment = .center
        label.text = "Description of address"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let CurLocationButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "Call"), for: .normal)
           button.tintColor = .white
          // button.addTarget(self, action: #selector(handleMap), for: .touchUpInside)
           return button
       }()
    
    var segment = UISegmentedControl(items: ["Accepted","Request"])
    
    fileprivate var activityIndicator : UIActivityIndicatorView!
    
    
    
   // var KeyOfProduct : String!
   
    
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
       
       navigationController?.navigationBar.isHidden = true

        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Booked Items"
      
        
      
       
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!
        view.backgroundColor = .white
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
            
             LoadData(Accept: true)
              
        }
    }
    @objc func BackBu(){
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - API
   
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
        
        let ref = Database.database().reference().child("BookedItems").child(CurUser).child("UserData")

                  
                      
                       
                       ref.observe(.value, with: {(snapshot) in
                           
                           guard let UserData = snapshot.value as? [String:String] else { return }
                                         
                                        
                        self.profileImageView.image = self.convertBase64StringToImage(imageBase64String: UserData["ClientImage"]!)
                        self.nameLabel.text =  UserData["ClientName"]!
                        
                        self.emailLabel.text = "Address : \(UserData["DescriptionAddress"]!)"
                                        
                          
                                       
                        })
                    
                      
               
        
        
             let ref2 = Database.database().reference().child("BookedItems").child(CurUser).child("Shops").child(NameShop)
        
              ref2.observe(.childAdded, with: {(snapshot) in
               
                 guard let productsFromType = snapshot.value as? [String:Any] else { return }
                          
                 if productsFromType["Accept"] as? Bool == Accept {
                    self.curKey = snapshot.key
                    let NewShop = Products(Phone: productsFromType["Phone"]! as! String, ProductImage: productsFromType["ProductImage"]! as! String, ProductName: productsFromType["ProductName"]! as! String, ProductPrice: productsFromType["ProductPrice"]! as! String, ProductType: productsFromType["ProductType"]! as! String,NameShops : productsFromType["NameShop"]! as! String )
                               
                              self.Items.append(NewShop)
               
                              self.CollectionView.reloadData()
                
                    
                    
                      }
                 
              })
        
          self.activityIndicator.stopAnimating()
            
       
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
           self.CollectionView.reloadData()
           LoadData(Accept: true)
           
       case 1:
            self.Items = []
             self.CollectionView.reloadData()
            LoadData(Accept: false)
        
       default:
           print("3")
           
       }
   }
    func configureViewComponents() {
        
        segment.backgroundColor = UIColor(named: "Color")
        segment.tintColor = .white
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeVC), for: .valueChanged)
        //Set CollectioView
        view.addSubview(containerView)
        view.addSubview(segment )
        view.addSubview(CollectionView)
        // CollectionView.translatesAutoresizingMaskIntoConstraints = false

        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
        right: view.rightAnchor, height: 400)
        
        segment.anchor(top:  containerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        CollectionView.delegate = self
        CollectionView.dataSource = self

        CollectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.06)

        CollectionView.anchor(top: segment.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }

}
extension ShowDetialsBookedVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
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

       
     vc.imgView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage)
      vc.title = Items[indexPath.row].ProductName
      vc.phoneNumber = Items[indexPath.row].Phone
      
      vc.ShopLabel.text = "Shop : \(Items[indexPath.row].NameShops)"
      vc.ItemPrice.text = "Price : \(Items[indexPath.row].ProductPrice) $"
        vc.TypeLabel.text = "Type : \(Items[indexPath.row].ProductType.description)"
      vc.BackgroundImageView.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ProductImage).blurred(radius: 30)
        
        vc.BuBooked.isHidden = true
        vc.BuCall.isHidden = true
        vc.BuDelete.addTarget(self, action: #selector(ACDelete), for: .touchUpInside)
        vc.BuAccept.addTarget(self, action: #selector(ACAccept), for: .touchUpInside)
        
      let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
             navigationItem.backBarButtonItem = backBarButtonItem


      self.navigationController?.navigationBar.tintColor = UIColor(named: "Color1")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).darken(byPercentage: 0.1)
          navigationController?.pushViewController(vc, animated: true)

        

    }
    @objc func ACDelete() {
           let alertController = UIAlertController(title: nil, message: "Are you sure you want to Delete?", preferredStyle: .actionSheet)
           alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
               self.DeleteAction()
           }))
           alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           present(alertController, animated: true, completion: nil)
       }
    func DeleteAction(){
        let ref2 = Database.database().reference().child("BookedItems").child(CurUser).child("Shops").child(NameShop).child(curKey!)
        ref2.removeValue()
        LoadData(Accept: false)
         segment.selectedSegmentIndex = 1
        navigationController?.popViewController(animated: true)
        
    }
    @objc func ACAccept() {
              let alertController = UIAlertController(title: nil, message: "Are you sure you want to Accept ?", preferredStyle: .actionSheet)
              alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
                  self.AcceptAction()
              }))
              alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              present(alertController, animated: true, completion: nil)
          }
    func AcceptAction(){
        let ref2 = Database.database().reference().child("BookedItems").child(CurUser).child("Shops").child(NameShop).child(curKey!).child("Accept")
            ref2.setValue(true)
        LoadData(Accept: true)
         segment.selectedSegmentIndex = 0
        navigationController?.popViewController(animated: true)
        
    }

}






