//
//  ShopsProfileVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ShopsProfileVC : UIViewController{
    
    // MARK: - UI Design
    
    
    
    
    fileprivate var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - CollectionViewProperties
    let reuseIdentifer = "ProfileCell"
    var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    var imagePicker = UIImagePickerController()
    
    
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
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    let AddImgButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "log-out"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        //handleMessageUser
        return button
    }()
    
    let CurLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-location-100-4").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMap), for: .touchUpInside)
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
        label.textAlignment = .center
        label.text = Auth.auth().currentUser?.email!
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        authenticateUserAndConfigureView()

        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.isHidden = true
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func handleMessageUser() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
   
    
    @objc func handleMap() {
        
        let vc = MapVC()
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
        
        
    }
   
    //MARK: - Design Methods
    func ConfigureView(){
        
        view.backgroundColor = UIColor.white.darken(byPercentage: 0.001)
        navigationController?.navigationBar.isHidden = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.backgroundColor = UIColor.white.darken(byPercentage: 0.04)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
    }
    
    func AddSubView(){
        view.addSubview(containerView)
        view.addSubview(collectionView)
        
    }
    func Constraints(){
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                             right: view.rightAnchor, height: 400)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    func LayoutUI(){
        ConfigureView()
        AddSubView()
        Constraints()

        
    }
    // MARK: - Helper Functions
    func loadData(){
        
        
            Database.database().reference().child("Shops").child(Auth.auth().currentUser!.uid).observe(.value, with: {(snapshot) in
                guard let Shop = snapshot.value as?[String : Any] else { return }
                self.nameLabel.text = Shop["NameShops"] as? String
//                let img = Shop["ImageShop"]as? String
//                self.profileImageView.image = self.convertBase64StringToImage(imageBase64String:img!)
//             
               
                self.activityIndicator.stopAnimating()
                
                print("ShopsProfileVC")

            })
        
               
        }
    
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginVC())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
        } else {

            LayoutUI()
            loadData()
            
        }
    }
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            let navController = UINavigationController(rootViewController: LoginVC())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    func ShowError(message : String){
        
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }) )
        present(alert, animated: true, completion: nil)
        
    }
    

}


extension ShopsProfileVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        
        profileImageView.image = image
    }
    
}








