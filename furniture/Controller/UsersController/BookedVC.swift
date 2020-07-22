//
//  BookedVC.swift
//  furniture
//
//  Created by Moataz on 7/18/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import Firebase

class BookedVC: UIViewController {
    // MARK: - Properties
    var curImage : UIImage!
    var curKeyOfProduct : String!
    var CurShop : String!
    var CurType : String!
    var ClientName : String?
    var ClientImage : String?
    var Productvalues : [String : Any]?
    
    init(curKeyOfProduct : String ){
        self.curKeyOfProduct = curKeyOfProduct

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView!
        
        var imagePicker = UIImagePickerController()

        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        
        
        
        private lazy var profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = self.curImage
            imageView.isUserInteractionEnabled = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            //imageView.backgroundColor = UIColor.white.darken(byPercentage: 0.1)
            //imageView.layer.cornerRadius = 50
           // imageView.layer.borderWidth = 1
            //imageView.layer.borderColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).cgColor
            
            
            return imageView
        }()
        
//        private lazy var ProductNameTextField: UITextField = {
//            let textField = UITextField()
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            textField.font = UIFont.systemFont(ofSize: 14)
//            textField.borderStyle = .roundedRect
//            textField.tintColor = .red
//            textField.placeholder = "Phone Number"
//            return textField
//        }()
        
//         lazy var LocationTextField: UITextField = {
//            let textField = UITextField()
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            textField.font = UIFont.systemFont(ofSize: 14)
//            textField.borderStyle = .roundedRect
//            textField.tintColor = .red
//            textField.placeholder = "Location"
//            textField.addTarget(self , action: #selector(ShowType), for: .editingDidBegin)
//            return textField
//        }()
        private lazy var DescriptionTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.borderStyle = .roundedRect
            textField.tintColor = .red
            textField.placeholder = "Description Address"
            
            return textField
        }()
        private lazy var PhoneTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.borderStyle = .roundedRect
            textField.tintColor = .red
            textField.textContentType = .telephoneNumber
            textField.placeholder = "Phone Number"
            return textField
        }()
//        private lazy var TextLabel: UILabel = {
//            let label = UILabel()
//            label.textAlignment = .center
//            label.text = " Shop Name "
//            label.font = UIFont.boldSystemFont(ofSize: 26)
//            label.textColor = .white
//            return label
//        }()
//
        private lazy var registerButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(named: "Color")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
            button.titleLabel?.textColor = .white
            button.setTitle("Add Product", for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
            return button
        }()
        // MARK: - Init
        
        override func viewDidLoad() {
            super.viewDidLoad()
            LayoutUI()
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
             activityIndicator.color = UIColor(named: "Color")!
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            navigationController?.navigationBar.isHidden = false
             navigationController?.navigationBar.prefersLargeTitles = true
          navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!] //UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
           navigationController?.navigationBar.tintColor = UIColor(named: "Color")!
            
            self.activityIndicator.stopAnimating()
            
        }
        //MARK: - Design Methods
       
        func ConfigureView(){
            navigationController?.navigationBar.barTintColor = UIColor(named: "Color")!//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
            view.backgroundColor = UIColor.white.darken(byPercentage: 0.003)
            title = "Booked"
            
           
        }
        
        func AddSubView(){
            view.addSubview(scrollView)
            scrollView.addSubview(containerView)
            containerView.addSubview(profileImageView)
            containerView.addSubview(PhoneTextField)
            containerView.addSubview(DescriptionTextField)
          //  containerView.addSubview(LocationTextField)
            //containerView.addSubview(PhoneTextField)
            containerView.addSubview(registerButton)
            
        }
        func Constraints(){
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                
                profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-30),
                profileImageView.heightAnchor.constraint(equalToConstant: 250),
                
               PhoneTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
                PhoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                PhoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
                
                DescriptionTextField.topAnchor.constraint(equalTo: PhoneTextField.bottomAnchor, constant: 8),
                DescriptionTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                DescriptionTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),


//               LocationTextField.topAnchor.constraint(equalTo: DescriptionTextField.bottomAnchor, constant: 8),
//                LocationTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
//                LocationTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

