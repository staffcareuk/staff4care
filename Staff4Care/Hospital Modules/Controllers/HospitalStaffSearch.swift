//
//  HospitalStaffSearch.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 21/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class HospitalStaffSearch: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clientCollectionView: UICollectionView!
    @IBOutlet weak var nearbyStaffCollectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    
    // MARK:- Variables
    var viewModel = SearchJobViewModel()
    var urlString = "https://api.bluenee.co.uk/cig/index.php/api/categories/list"
    var jobsUrl   = "https://api.bluenee.co.uk/cig/index.php/api/jobs/list/"
    
    
    // MARK:- LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.setImage(UIImage(named: "search-icon"), for: .search, state: .normal)
        clientCollectionView.delegate = self
        clientCollectionView.dataSource = self
        nearbyStaffCollectionView.delegate = self
        nearbyStaffCollectionView.dataSource = self
        if let layout = nearbyStaffCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            nearbyStaffCollectionView.showsHorizontalScrollIndicator = false
        }
        viewModel.searchJobDelegate = self
        viewModel.getCategoriesList(url: urlString)
        viewModel.getNearbyStaff()
    }
    
    
    // MARK:- IBAction Methods
    @IBAction func menuBtnTapped(_ sender: Any) {
        
    }
    @IBAction func notificationBtnTapped(_ sender: Any) {
        
    }
    
    // MARK:- NavigationMethods
    private func pushSubCateogryVC(categoryId: String) {
        let storyboard = UIStoryboard(name: "StaffSearch", bundle: nil)
        guard let subcategoryVC = storyboard.instantiateViewController(identifier: "HospitalCategorySearch") as? HospitalCategorySearch else {
            print("ViewController not found")
            return
        }
        subcategoryVC.parentCategoryId = categoryId
        self.navigationController?.pushViewController(subcategoryVC, animated: true)
    }
    
    
    

}
extension HospitalStaffSearch: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clientCollectionView {
            return viewModel.categoriesModel?.categoriesList?.count ?? 0
                }
        else {
            return 6
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
        else if collectionView == nearbyStaffCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyclient", for: indexPath) as? JobCell {
                if let staff = viewModel.nearbyStaff?.staffList?[indexPath.row] {
                    cell.configureCellforStaff(staff: staff)
                                             }
                return cell
            }
            
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let categoryId = viewModel.categoriesModel?.categoriesList?[indexPath.row].categoryID {
            self.pushSubCateogryVC(categoryId: categoryId)
        }
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
extension HospitalStaffSearch: SearchJobProtocol {
    func gotNearbyStaff() {
        DispatchQueue.main.async {
            self.nearbyStaffCollectionView.reloadData()
        }
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
        //
    }
    
    func getJobsFailed() {
        //
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
