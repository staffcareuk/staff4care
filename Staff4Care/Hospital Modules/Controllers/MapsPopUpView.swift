//
//  MapsPopUpView.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 08/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import CoreLocation
class MapsPopUpView: UIViewController , UIGestureRecognizerDelegate{
    
    // MARK:- IBOutlets
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var goToMapsBtn: UIButton!
    @IBOutlet weak var useCurrentLocationBtn: UIButton!
    
    
    
    // MARK:- Variables
    var useCurrentLocation : (() -> ())?
   
    
    // MARK:- LifeCycle Methods
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
//           containerView.layer.borderWidth = 1.0
//           containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = .secondarySystemBackground
       }
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = UIColor(white: 1, alpha: 0.8)

        showAnimate()
        addPropertiesAndStyling()
        
       }
    // MARK:- Methods
    private func addPropertiesAndStyling(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
               view.addGestureRecognizer(tapGesture)
               tapGesture.delegate = self
               
                 // yesBtn.setup(applyGradient: true,title: "Yes",rgb1: (154,154,198),rgb2: (39,65,143))
                 // noBtn.setup(applyGradient: true,title: "No",rgb1: (192,221,184),rgb2: (174,200,55))
               useCurrentLocationBtn.layer.borderWidth = 2.0
               useCurrentLocationBtn.layer.borderColor = UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1).cgColor
               goToMapsBtn.backgroundColor = UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1)
              // goToMapsBtn.applyGradient(colors: [UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1).cgColor,UIColor(red: 154/255, green: 154/255, blue: 98/255, alpha: 1).cgColor])
               goToMapsBtn.setTitleColor(.white, for: .normal)
               goToMapsBtn.tintColor = .white
               useCurrentLocationBtn.setTitleColor(UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1), for: .normal)
               useCurrentLocationBtn.tintColor = UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1)
               mapImage.tintColor = UIColor(red: 39/255, green: 65/255, blue: 143/255, alpha: 1)
               
        
    }
   
       func updateHeight(height: CGFloat) {
           self.containerViewHeight.constant = height
       }
    @objc func dismissVC (recognizer: UITapGestureRecognizer) {
        removeAnimate()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let p = touch.location(in: self.view)
        if self.containerView.frame.contains(p) {
          return false
        }
        return true
    }
       func showAnimate()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       func removeAnimate()
       {
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0
           }, completion: {(finished : Bool) in
               if(finished)
               {
                   self.willMove(toParent: nil)
                   self.view.removeFromSuperview()
                   self.removeFromParent()
               }
           })
       }
    
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        removeAnimate()
        useCurrentLocation?()


    }
    @IBAction func mapsBtnPressed(_ sender: Any) {
        removeAnimate()
        pushMapsVC()
        
       
    }
    // MARK:- Navigation Methods
    func pushMapsVC() {
                  let storyboard = UIStoryboard(name: "Maps", bundle: nil)
                                guard let map = storyboard.instantiateViewController(identifier: "MapsViewController") as? MapsViewController else {
                                       print("ViewController not found")
                                       return
                                   }
        map.locationDelegate = self
               self.navigationController?.pushViewController(map, animated: true)
              }
           
}
extension MapsPopUpView: SetPlaceOnMap {
    func getLocationfromPlace(latitude: Double, longitude: Double) {
        print("Latitude " , latitude , " " , "Longitude " , longitude)
    }
    
    func cancelTapped() {
        // Do Nothing Here
    }
    
    func editingBegin() {
        // Do Nothing Here
    }
    
    
}