//
//               PhoneTextField.topAnchor.constraint(equalTo:  PriceTextField.bottomAnchor, constant: 8),
//                PhoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
//                PhoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
                
                registerButton.topAnchor.constraint(equalTo: DescriptionTextField.bottomAnchor, constant: 8),
                registerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3/4),
                registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                registerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
                
                
                ])
            
        }
        func LayoutUI(){
            ConfigureView()
            AddSubView()
            Constraints()
            LoadData()
        }
        
        //MARK: - Selector Methods
        
        @objc func ShowType(){
           // let ac = MapVC()
            
            
                   // self.TypeTextField.text = "CategoryOption.description"
               
            
           // self.present(ac, animated: true, completion: nil)
            
        }
    func LoadData(){
        // = ["ProductType" : CurType! ,"KeyOfProduct" :curKeyOfProduct!
       
        let ref = Database.database().reference().child("Products").child(CurType).child(curKeyOfProduct)

                  
        ref.observe(.value, with: {(snapshot) in
                       guard let productsFromType = snapshot.value as? [String:Any] else { return }
                         
                             
                  
                                              
            self.Productvalues = ["Phone" : productsFromType["Phone"]!, "ProductImage" : productsFromType["ProductImage"]!, "ProductName" : productsFromType["ProductName"]!, "ProductPrice" : productsFromType["ProductPrice"]!, "ProductType" : productsFromType["ProductType"]!,"NameShop" : productsFromType["NameShops"]! ,"Accept" : false]
                         
                       
                              
                        })
        
        guard let CurUser = Auth.auth().currentUser?.uid else{return}
                      Database.database().reference().child("Users").child(CurUser).observe(.value, with: {(snapshot) in
                                     guard let Shop = snapshot.value as?[String : Any] else { return }
                                     self.ClientName = Shop["UserName"] as? String
                                     self.ClientImage =  Shop["ProfileImage"] as? String
                        })
    }
     
    
        @objc func registerButtonTapped() {
            //|| LocationTextField.text == ""
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            
            activityIndicator.color = UIColor(named: "Color")!
            activityIndicator.hidesWhenStopped = true
             activityIndicator.startAnimating()
             view.addSubview(activityIndicator)
             activityIndicator.translatesAutoresizingMaskIntoConstraints = false
             activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
             activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.registerButton.isEnabled = false
            
            if PhoneTextField.text == ""   || DescriptionTextField.text == "" || profileImageView.image == nil{
                ShowError(message: "Must Enter All Data Above")

            }else{
                
               guard let CurUser = Auth.auth().currentUser?.uid else{return}
                
                let Uservalues : [String : Any] = ["DescriptionAddress" : DescriptionTextField.text! ,"Phone" : PhoneTextField.text! ,"ClientName": self.ClientName!,"ClientImage":self.ClientImage!]
                
                //"UserLocation" : LocationTextField.text! ,
                
                let ref = Database.database().reference().child("BookedItems")
                
                ref.child(CurUser).child("Shops").child(self.CurShop).childByAutoId().setValue(Productvalues)
                ref.child(CurUser).child("UserData").setValue(Uservalues){
                    (error,ref) in
                    if error != nil {
                        self.ShowError(message: error!.localizedDescription)
                      self.registerButton.isEnabled = true
                        self.activityIndicator.stopAnimating()
                    }else{
                       self.registerButton.isEnabled = true
                        self.activityIndicator.stopAnimating()
                        self.ShowError(message: "Booked Complete")
                        
                        
                        print("Product added")
                        self.PhoneTextField.text = ""
                        self.DescriptionTextField.text = ""
                        //self.LocationTextField.text = ""

                        self.profileImageView.image = nil
                        
                    }
                }
                
            }
           
            
        }
        
        
        // MARK: - Helper Functions
        
        func convertImageToBase64String (img: UIImage) -> String {
            return img.pngData()?.base64EncodedString() ?? ""
        }
        
        
        func convertBase64StringToImage (imageBase64String:String) -> UIImage {
            let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
            let image = UIImage(data: imageData!)
            return image!
        }
         func ShowError(message : String){
            
            let alert = UIAlertController(title: "Notify message", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                let vc = ShowUserBookedVC()
                vc.LoadData(Accept: false)
                vc.segment.selectedSegmentIndex = 1
                
               // vc.navigationItem.backBarButtonItem?.action = #selector(self.backbuttonAction)
                self.navigationController?.pushViewController(vc, animated: true)
                
                alert.dismiss(animated: true, completion: nil)
               
            }) )
            present(alert, animated: true, completion: nil)
            
        }
   
   
        
        
    }


