//
//  AvailabityVC.swift
//  Staff4Care
//
//  Created by Asad Khan on 31/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
class AvailabityVC:UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updateHrsLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var monArray = [Monday]()
    var tuArray = [Tuesday]()
    var wedArray = [Wednesday]()
    var thuArray = [Thursday]()
    var friArray = [Friday]()
    var satArray = [Saturday]()
    var sunArray = [Sunday]()
    
    var monday = ""
    var tuesday = ""
    var wednesday = ""
    var thursday = ""
    var friday = ""
    var saturday = ""
    var sunday = ""
    
    
    var spinner = NVActivityIndicatorView(frame: .zero, type: .ballDoubleBounce, color:  UIColor(rgb: 0x27418F), padding: 10)
    // Blur View
    let blurEffectBackground = UIBlurEffect(style: UIBlurEffect.Style.light)
    lazy var blurEffectViewBackground = UIVisualEffectView(effect: blurEffectBackground)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        getAvailabity()
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        self.setAvailabityStr()
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setUpTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AvailabityCell", bundle: nil), forCellReuseIdentifier: "AvailabityCell")
        tableView.register(UINib(nibName: "DaysCell", bundle: nil), forCellReuseIdentifier: "DaysCell")
        
    }
    
    func startIndicator() {
        addBlurViewforActivity()
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.heightAnchor.constraint(equalToConstant: 70).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 70).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func stopIndicator() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        removeBlurViewforActivity()
    }
    
    func addBlurViewforActivity() {
        blurEffectViewBackground.frame = view.bounds
        blurEffectViewBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectViewBackground)
        blurEffectViewBackground.alpha = 0
        blurEffectViewBackground.isHidden = true
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.blurEffectViewBackground.isHidden = false
            self?.blurEffectViewBackground.alpha = 0.6
            
        }) { (finished) in
            if finished {
                self.spinner.startAnimating()
            }
        }
        
    }
    func removeBlurViewforActivity() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.blurEffectViewBackground.alpha = 0
            self?.blurEffectViewBackground.isHidden = true
            
        }) { (finished) in
            if finished {
                self.blurEffectViewBackground.removeFromSuperview()
            }
        }
    }
    
    
    func setAvailabityStr() -> Void {
        monday = ""
        for item in monArray {
            if(item.is_available == true) {
                if(monday == "") {
                    monday = (item.shift_id ?? "")
                }
                else {
                    monday = monday + "_" + (item.shift_id ?? "")
                }
            }
        }
        tuesday = ""
        for item in tuArray {
            if(item.is_available == true) {
                if(tuesday == "") {
                    tuesday = (item.shift_id ?? "")
                }
                else {
                    tuesday = tuesday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        wednesday = ""
        for item in wedArray {
            if(item.is_available == true) {
                if(wednesday == "") {
                    wednesday = (item.shift_id ?? "")
                }
                else {
                    wednesday = wednesday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        
        thursday = ""
        for item in thuArray {
            if(item.is_available == true) {
                if(thursday == "") {
                    thursday = (item.shift_id ?? "")
                }
                else {
                    thursday = thursday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        
        friday = ""
        for item in friArray {
            if(item.is_available == true) {
                if(friday == "") {
                    friday = (item.shift_id ?? "")
                }
                else {
                    friday = friday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        
        saturday = ""
        for item in satArray {
            if(item.is_available == true) {
                if(saturday == "") {
                    saturday = (item.shift_id ?? "")
                }
                else {
                    saturday = saturday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        sunday = ""
        for item in sunArray {
            if(item.is_available == true) {
                if(sunday == "") {
                    sunday = (item.shift_id ?? "")
                }
                else {
                    sunday = sunday + "_" + (item.shift_id ?? "")
                }
                
            }
        }
        
        saveAvailabity()
    }
}




//MARK:-Table View delegate methods
extension AvailabityVC:UITableViewDelegate, UITableViewDataSource , AvailabityCellDelegate {
    
    func availabityBtnClicked(_ shiftId: Int) {
        for (index,item) in monArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = monArray[index]
                obj.is_available = !(obj.is_available ?? false)
                monArray[index] = obj
            }
        }
        
        for (index,item) in tuArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = tuArray[index]
                obj.is_available = !(obj.is_available ?? false)
                tuArray[index] = obj
            }
        }
        
        for (index,item) in wedArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = wedArray[index]
                obj.is_available = !(obj.is_available ?? false)
                wedArray[index] = obj
            }
        }
        
        for (index,item) in thuArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = thuArray[index]
                obj.is_available = !(obj.is_available ?? false)
                thuArray[index] = obj
            }
        }
        
        for (index,item) in friArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = friArray[index]
                obj.is_available = !(obj.is_available ?? false)
                friArray[index] = obj
            }
        }
        
        for (index,item) in satArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = satArray[index]
                obj.is_available = !(obj.is_available ?? false)
                satArray[index] = obj
            }
        }
        
        for (index,item) in sunArray.enumerated() {
            if(item.shift_id == "\(shiftId)") {
                var obj = sunArray[index]
                obj.is_available = !(obj.is_available ?? false)
                sunArray[index] = obj
            }
        }
        
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return 44
        }
        else {
            return 74
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.monArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysCell
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabityCell", for: indexPath) as! AvailabityCell
            cell.selectionStyle = .none
            let monObj = monArray[indexPath.row - 1]
            cell.titleLbl.text = monObj.shift_title ?? ""
            cell.timeLbl.text = (monObj.shift_start_time ?? "") + " - " + (monObj.shift_end_time ?? "")
            
            if(monArray[indexPath.row - 1].is_available == true) {
                cell.mondayBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.mondayBtn.tag = Int(monArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.mondayBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.mondayBtn.tag = Int(monArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(tuArray[indexPath.row - 1].is_available == true) {
                cell.tueBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.tueBtn.tag = Int(tuArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.tueBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.tueBtn.tag = Int(tuArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(wedArray[indexPath.row - 1].is_available == true) {
                cell.wedBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.wedBtn.tag = Int(wedArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.wedBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.wedBtn.tag = Int(wedArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(thuArray[indexPath.row - 1].is_available == true) {
                cell.thuBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.thuBtn.tag = Int(thuArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.thuBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.thuBtn.tag = Int(thuArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(friArray[indexPath.row - 1].is_available == true) {
                cell.friBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.friBtn.tag = Int(friArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.friBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.friBtn.tag = Int(friArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(satArray[indexPath.row - 1].is_available == true) {
                cell.satBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.satBtn.tag = Int(satArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.satBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.satBtn.tag = Int(satArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            if(sunArray[indexPath.row - 1].is_available == true) {
                cell.sunBtn.setImage(UIImage.init(named: "ic_tick"), for: .normal)
                cell.sunBtn.tag = Int(sunArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            else {
                cell.sunBtn.setImage(UIImage.init(named: "ic_cross"), for: .normal)
                cell.sunBtn.tag = Int(sunArray[indexPath.row - 1].shift_id ?? "") ?? 0
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}




extension AvailabityVC {
    func getAvailabity() -> Void {
        let successClosure: DefaultAPISuccessClosureData = {
            (result) in
            self.stopIndicator()
            
            do {
                let resultIs = try JSONDecoder().decode(AvailabityModel.self, from:result)
                
                print(resultIs)
                if(resultIs.response_code == 200) {
                    
                    if let mArr = resultIs.shifts?.monday {
                        self.monArray = mArr
                    }
                    if let tuArr = resultIs.shifts?.tuesday {
                        self.tuArray = tuArr
                    }
                    
                    if let wedArr = resultIs.shifts?.wednesday {
                        self.wedArray = wedArr
                    }
                    
                    if let thuArr = resultIs.shifts?.thursday {
                        self.thuArray = thuArr
                    }
                    
                    if let friArr = resultIs.shifts?.friday {
                        self.friArray = friArr
                    }
                    
                    if let satArr = resultIs.shifts?.saturday {
                        self.satArray = satArr
                    }
                    
                    if let sunArr = resultIs.shifts?.sunday {
                        self.sunArray = sunArr
                    }
                    DispatchQueue.main.async { () -> Void in
                        self.tableView.reloadData()
                    }
                }
                else {
                }
                
            }catch{
                print(error)
                
            }
            
        }
        let failureClousure: DefaultAPIFailureClosure = { (result) in
            self.stopIndicator()
            
        }
        
        let apiUrl = Route.getAvailabity.url() + (loggedUser?.userID ?? "")
        
        let route: URL = URL(string: apiUrl)!
        
        let parems : Parameters = [:]
        
        self.startIndicator()
        ApiManager.getRequestWithData(route: route, param: parems, success: successClosure, failure: failureClousure)
        
    }
    
    
    func saveAvailabity() -> Void {
        let successClosure: DefaultAPISuccessClosureData = {
            (result) in
            self.stopIndicator()
            
            do {
                let resultIs = try JSONDecoder().decode(SetAvailabityModel.self, from:result)
                
                print(resultIs)
                if(resultIs.response_code == 200) {
                    
                    
                }
                else {
                }
                
            }catch{
                print(error)
                
            }
            
        }
        let failureClousure: DefaultAPIFailureClosure = { (result) in
            self.stopIndicator()
            
        }
        
        let apiUrl = Route.saveAvailabity.url() + (loggedUser?.userID ?? "")
        
        let route: URL = URL(string: apiUrl)!
        
        let parems : Parameters = ["monday":monday,
                                   "tuesday":tuesday,
                                   "wednesday":wednesday,
                                   "thursday":thursday,
                                   "friday":friday,
                                   "saturday":saturday,
                                   "sunday":sunday]
        
        self.startIndicator()
        ApiManager.postRequestWithReturnData(route: route, param: parems, success: successClosure, failure: failureClousure)
        
    }
    
}
