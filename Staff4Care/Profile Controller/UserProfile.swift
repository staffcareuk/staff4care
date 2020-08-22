//
//  UserProfile.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 29/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var profileCV: UICollectionView!
    var images = ["profile-menu","findjob-menu","calendar-menu","availability-menu","payments-menu","history-menu","holidays-menu","messages-menu"]
    var titles = ["Profile","Find a Job","Calendar","Availability","Payments","History","Holidays","Messages"]
    
    
    
    
    // MARK:- Variables
    
    var storyboardName: StoryboardName?
    var vcName = ""
    
    // MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        profileCV.delegate = self
        profileCV.dataSource = self
        print(self.navigationController?.viewControllers)

    }
  
}
extension UserProfile : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilecell", for: indexPath) as? ProfileCollectionViewCell {
            cell.parentView.applyStylingProperties(foregoundColor: UIColor.white, shadowColor: 0x707070)
           
            cell.menuImage.image = UIImage(named: images[indexPath.row])
            cell.menuLbl.text = titles[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileCollectionViewCell {
            if let menu = cell.menuLbl.text {
            pushModule(identifier: menu)
            }
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135.0, height: 135.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if #available(iOS 13, *) {
            (scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]).backgroundColor = UIColor(rgb: 0x27418F) //verticalIndicator
            (scrollView.subviews[(scrollView.subviews.count - 2)].subviews[0]).backgroundColor = UIColor(rgb: 0x27418F) //horizontalIndicator
        } else {
            if let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as? UIImageView) {
                verticalIndicator.backgroundColor = UIColor(rgb: 0x27418F)
            }
            
            if let horizontalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 2)] as? UIImageView) {
                horizontalIndicator.backgroundColor = UIColor(rgb: 0x27418F)
            }
        }
    }
    
    
}
// Navigation
extension UserProfile {
    func pushModule(identifier: String) {
        if identifier == "Profile" {
            let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                guard let loginVC = storyboard.instantiateViewController(identifier: "ProfileView") as? ProfileView else {
                                       print("ViewController not found")
                                       return
                                   }
               self.navigationController?.pushViewController(loginVC, animated: true)
        } else if identifier == "Find a Job" {
            if loggedUser?.role == "1" {
                let storyboard = UIStoryboard(name: "SearchJob", bundle: nil)
                guard let loginVC = storyboard.instantiateViewController(identifier: "SearchJob") as? SearchJob else {
                    print("ViewController not found")
                    return
                }
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            else if loggedUser?.role == "2" {
                let storyboard = UIStoryboard(name: "StaffSearch", bundle: nil)
                guard let loginVC = storyboard.instantiateViewController(identifier: "HospitalStaffSearch") as? HospitalStaffSearch else {
                    print("ViewController not found")
                    return
                }
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            
        }
        else if identifier == "Calendar" {
            let storyboard = UIStoryboard(name: "JobCalendar", bundle: nil)
                             guard let loginVC = storyboard.instantiateViewController(identifier: "JobCalendar") as? JobCalendar else {
                                    print("ViewController not found")
                                    return
                                }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        else if identifier == "Availability" {
            let storyboard = UIStoryboard(name: "Availability", bundle: nil)
                             guard let loginVC = storyboard.instantiateViewController(identifier: "Availability") as? Availability else {
                                    print("ViewController not found")
                                    return
                                }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }else if identifier == "Payments" {
            let storyboard = UIStoryboard(name: "Payments", bundle: nil)
                             guard let loginVC = storyboard.instantiateViewController(identifier: "Payments") as? Payments else {
                                    print("ViewController not found")
                                    return
                                }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        else if identifier == "History" {
            let storyboard = UIStoryboard(name: "TravelHistory", bundle: nil)
                             guard let loginVC = storyboard.instantiateViewController(identifier: "TravelHistory") as? TravelHistory else {
                                    print("ViewController not found")
                                    return
                                }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        else if identifier == "Holidays" {
            let storyboard = UIStoryboard(name: "TravelHistory", bundle: nil)
                             guard let loginVC = storyboard.instantiateViewController(identifier: "Holidays") as? Holidays else {
                                    print("ViewController not found")
                                    return
                                }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
      
        
        
        
        
        
        
        
        
        
        
        
        
   
      }
   
}
