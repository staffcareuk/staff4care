//
//  CreateJob.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 21/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import SearchTextField
import CoreLocation
import IQKeyboardManagerSwift
import GoogleMaps
class CreateJob: BaseViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var clientNameTxtField: CustomTextField!
    @IBOutlet weak var clientCategoryTxtField: CustomTextField!
    @IBOutlet weak var clientSubCategoryTxtField: CustomTextField!
    @IBOutlet weak var dateTextField: CustomTextField!
    @IBOutlet weak var paymentTypeTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentTypeTableView: UITableView!
    @IBOutlet weak var paymentTypeTextField: CustomTextField!
    @IBOutlet weak var postJobButton: CustomButton!
    @IBOutlet weak var fromTime: CustomTextField!
    @IBOutlet weak var toTime: CustomTextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var categoryFieldStackView: UIStackView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var amountField: CustomTextField!
    
    @IBOutlet weak var paymentTypeStackView: UIStackView!
    @IBOutlet weak var cubcategoryTableViewHeght: NSLayoutConstraint!
    @IBOutlet weak var subCategoryStackvIEW: UIStackView!
    @IBOutlet weak var clientSubCategoryTableView: UITableView!
    @IBOutlet weak var locationTextField: CustomTextField!
    
    @IBOutlet weak var titleLblTop: NSLayoutConstraint!
    // MARK:- Variables
    
    var listShow = false
    var actualHeight:CGFloat = 0.0
    var urlString = "https://api.bluenee.co.uk/cig/index.php/api/categories/list/"
    var parentCategoryID = "1"
    var childCategoryID  = "1"
    
    var viewModel = CreateFindJobsViewModel()
    
    // Location
    
    var locationManager = CLLocationManager()
    var latitude   = ""
    var longitude  = ""
    var locationFromMap = CLLocationCoordinate2D()
    var fromMap = false
    
    // Picker
    
    var datePicker     = UIDatePicker()
    var toTimePicker   = UIDatePicker()
    var fromTimePicker = UIDatePicker()
    
    // Bool
    var showPaymentTV = false
    
    
    // Geocoder
    let goocoder = GMSGeocoder()
   
    
  
    
    // MARK:- LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        titleLblTop.constant += 14
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTableView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureTableView()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
        viewModel.delegate = self
        viewModel.getCategoriesList(url: urlString)
        viewModel.getSubCategoriesList(url: urlString + parentCategoryID)
        viewModel.getPaymentTypes()
        setLocationProperties()
     
       
       // viewSlideInFromTopToBottom(view: categoryTableView)

    }
    // MARK:- Overriden Methods
    override func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Methods
    private func fadeAnimateView() {

        if showPaymentTV == false {
            self.paymentTypeTableView.alpha = 0.0
            self.paymentTypeTableView.isHidden = false
            self.showPaymentTV = true
            self.paymentTypeTableViewHeight.constant = 0

            UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
                            self?.paymentTypeTableView.alpha = 1.0
                            self?.paymentTypeTableViewHeight.constant = 300
                            
                           
            })
        } else {
            UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
                            self?.paymentTypeTableView.alpha = 0.0
                            self?.paymentTypeTableViewHeight.constant = 0
                          
            }) { [weak self] _ in
                self?.paymentTypeTableView.isHidden = true
                self?.showPaymentTV = false
            }
        }
    }
    
    private func setLocationProperties() {
             self.locationManager.delegate = self
             self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
             self.locationManager.requestWhenInUseAuthorization()
             self.locationManager.startUpdatingLocation()
         }
    private func setDelegates() {
        clientCategoryTxtField.delegate = self
        clientSubCategoryTxtField.delegate = self
        locationTextField.delegate = self
        paymentTypeTextField.delegate = self
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        clientSubCategoryTableView.delegate = self
        clientSubCategoryTableView.dataSource = self
        paymentTypeTableView.delegate   =  self
        paymentTypeTableView.dataSource =  self
        categoryTableView.separatorStyle = .none
        clientSubCategoryTableView.separatorStyle = .none
        categoryTableView.isScrollEnabled = false
        clientSubCategoryTableView.isScrollEnabled = false
        paymentTypeTableView.isScrollEnabled = false
        
        
        locationTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationFieldTapped)))
        
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        toTime.inputView = toTimePicker
        toTimePicker.datePickerMode = .time
        fromTime.inputView = fromTimePicker
        fromTimePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        toTimePicker.addTarget(self, action: #selector(ToTimeChanged), for: .valueChanged)
        fromTimePicker.addTarget(self, action: #selector(FromTimeChanged), for: .valueChanged)
    
        dateTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        fromTime.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(ToTimeDonePressed))
        toTime.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(FromeTimeDonePressed))
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short // MM-DD-YY
        formatter.timeStyle = .none
        dateTextField.text = formatter.string(from: datePicker.date)
        
        let formatter2 = DateFormatter()
        formatter2.dateStyle = .none // MM-DD-YY
        formatter2.timeStyle = .short
        fromTime.text = formatter2.string(from: fromTimePicker.date)
        
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .none // MM-DD-YY
        formatter3.timeStyle = .short
        toTime.text = formatter3.string(from: toTimePicker.date.addingTimeInterval(3*60*60))
        
    }
    @objc func locationFieldTapped() {
self.showMapsPopUp(title: "Please select your Location")
                        
    }
     @objc func ToTimeDonePressed(_ sender: Any) {
            print("Done")
            let formatter = DateFormatter()
            formatter.dateStyle = .none // MM-DD-YY
            formatter.timeStyle = .short
            toTime.text = formatter.string(from: toTimePicker.date)
        }
    @objc func FromeTimeDonePressed(_ sender: Any) {
               print("Done")
               let formatter = DateFormatter()
               formatter.dateStyle = .none // MM-DD-YY
               formatter.timeStyle = .short
               fromTime.text = formatter.string(from: fromTimePicker.date)
           }
    @objc func doneButtonClicked(_ sender: Any) {
        print("Done")
        let formatter = DateFormatter()
        formatter.dateStyle = .short // MM-DD-YY
        formatter.timeStyle = .none
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    @objc func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    @objc func ToTimeChanged(){
        let formatter = DateFormatter()
             formatter.dateStyle = .none
        formatter.timeStyle = .short
             
             toTime.text = formatter.string(from: toTimePicker.date)
        
    }
    private func animatePaymentTV(){
        view.layoutIfNeeded()
        paymentTypeTableView.isHidden = !paymentTypeTableView.isHidden
        paymentTypeTableViewHeight.constant = paymentTypeTableView.isHidden ? 0 : CGFloat(45 * viewModel.paymentTypes!.paymentTypeList!.count)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    private func animateCategoryTV(){
        view.layoutIfNeeded()
        categoryTableView.isHidden = !categoryTableView.isHidden
        if viewModel.categoriesDropDown != nil && viewModel.categoriesDropDown!.categoriesList!.count > 0{
            categoryTableViewHeight.constant = categoryTableView.isHidden ? 0 : CGFloat(45 * viewModel.categoriesDropDown!.categoriesList!.count)
        }
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    private func animateSubCategoryTV(){
           view.layoutIfNeeded()
           clientSubCategoryTableView.isHidden = !clientSubCategoryTableView.isHidden
           cubcategoryTableViewHeght.constant = clientSubCategoryTableView.isHidden ? 0 : CGFloat(45 * viewModel.subcategoriesDropDown!.categoriesList!.count)
           
           UIView.animate(withDuration: 0.5, animations: {
               self.view.layoutIfNeeded()
           })
           
       }
    
    @objc func FromTimeChanged(){
        let formatter = DateFormatter()
             formatter.dateStyle = .none
             formatter.timeStyle = .short
             
             fromTime.text = formatter.string(from: fromTimePicker.date)
        
    }
    func updateAddress(location: CLLocationCoordinate2D) {
        goocoder.reverseGeocodeCoordinate(location) { response, error in
            if let location = response?.firstResult() {
                
                if let lines = location.lines {
                    self.locationTextField.text = lines[0]
                }
            }
        }
        
        
    }
   func animateDropDown(collapsed : Bool){
          if collapsed{
              
              UIView.animate(withDuration: 0.7, delay:0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations:{
                self.paymentTypeTableViewHeight.constant +=  CGFloat(45) * CGFloat(self.viewModel.paymentTypes!.paymentTypeList!.count)
                //  self.dropDownArrow.transform = CGAffineTransform(rotationAngle: .pi)
                self.view.layoutIfNeeded()
                  
//                  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(300), execute: {
//                      self.tableView.separatorColor = UIColor.darkGray
//                      self.tableView.reloadData()
//                  })
              }){_ in
                  //Remove DispatchQueue above and uncomment this when changing aniumation
                  //to not use springVelocity and Damping
                  //self.tableView.separatorColor = UIColor.darkGray
                  //self.tableView.reloadData()
              }
              
              
          }else{
              
             // self.tableView.reloadData()
              UIView.animate(withDuration: 0.7, delay:0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations:{
                  
                  self.paymentTypeTableViewHeight.constant -=  CGFloat(45) * CGFloat(self.viewModel.paymentTypes!.paymentTypeList!.count)
                //  self.dropDownArrow.transform = CGAffineTransform(rotationAngle: .pi - 3.14159)
                 // self.tableView.separatorColor = UIColor.clear
                self.view.layoutIfNeeded()
                  
              })
          }
          
      }
    private func configureTableView(){
        categoryTableView.clipsToBounds = true
        categoryTableView.layer.cornerRadius = 12.0
        categoryTableView.addShadow(offset: CGSize.init(width: 0, height: 5), color: UIColor.black, radius: 4.0, opacity: 0.5)
        clientSubCategoryTableView.clipsToBounds = true
        clientSubCategoryTableView.layer.cornerRadius = 12.0
        clientSubCategoryTableView.addShadow(offset: CGSize.init(width: 0, height: 5), color: UIColor.black, radius: 4.0, opacity: 0.5)
        postJobButton.setup(applyGradient: true,title: "Post Job",rgb1: (192,221,184),rgb2: (174,200,55))
    }
 
       private func showMapsPopUp(title: String) {
            if let popvc = UIStoryboard(name: "PopUpView", bundle: nil).instantiateViewController(withIdentifier: "MapsPopUpView") as? MapsPopUpView
            {
                
                self.addChild(popvc)
                
                popvc.view.frame = self.view.frame
                
                self.view.addSubview(popvc.view)
//                popvc.titleLabel.text = title
//                popvc.buttonStackView.isHidden = true
            //     popvc.updateHeight(height: popvc.titleLabel.intrinsicContentSize.height + 170)
                popvc.containerView.backgroundColor = .red
                popvc.didMove(toParent: self)
                popvc.useCurrentLocation = {
              
                }

            
            }
              
        }
    func viewSlideInFromTopToBottom(view: UIView) -> Void {
           let transition:CATransition = CATransition()
           transition.duration = 0.5
           transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
           transition.type = CATransitionType.push
           transition.subtype = CATransitionSubtype.fromTop
           view.layer.add(transition, forKey: kCATransition)
       }
    // MARK:- IBAction Methods
    @IBAction func postJobTapped(_ sender: Any) {
        guard let jobCategory = clientCategoryTxtField.text , !jobCategory.isEmpty else {
            return
        }
        guard let jobSubcategory = clientSubCategoryTxtField.text , !jobSubcategory.isEmpty else {
            return
        }
        guard let jobDate = dateTextField.text , !jobDate.isEmpty else {
            return
        }
        guard let jobFrom = fromTime.text , !jobFrom.isEmpty else {
            return
        }
        guard let jobTo = toTime.text , !jobTo.isEmpty else {
            return
        }
        guard let jobInstructions = instructionsTextView.text , !jobInstructions.isEmpty else {
            return
        }
        guard let amount = amountField.text , !amount.isEmpty else {
            return
        }
        if fromMap {
            self.latitude   =  String(locationFromMap.latitude)
            self.longitude  =  String(locationFromMap.longitude)
        }
        let serverParams = ["job_category":parentCategoryID,"job_sub_category":childCategoryID,
                            "job_date":jobDate,"job_from":jobFrom,"job_to":jobTo,"job_instructions":jobInstructions,"payment_type":"3",
                            "amount":amount,"longitude":self.longitude,"latitude":self.latitude]
        startIndicator()
        viewModel.postJob(params: serverParams)
    }
    

}
// MARK:- DropDownTableView Methods
extension CreateJob: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == categoryTableView {
            return viewModel.categoriesDropDown?.categoriesList?.count ?? 0
        }
        else if tableView == paymentTypeTableView {
            return viewModel.paymentTypes?.paymentTypeList?.count ?? 0
        }
        else {
            return viewModel.subcategoriesDropDown?.categoriesList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dropdowncell", for: indexPath) as? DropDownListCell {
            cell.parentView.backgroundColor = .clear
            if tableView == categoryTableView {
                cell.nameLbl.text = viewModel.categoriesDropDown?.categoriesList?[indexPath.section].categoryTitle
                if indexPath.section == viewModel.categoriesDropDown?.categoriesList?.count ?? 1 - 1 {
                    cell.separatorView.isHidden = true
                    
                }
            
            }
            else if tableView == paymentTypeTableView {
                cell.nameLbl.text = viewModel.paymentTypes?.paymentTypeList?[indexPath.section].paymentTypeTitle
                if indexPath.section == viewModel.paymentTypes?.paymentTypeList?.count ?? 1 - 1 {
                                   cell.separatorView.isHidden = true
                               }
            }
            else {
                cell.nameLbl.text = viewModel.subcategoriesDropDown?.categoriesList?[indexPath.section].categoryTitle
                if indexPath.section == viewModel.subcategoriesDropDown?.categoriesList?.count ?? 1 - 1 {
                    cell.separatorView.isHidden = true
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            clientCategoryTxtField.text = viewModel.categoriesDropDown?.categoriesList?[indexPath.section].categoryTitle
               animateCategoryTV()
            if let Id = viewModel.categoriesDropDown?.categoriesList?[indexPath.section].categoryID {
                parentCategoryID = Id
            }
            viewModel.getSubCategoriesList(url: urlString + parentCategoryID)
        }
        else if tableView == clientSubCategoryTableView {
            clientSubCategoryTxtField.text = viewModel.subcategoriesDropDown?.categoriesList?[indexPath.section].categoryTitle
            animateSubCategoryTV()
            if let Id = viewModel.subcategoriesDropDown?.categoriesList?[indexPath.section].categoryID {
                          childCategoryID = Id
                      }
        }
        else if tableView == paymentTypeTableView {
            paymentTypeTextField.text = viewModel.paymentTypes?.paymentTypeList?[indexPath.section].paymentTypeTitle
            animatePaymentTV()

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
// MARK:- TextField ButtonClick Methods
extension CreateJob: DesignableTextFieldDelegate {
   
   
   
    
    func textFieldIconClicked(btn: UIButton) {
    }
    
    func textFieldRightButtonClicked(btn: UIButton) {
        if let view = btn.superview  {
            if view == clientCategoryTxtField {
//                if !subCategoryStackvIEW.subviews[1].isHidden {
//                    subCategoryStackvIEW.subviews[1].isHidden = true
//                }
//    categoryFieldStackView.subviews[1].isHidden = !categoryFieldStackView.subviews[1].isHidden
//
                animateCategoryTV()
            } else if view == clientSubCategoryTxtField {
//                if !categoryFieldStackView.subviews[1].isHidden {
//                                  categoryFieldStackView.subviews[1].isHidden = true
//                              }
//        subCategoryStackvIEW.subviews[1].isHidden = !subCategoryStackvIEW.subviews[1].isHidden
                animateSubCategoryTV()
                                   }
//            else if view == paymentTypeTextField {
//                  paymentTypeStackView.subviews[1].isHidden = !paymentTypeStackView.subviews[1].isHidden
            else if view == paymentTypeTextField {
             animatePaymentTV()
            }
//            }
        }
        
    }
    
}

// MARK:- Categories Delegate Methods
extension CreateJob: DropDownCategoriesProtocol {
   
    func jobPostSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.stopIndicator()
            self?.showPopUp(title: "Job Posted Successfully!", success: true, showFilledBtn: true)
        }
    }
    
    func jobPostFailure(response: String) {
        DispatchQueue.main.async { [weak self] in
            self?.stopIndicator()
            self?.showPopUp(title: response, success: false, showFilledBtn: true)
               }
    }
    
    func gotTitles() {
        DispatchQueue.main.async {
            self.paymentTypeTableView.reloadData()
        }

        
    }
    
    func titlesFailed() {
        print("Titles are not fetched")
    }
    
    func gotCategoriesforDD() {
        DispatchQueue.main.async {
            self.categoryTableView.reloadData()
        }
    }
    
    func gotSubCategoriesforDD() {
        DispatchQueue.main.async {
            self.clientSubCategoryTableView.reloadData()
               }
    }
    
    func categoriesforDropDownFailed() {
        //
    }
    
    func subcategoriesforDropDownFailed() {
        //
    }
    
    
}
extension CreateJob: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        //let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        if let _ = location?.coordinate.latitude , let _ = location?.coordinate.longitude {
            if let position = location?.coordinate{
                self.latitude  = String(position.latitude)
                self.longitude = String(position.longitude)
                self.updateAddress(location: position)
            }
        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
}
extension CreateJob: UITextFieldDelegate {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == locationTextField {
           return false
        }
        return true
       
    }
}


