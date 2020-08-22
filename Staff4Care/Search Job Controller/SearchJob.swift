//
//  SearchJob.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 26/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
class SearchJob: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clientCollectionView: UICollectionView!
    @IBOutlet weak var allJobsCollectionView: UICollectionView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK:- Variables
    
    var viewModel = SearchJobViewModel()
    var urlString = "https://api.bluenee.co.uk/cig/index.php/api/categories/list"
    
        // Location
    var locationManager = CLLocationManager()
    var latitude   = ""
    var longitude  = ""
    var marker = GMSMarker()
    var geocoder = GMSGeocoder()
    var address = [String]()
    
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    var blurViewRemovedFromSuperView = false
    
    // MARK:- LifeCycle Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //addBlurView()
        addBottomSheetView()
        bottomSheetVC.dimissBtnCallBack = {
            self.removeBottomSheetandBlurView()
            self.allJobsCollectionView.isHidden = false
            self.clientCollectionView.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.allJobsCollectionView.alpha = 1
                self?.clientCollectionView.alpha = 1
                self?.view.layoutIfNeeded()
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.setImage(UIImage(named: "search-icon"), for: .search, state: .normal)
        allJobsCollectionView.delegate = self
        allJobsCollectionView.dataSource = self
        if let layout = allJobsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            allJobsCollectionView.showsHorizontalScrollIndicator = false
        }
        
        setLocationProperties()
        
        viewModel.searchJobDelegate = self
        viewModel.getCategoriesList(url: urlString)
        
    }
    // MARK:- Methods
    
     private func setMap(latitude: CLLocationDegrees , longitude: CLLocationDegrees){
            
          
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
           // mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            //self.view.addSubview(mapView)
        mapView.camera = camera
            // Creates a marker in the center of the map.
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.isDraggable = true
            mapView.delegate = self
            marker.map = mapView
            
        }
    private func setLocationProperties() {
          self.locationManager.delegate = self
          self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
          self.locationManager.requestWhenInUseAuthorization()
          self.locationManager.startUpdatingLocation()
          
      }
    let bottomSheetVC = BottomSheetViewController()
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        

        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    func removeBottomSheetandBlurView() {
        
//        UIView.animate(withDuration: 0.2) {
//                   self.blurEffectView.alpha = 0
//               }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            //self?.blurEffectView.isHidden = true
            self?.bottomSheetVC.hideView()
        }
      

    }
    func showBottomSheetVC() {
        blurEffectView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView.isHidden = false
            self.bottomSheetVC.changeHeight()
            self.blurEffectView.alpha = 0.9
        }
    }
   
    // MARK:- IBAction Methods
    
    @IBAction func menuButtonTapped(_ sender: Any) {
      
    }
    @objc func blurviewTapped() {
          removeBottomSheetandBlurView()

    }
    
    
    func addBlurView() {

        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurviewTapped)))
        blurEffectView.isHidden = true
        
    }
    @IBAction func notificationButtonTapped(_ sender: Any) {
    }
    
    // MARK:- Navigation Methods
    
    func pushViewJobsVC() {
        let storyboard = UIStoryboard(name: "SearchJob", bundle: nil)
        guard let viewJobsVC = storyboard.instantiateViewController(identifier: "ViewJobs") as? ViewJobs else {
            print("ViewController not found")
            return
        }
        self.navigationController?.pushViewController(viewJobsVC, animated: true)
    }
    
    
    
    

}
extension SearchJob: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clientCollectionView {
            return viewModel.categoriesModel?.categoriesList?.count ?? 0
         }
        else {
            return viewModel.nearestJobs?.jobsList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clientCollectionView {
              if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "client", for: indexPath) as? ClientCollectionViewCell {
              
                if let category = viewModel.categoriesModel?.categoriesList?[indexPath.row] {
                    cell.configureCell(category: category)
                }
                return cell
                     }
            
        }
        else if collectionView == allJobsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyclient", for: indexPath) as? JobCell {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyclient", for: indexPath) as? JobCell {
                               if let job = viewModel.nearestJobs?.jobsList?[indexPath.row] {
                                   cell.configureCell(job: job)
                               }
                               return cell
                           }
                
                return cell
            }
            
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allJobsCollectionView {
            if let job = viewModel.nearestJobs?.jobsList?[indexPath.row] {
             
                if let lat = job.latitude , let long = job.longitude {
                    let latitude   = NSString(string: lat)
                    let longitude  = NSString(string: long)
                    let latitudeD  = latitude.doubleValue
                    let longitudeD = longitude.doubleValue
                    let camera = GMSCameraPosition.camera(withLatitude: latitudeD, longitude: longitudeD, zoom: 16)
//                    mapView?.camera = camera
                    marker.position = CLLocationCoordinate2D(latitude: latitudeD, longitude: longitudeD)
                                     marker.map = mapView
                    mapView?.animate(to: camera)
                    geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
                        if let location = response?.firstResult() {
                            
                            if let lines = location.lines {
                                print("lines :: " , lines)
                                self.bottomSheetVC.address = lines
                                self.address = lines
                                self.bottomSheetVC.addressLabel.text = lines[0]
                            }
                        }
                    }
                }
                bottomSheetVC.jobSelectedFromPreviousController(job: job)
                self.bottomSheetVC.address = self.address
                             self.allJobsCollectionView.isHidden = true
                             self.clientCollectionView.isHidden = true
                             UIView.animate(withDuration: 0.5) { [weak self] in
                                 self?.clientCollectionView.alpha = 0
                                 self?.allJobsCollectionView.alpha = 0
                                 self?.view.layoutIfNeeded()
                             }
                showBottomSheetVC()

              
               
              //  bottomSheetVC.updateViewConstraints()
            }
            print("Tapped")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clientCollectionView {
             return CGSize(width: UIScreen.main.bounds.width / 2 - 40, height: 100)
         }
        else {
            return CGSize(width: UIScreen.main.bounds.width / 2 , height: 180)

        }
    }
    
    
    
}

extension SearchJob : SearchJobProtocol {
    func gotNearbyStaff() {
        //
    }
    
    func failedNearbyStaff() {
        //
    }
    
    func locationUpdated() {
        
    }
    
    func locationUpdateFailed() {
        print("Location Update Failed")
    }
    
    func getJobsSuccess() {
        DispatchQueue.main.async {
            self.allJobsCollectionView.reloadData()
        }
    }
    
    func getJobsFailed() {
        // Do Something
    }
    
  
    
    func getSubCategoriesSuccess() {
        //
    }
    
    func getSubCategoriesFailed() {
        //
    }
    
    func getCategoiresSuccess() {
        DispatchQueue.main.async {
            self.clientCollectionView.reloadData()
        }
    }
    func getCategoriesFailed() {
        
    }
    
    
}
extension SearchJob: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        if let lat = location?.coordinate.latitude , let lang = location?.coordinate.longitude {
             self.latitude  = String(lat)
             self.longitude = String(lang)
            self.setMap(latitude: lat, longitude: lang)
            viewModel.getNearestJobs(latitude: self.latitude, longitude: self.longitude)

        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
}
extension SearchJob: GMSMapViewDelegate {
    
}
