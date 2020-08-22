//
//  ChartTableViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 03/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
protocol DaySelected {
    func dayOfWeekSelected(day: Int,shiftTime: String,shiftHours: String,isAvailable: Bool)
//    func infoForSelectedDay()
}


class ChartTableViewCell: UITableViewCell {
    
     var daySekectedDelegate: DaySelected?
    var shifts = ["Early Morning" , "Morning" , "Afternoon" , "Late Afternoon" , "Evening" , "Overnight" , "Overnight"  , "Overnight" ]
         var hours = ["0600 - 0900" , "0900 - 1200" , "1200 - 1500" , "1500 - 1800" , "1800 - 2100" , "2100 - 0600" , "2100 - 0600" , "2100 - 0600"]
    static var currentRow = -1
    @IBOutlet weak var chartCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        chartCollectionView.delegate = self
        chartCollectionView.dataSource = self
        self.isUserInteractionEnabled = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


}
extension ChartTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chartCVCell", for: indexPath) as? ChartCollectionViewCell {
            if indexPath.item == 0 {
                cell.availabilityBtn.isHidden = true
                cell.shiftLbl.isHidden = false
                cell.hoursLbl.isHidden = false
               
            }
            if indexPath.item > 0 {
                cell.availabilityBtn.isHidden = false
                cell.parentViewWidth.constant = 40
                cell.shiftLbl.isHidden = true
                cell.hoursLbl.isHidden = true
               
            }
            cell.shiftLbl.textColor = UIColor(rgb: 0x27418F)
            cell.hoursLbl.textColor = UIColor(rgb: 0x707070)
            cell.shiftLbl.font = UIFont(name: Fonts.Demi, size: 12)
            cell.hoursLbl.font = UIFont(name: Fonts.Book, size: 12)
            cell.shiftLbl.text = shifts[ChartTableViewCell.currentRow]
            cell.hoursLbl.text = hours[ChartTableViewCell.currentRow]
            

          
            cell.parentView.backgroundColor = .white
            cell.availabilityDelegate = self
            return cell
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 80, height: 80)
        }
        else {
            return CGSize(width: 40, height: 80)
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
            if let cell = collectionView.cellForItem(at: indexPath) as? ChartCollectionViewCell {
                daySekectedDelegate?.dayOfWeekSelected(day: indexPath.item, shiftTime: cell.shiftLbl.text!, shiftHours: cell.hoursLbl.text!,isAvailable: cell.isAvailable)
            }
            
        
    }
    
}
extension ChartTableViewCell: AvailabilityChanged {
    func isAvailableStatus(available: Bool) {
        guard let indexPath = chartCollectionView.indexPathsForSelectedItems?.first else { return }
        if let cell = chartCollectionView.cellForItem(at: indexPath) as? ChartCollectionViewCell {
            daySekectedDelegate?.dayOfWeekSelected(day: indexPath.item, shiftTime: cell.shiftLbl.text!, shiftHours: cell.hoursLbl.text!,isAvailable: available)
                  }
    }
    
    
}
