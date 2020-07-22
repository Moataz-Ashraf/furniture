//
//  AddNewItemsVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth


class AddNewItemsVC: UIViewController {
    //MARK : - Properties
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
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        return tapGesture
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white.darken(byPercentage: 0.05)
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.darken(byPercentage: 0.2).cgColor//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0).cgColor
        
        
        return imageView
    }()
    
    private lazy var ProductNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.tintColor = .red
        textField.placeholder = "Product Name"
        return textField
    }()
    
    private lazy var TypeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.tintColor = .red
        textField.placeholder = "Product Type"
        textField.addTarget(self , action: #selector(ShowType), for: .editingDidBegin)
        return textField
    }()
    private lazy var PriceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.tintColor = .red
        textField.placeholder = "Price"
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
    private lazy var TextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = " Shop Name "
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Color")//UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        button.titleLabel?.textColor = .white
        button.setTitle("Add Product", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(AddProductButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Init
    private var shopName : String!
    
    
    init(shopName : String ){
        self.shopName = shopName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
       navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!]
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color")
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")
        view.backgroundColor = UIColor.white.darken(byPercentage: 0.003)
               title = "New Product"
        activityIndicator.stopAnimating()
        
       
        
    }
    //MARK: - Design Methods
   
    func ConfigureView(){
        //UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
       
        
       
    }
    
    func AddSubView(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(ProductNameTextField)
        containerView.addSubview(TypeTextField)
        containerView.addSubview(PriceTextField)
        containerView.addSubview(PhoneTextField)
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
            
            ProductNameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            ProductNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            ProductNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            TypeTextField.topAnchor.constraint(equalTo: ProductNameTextField.bottomAnchor, constant: 8),
            TypeTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            TypeTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

            
           PriceTextField.topAnchor.constraint(equalTo: TypeTextField.bottomAnchor, constant: 8),
            PriceTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            PriceTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            
           PhoneTextField.topAnchor.constraint(equalTo:  PriceTextField.bottomAnchor, constant: 8),
            PhoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            PhoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            registerButton.topAnchor.constraint(equalTo: PhoneTextField.bottomAnchor, constant: 8),
            registerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3/4),
            registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            
            
            ])
        
    }
    func LayoutUI(){
        ConfigureView()
        AddSubView()
        Constraints()
    }
    
    //MARK: - Selector Methods
    
    @objc func ShowType(){
        let ac = UIAlertController(title: "Select Type", message: nil, preferredStyle: .actionSheet)
        
        for CategoryOption in CategoryOption.allCases {
            
            ac.addAction(UIAlertAction(title: CategoryOption.description , style: .default){
                (action) in
                self.TypeTextField.text = CategoryOption.description
            })
        }
        TypeTextField.isEnabled = false
        present(ac, animated: true, completion: nil)
        
    }
    
    @objc func AddProductButtonTapped() {
        if PhoneTextField.text == "" || ProductNameTextField.text == "" || TypeTextField.text == "" || PriceTextField.text == "" || profileImageView.image == nil{
            ShowError(message: "Must Enter All Data about Your Product")

        }else{
            guard let CurUser = Auth.auth().currentUser?.uid else{return}
            
            let values : [String : Any] = ["ProductName" : ProductNameTextField.text! , "ProductType" : TypeTextField.text! ,"ProductPrice" : PriceTextField.text! ,"Phone" : PhoneTextField.text! ,"ProductImage":convertImageToBase64String(img: profileImageView.image!)]
            let valuesOfProducts : [String : Any] = ["ProductName" : ProductNameTextField.text! , "ProductType" : TypeTextField.text! ,"ProductPrice" : PriceTextField.text! ,"Phone" : PhoneTextField.text! ,"ProductImage":convertImageToBase64String(img: profileImageView.image!),"NameShops":shopName!]
            
            let ref = Database.database().reference().child("Shops")
            ref.child(CurUser).child("Products").childByAutoId().setValue(values){
                (error,ref) in
                if error != nil {
                    self.ShowError(message: error!.localizedDescription)
                }else{
                     
                    print("Product added")
                    self.PhoneTextField.text = ""
                    self.ProductNameTextField.text = ""
                    self.TypeTextField.text = ""
                    self.PriceTextField.text = ""
                    self.profileImageView.image = nil
                    self.navigationController?.popViewController(animated: true)
                    //self.navigationController?.pushViewController(ItemsVC(), animated: true)
                }
            }
            let refProduct = Database.database().reference().child("Products")
            refProduct.child(TypeTextField.text!).childByAutoId().setValue(valuesOfProducts)
            
        }
        
        
    }
    
    @objc func imageViewTapped() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
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
        
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }) )
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
extension AddNewItemsVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        profileImageView.image = image
        picker.dismiss(animated: true, completion: nil)

    }
}
