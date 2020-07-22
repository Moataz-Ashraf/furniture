//
//  ShopsBookedVC.swift
//  furniture
//
//  Created by Moataz on 7/21/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ShopsBookedVC : UIViewController {

    // MARK: - Properties
    fileprivate var activityIndicator : UIActivityIndicatorView!
    
    var  Items = [ClientData]()
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

    private var NameShop : String!


    init(NameShop : String ){
        self.NameShop = NameShop

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        navigationItem.title = "Clients"
   
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
        
         activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
         activityIndicator.color = UIColor(named: "Color")!
         activityIndicator.hidesWhenStopped = true
         activityIndicator.startAnimating()
         view.addSubview(activityIndicator)
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let ref = Database.database().reference().child("BookedItems")

           
               ref.observe(.childAdded, with: {(snapshot) in
              
                let ref2 = Database.database().reference().child("BookedItems").child(snapshot.key).child("UserData")
                let CurKey = snapshot.key
                ref2.observe(.value, with: {(snapshot) in
                    
                    guard let UserData = snapshot.value as? [String:String] else { return }
                                  
                    
                                  
                                  let NewUserData = ClientData(Phone: UserData["Phone"]!, ClientImage: UserData["ClientImage"]!, ClientName: UserData["ClientName"]!, DescriptionAddress: UserData["DescriptionAddress"]!,KeyOfUser: CurKey)
                                  //, UserLocation: UserData["UserLocation"]!
                                 self.Items.append(NewUserData)
                   
                                 self.CollectionView.reloadData()
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
extension ShopsBookedVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MYCell", for: indexPath) as! CustomCollectionViewCell

        cell.backgroundColor = .white//UIColor(red:0.93, green:0.88, blue:0.68, alpha:1.0)
        cell.layer.cornerRadius = 20
        cell.NameCoachlabel.text = Items[indexPath.row].ClientName
        cell.CoachImage.image = convertBase64StringToImage(imageBase64String:Items[indexPath.row].ClientImage)
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

        let vc = ShowDetialsBookedVC()
        vc.CurUser = Items[indexPath.row].KeyOfUser!
        vc.NameShop = self.NameShop!
       // vc.LoadData(Accept : true)
        vc.navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)

        

    }



}
