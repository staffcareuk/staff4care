//
//  Availability.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 03/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class Availability: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var availabilityTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        availabilityTableView.delegate = self
        availabilityTableView.dataSource = self
        availabilityTableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headercell")

    }
  


}
extension Availability : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headercell", for: indexPath) as? HeaderCelllTableViewCell {
                       return cell
                   }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "chart", for: indexPath) as? ChartTableViewCell {
               
                    ChartTableViewCell.currentRow += 1
                    cell.chartCollectionView.reloadData()
                
                       cell.daySekectedDelegate = self
                       return cell
                   }
        }
       
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ye :: " , indexPath.section)
    }
  
    
}
extension Availability: DaySelected {
    func dayOfWeekSelected(day: Int, shiftTime: String, shiftHours: String,isAvailable: Bool) {
        print("Day :: " , day , "Available :: " , isAvailable)
    }
    
   
    
    
}
