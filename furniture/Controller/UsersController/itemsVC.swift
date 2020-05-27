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

class itemsVC : UIViewController{

    // MARK: - Properties
    var shops = [Shops]()
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


    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @objc func handleAddCell() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")

            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false

            self.present(self.imagePicker, animated: true, completion: nil)
        }else{
            print("error to load image")
        }



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
            LoadData()
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
        ref.child("Products").observe(.childAdded, with: {(snapshot) in
            guard let shop = snapshot.value as? [String:String] else { return }
            
            
            let NewShop = Shops(Shop: Shop(NameShops: "self.shopName" , ImageShops: ""), Products: Products(Phone: shop["Phone"]!, ProductImage: shop["ProductImage"]!, ProductName: shop["ProductName"]!, ProductPrice: shop["ProductPrice"]!, ProductType: .Sofas))
            self.shops.append(NewShop)
            self.CollectionView.reloadData()
            //self.activityIndicator.stopAnimating()
            
        })
//        Database.database().reference().child("Shops").observe(.childAdded, with: {(snapshot) in
//            guard let shop = snapshot.value as? [String:String] else { return }
//            let NewShop = Shop(NameShops: shop["NameShops"]!,ImageShops: shop["ImageShop"]!)
//
//            self.shops.append(NewShop)
//            self.CollectionView.reloadData()
//
//        })
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
    func configureViewComponents() {
       // view.backgroundColor = UIColor(white: 0.5, alpha: 0.2)


        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Items"


       // navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "log-out"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCell))

        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red:0.96, green:0.69, blue:0.21, alpha:1.0)
        
        //UIColor(red:0.78, green:0.55, blue:0.16, alpha:1.0)



        navigationItem.rightBarButtonItem?.tintColor = .white
        // navigationController?.navigationBar.barTintColor = UIColor.mainBlue()


        //Set TableView

        view.addSubview(CollectionView)
        // CollectionView.translatesAutoresizingMaskIntoConstraints = false

        CollectionView.delegate = self
        CollectionView.dataSource = self

        CollectionView.backgroundColor =  UIColor.black

        CollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }

}
extension itemsVC : UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
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

        navigationController?.pushViewController(vc, animated: true)

    }



}




//MARK: - Image Picker
extension itemsVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate  {


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        picker.dismiss(animated: true, completion: nil)

        print("OK")

        let AC = UIAlertController(title: "Add ", message: "Name Your Shop", preferredStyle: .alert)
        let  imgAction = UIAlertAction(title: "", style: .default){
            (action) in

        }
         img = image

        let reImg = img.imageWithSize(CGSize(width: self.view.frame.width , height: 100))
        imgAction.setValue(reImg.withRenderingMode(.alwaysOriginal), forKey: "image")
        imgAction.isEnabled = false
        AC.addAction(imgAction)

        // AC.addImage(img: #imageLiteral(resourceName: "Screenshot (55)"))


        var txtField = UITextField()

        AC.addTextField { (TF) in
            txtField = TF
            txtField.placeholder = "Enter Your Name Shop"
        }



        AC.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let NameShop = txtField.text else {return}
            let Values = ["NameShops" : NameShop,"ImageShop":self.convertImageToBase64String(img: image)]
            Database.database().reference().child("Shops").childByAutoId().setValue(Values)
        }))

        AC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(AC, animated: true, completion: nil)

    }

}

