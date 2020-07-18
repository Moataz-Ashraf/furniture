//
//  MapVC.swift
//  MyInstagram
//
//  Created by Moataz on 4/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth


class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate  {
    
            //MARK:- Variable Declarations

            var mMapView : MKMapView = {
            
                    let mv = MKMapView()
            
                    return mv
    }()
            var locationManager:CLLocationManager!
    var currentLocationStr = "Current Location"

            //MARK:- ViewController LifeCycle Methods

            override func viewDidLoad() {
                super.viewDidLoad()
                configration()
            }
    override func viewWillAppear(_ animated: Bool) {
        let backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action:#selector(popToRoot) )
        navigationItem.backBarButtonItem = backBarButtonItem
    }
            override func viewDidAppear(_ animated: Bool) {
                determineCurrentLocation()
            }
    @objc func popToRoot(){
        navigationController?.popViewController(animated: true)
    }
         
        //MARK:- Intance Methods

        func determineCurrentLocation() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        mMapView.setRegion(mRegion, animated: true)

        // Get user's Current Location and Drop a pin
    let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        self.currentLocationStr = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.currentLocationStr
        mMapView.addAnnotation(mkAnnotation)
    }
    //MARK:- Intance Methods

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let mPlacemark = placemarks{
                if mPlacemark.count > 0 {
                    let placemark = mPlacemark[0]

                    let address = "\(placemark.subThoroughfare ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.country ?? "")"//"\(placemark.subThoroughfare ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.subLocality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                    print("\(address)")
                     self.currentLocationStr = "\(placemark.subThoroughfare ?? "")"
                    }
                }
            }
        
        return currentLocationStr
        
    }
    
    
    func configration(){
    
    
    
    
            view.addSubview(mMapView)
        mMapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
    
    
        }
}
//    // MARK: - UI Design
//    var searchButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "icons8-location-100-4").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(searchButtonAction(_:)) , for: .touchUpInside)
//        return button
//
//    }()
//    var DoneButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "ic_person_outline_white_2x").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(DoneButtonAction) , for: .touchUpInside)
//        return button
//
//    }()
//
//    var mapView : MKMapView = {
//
//        let mv = MKMapView()
//
//        return mv
//
//    }()
//    // MARK: - Search
//
//    fileprivate var searchController: UISearchController!
//    fileprivate var localSearchRequest: MKLocalSearch.Request!
//    fileprivate var localSearch: MKLocalSearch!
//    fileprivate var localSearchResponse: MKLocalSearch.Response!
//
//    // MARK: - Map variables
//
//    fileprivate var annotation: MKAnnotation!
//    fileprivate var locationManager: CLLocationManager!
//    fileprivate var isCurrentLocation: Bool = false
//
//
//    fileprivate var activityIndicator: UIActivityIndicatorView!
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        configration()
//
//        if (CLLocationManager.locationServicesEnabled()) {
//            if locationManager == nil {
//                locationManager = CLLocationManager()
//
//            }
//            locationManager?.requestWhenInUseAuthorization()
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestAlwaysAuthorization()
//            locationManager.startUpdatingLocation()
//            isCurrentLocation = true
//
//        }
//        mapView.delegate = self
//        mapView.mapType = .hybrid
//
//        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
//        activityIndicator.hidesWhenStopped = true
//        self.view.addSubview(activityIndicator)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        activityIndicator.center = self.view.center
//    }
//
//
//
//
//
//    // MARK: - Search
//
//    @objc func searchButtonAction(_ button: UIButton) {
//        if searchController == nil {
//            searchController = UISearchController(searchResultsController: nil)
//        }
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.searchBar.delegate = self
//        present(searchController, animated: true, completion: nil)
//    }
//    @objc func  DoneButtonAction(){
//        let ref = Database.database().reference().child("Gyms").child(Auth.auth().currentUser!.uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if snapshot.hasChild("Location"){
//
//                self.dismiss(animated: true, completion: nil)
//            }else{
//
//                self.ShowError(message: "Must Add Location of Gym")
//            }
//
//
//        })
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .denied {
//
//        }else{
//            self.locationManager.startUpdatingLocation()
//        }
//    }
//
//      //MARK: - ( Method Did Update Location ) What happen when location change
//
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
////    {
////        let region = MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
////        self. = locations.last!.coordinate
////        self.mapView.region = region
////
////    }
//    // MARK: - UISearchBarDelegate
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
//
//        if self.mapView.annotations.count != 0 {
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
//
//        localSearchRequest = MKLocalSearch.Request()
//        localSearchRequest.naturalLanguageQuery = searchBar.text
//        localSearch = MKLocalSearch(request: localSearchRequest)
//        localSearch.start { [weak self] (localSearchResponse, error) -> Void in
//
//            if localSearchResponse == nil {
//                let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
//                alert.show()
//                return
//            }
//
//            let pointAnnotation = MKPointAnnotation()
//            pointAnnotation.title = searchBar.text
//            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
//
//            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
//            self!.mapView.centerCoordinate = pointAnnotation.coordinate
//            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
//        }
//    }
//
//    // MARK: - CLLocationManagerDelegate
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if !isCurrentLocation {
//            return
//        }
//
//        isCurrentLocation = false
//
//        let location = locations.last
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//        self.mapView.setRegion(region, animated: true)
//
//        if self.mapView.annotations.count != 0 {
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
//        let database =  Database.database().reference().child("Gyms").child(Auth.auth().currentUser!.uid)
//        let pointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = location!.coordinate
//        pointAnnotation.title = "Your Location"
//
//        let Values  = ["longitude": pointAnnotation.coordinate.longitude,"latitude":pointAnnotation.coordinate.latitude]
//        database.child("Location").setValue(Values)
//
//        mapView.addAnnotation(pointAnnotation)
//    }
//
//
//    func ShowError(message : String){
//
//        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            alert.dismiss(animated: true, completion: nil)
//        }) )
//        present(alert, animated: true, completion: nil)
//
//    }
//
//    func configration(){
//
//
//
//
//        view.addSubview(mapView)
//        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        view.addSubview(DoneButton)
//
//        DoneButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 60, height: 60)
//
//        view.addSubview(searchButton)
//        searchButton.anchor(top: nil, left: nil, bottom: DoneButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 15, width: 60, height: 60)
//
//
//    }
//
//
    
//}
