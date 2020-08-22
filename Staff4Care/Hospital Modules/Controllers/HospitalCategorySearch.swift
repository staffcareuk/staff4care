//
//  HospitalCategorySearch.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 21/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class HospitalCategorySearch: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var notificatioBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clientCollectionView: UICollectionView!
    @IBOutlet weak var allJobsCollectionView: UICollectionView!
    
    // MARK:- Variables
    var viewModel = SearchJobViewModel()
    var parentCategoryId: String = ""
    var url = "https://api.bluenee.co.uk/cig/index.php/api/categories/list/"


       // MARK:- LifeCycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true        
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
        viewModel.searchJobDelegate = self
        url += parentCategoryId
        viewModel.getSubCategoriesList(url: url)
        //viewModel.getAvailableJobs()
        
       }
    // MARK:- IBActions
    @IBAction func menuBtnTapped(_ sender: Any) {
    }
    @IBAction func notificatioBtnTapped(_ sender: Any) {
    }
    
    // MARK:- Navigation Methods
    private func pushCreateJobVC() {
           let storyboard = UIStoryboard(name: "CreateJobs", bundle: nil)
           guard let createJobVC = storyboard.instantiateViewController(identifier: "CreateJob") as? CreateJob else {
               print("ViewController not found")
               return
           }
           self.navigationController?.pushViewController(createJobVC, animated: true)
       }


}
extension HospitalCategorySearch: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clientCollectionView {
            return viewModel.subcategoriesModel?.categoriesList?.count ?? 0
         }
        else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clientCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "client", for: indexPath) as? ClientCollectionViewCell {
                if let subcategory = viewModel.subcategoriesModel?.categoriesList?[indexPath.row] {
                    cell.configureCell(category: subcategory)
                }
                return cell
            }
        }
        else if collectionView == allJobsCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyclient", for: indexPath) as? JobCell {
                if let job = viewModel.allJobs?.jobsList?[indexPath.row] {
                    cell.configureCell(job: job)
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Code
        self.pushCreateJobVC()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clientCollectionView {
             return CGSize(width: UIScreen.main.bounds.width / 2 - 40, height: 100)
         }
        else {
            return CGSize(width: 169, height: 160)

        }
    }
    
    
    
}
extension HospitalCategorySearch: SearchJobProtocol {
    func gotNearbyStaff() {
        //
    }
    
    func failedNearbyStaff() {
        //
    }
    
    func locationUpdated() {
        //
        
    }
    
    func locationUpdateFailed() {
        //
    }
    
    func getJobsSuccess() {
        DispatchQueue.main.async {
            self.allJobsCollectionView.reloadData()
        }
    }
    
    func getJobsFailed() {
        //
    }
    
   
    
    func getSubCategoriesSuccess() {
        DispatchQueue.main.async {
            self.clientCollectionView.reloadData()
        }
    }
    
    func getSubCategoriesFailed() {
        //
    }
    
    func getCategoiresSuccess() {
        //
    }
    
    func getCategoriesFailed() {
        // 
    }
    
    
}
