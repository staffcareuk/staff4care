//
//  MapsViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 09/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import GoogleMaps
import FloatingPanel
import CoreLocation

class MapsViewController: UIViewController, FloatingPanelControllerDelegate {
    
    // MARK:- IBOutlets
    
    
    
    // MARK:- Variables
    
    // Location
    var locationManager = CLLocationManager()
    var latitude   = ""
    var longitude  = ""
    
    // Maps
    let routesManager = SessionManager()
    var mapView = GMSMapView()
    var marker = GMSMarker()
    let geocoder = GMSGeocoder()
    
    
    // Bottom Panel
    let fpc = FloatingPanelController()
    
    // Back Button
    var backBtn = UIButton()
    
    // Send Coordinates Delegate
    weak var locationDelegate: SetPlaceOnMap?
    var callBack : ( ()->() )?
    




    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBottomPanel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }

    override func viewDidLoad() {
           super.viewDidLoad()
           setLocationProperties()
           //other()
   
     }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let controllers = self.navigationController?.viewControllers {
            if let createJob = controllers.last as? CreateJob {
                print("Got :: " , createJob)
                createJob.locationFromMap = self.marker.position
                createJob.fromMap = true                
            }
                   }
        if self.isMovingFromParent {
           // delegate?.passValue(clickedImage: selectedImage)
        }
    }
    // MARK:- IBAction Methods
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK:- Methods
    private func setLocationProperties() {
             self.locationManager.delegate = self
             self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
             self.locationManager.requestWhenInUseAuthorization()
             self.locationManager.startUpdatingLocation()
             
         }
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
           return MyFloatingPanelLayout()
       }
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    private func setMap(latitude: CLLocationDegrees , longitude: CLLocationDegrees){
        
      
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
//        self.view.addSubview(backBtn)
//        self.backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
//        self.backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //marker.icon = UIImage(named: "hospital-icon")
        marker.isDraggable = true
        mapView.delegate = self
        marker.map = mapView
        
    }
    
    private func setRoute(startLat: CLLocationDegrees , startLon: CLLocationDegrees,
                          endLat: CLLocationDegrees ,   endLon: CLLocationDegrees){
//        let start = CLLocationCoordinate2D(latitude: startLat, longitude: startLon)
//           let end = CLLocationCoordinate2D(latitude: endLat, longitude: endLon)

//           routesManager.requestDirections(from: start, to: end, completionHandler: { (path, error) in
//
//               if let error = error {
//                   print("Something went wrong, abort drawing!\nError: \(error)")
//               } else {
//                   // Create a GMSPolyline object from the GMSPath
//                   let polyline = GMSPolyline(path: path!)
//                   polyline.strokeColor =  UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1)
//                   polyline.strokeWidth = 2.0
//
//                   // Add the GMSPolyline object to the mapView
//                   polyline.map = self.mapView
//
//                   // Move the camera to the polyline
//                   let bounds = GMSCoordinateBounds(path: path!)
//                   let cameraUpdate = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 40, left: 15, bottom: 10, right: 15))
//                   self.mapView.animate(with: cameraUpdate)
//               }
//
//           })
    }
    private func setBottomPanel(){
        fpc.delegate = self
        let sstoryboard = UIStoryboard(name: "Maps", bundle: nil)
        guard let contentVC = sstoryboard.instantiateViewController(identifier: "fpc_content") as? MapsContentViewController else { return }
        contentVC.locationDelegate = self
        fpc.set(contentViewController: contentVC)
        
        fpc.addPanel(toParent: self)
        
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        if let lat = location?.coordinate.latitude , let lang = location?.coordinate.longitude {
             self.latitude  = String(lat)
             self.longitude = String(lang)
            self.setMap(latitude: lat, longitude: lang)
          //  self.setRoute(startLat: lat, startLon: lang, endLat: 37.706753, endLon: -122.418677)
             

        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
}
extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("Dragg Ended")
        print("End Position" , marker.position)
        
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            if let location = response?.firstResult() {
        //        marker.map = nil
                self.marker = GMSMarker(position: marker.position)
                let lines = location.lines! as [String]

                marker.userData = lines.joined(separator: "\n")
                marker.title = lines.joined(separator: "\n")
                marker.infoWindowAnchor = CGPoint(x: 0.5, y: -0.25)
                marker.accessibilityLabel = "current"
                marker.map = self.mapView

                self.mapView.animate(toLocation: marker.position)
                self.mapView.selectedMarker = marker
            }
        }
        
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("Dragg Started")
        print("Start Position" , marker.position)
    }
   
    
}
extension MapsViewController: SetPlaceOnMap {
    func cancelTapped() {
        fpc.move(to: .half, animated: true)
    }
    
    func editingBegin() {
        fpc.move(to: .full, animated: true)
    }
    
    func getLocationfromPlace(latitude: Double, longitude: Double) {
        print("Coordinates" , latitude , "  " , longitude)
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = self.mapView

        self.mapView.animate(toLocation: marker.position)
        self.mapView.selectedMarker = marker
        
    }
    
    
}
class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 16.0 // A top inset from safe area
            case .half: return 216.0 // A bottom inset from the safe area
            case .tip: return 44.0 // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}

