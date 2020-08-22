//
//  JobCalendar.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 05/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import FSCalendar

class JobCalendar: UIViewController {
    
    // MARK:- IB Outlets
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var bottomLayerView: UIView!
    @IBOutlet weak var bottomLayerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var containerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var shiftsTableView: UITableView!
    
    
    
    
    // MARK:- Variables
    var previousFrameToReset = CGRect()
    var previousFrameToConstant = CGRect()
    var selectedDates = [String]() {
        didSet{
            UIView.transition(with: shiftsTableView,
            duration: 0.35,
            options: .curveEaseOut,
            animations: { self.shiftsTableView.reloadData() })
        }
    }
    let dateFormatter = DateFormatter()
    
    
    
    
    
    
    // MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        shiftsTableView.delegate = self
        shiftsTableView.dataSource = self
        shiftsTableView.estimatedRowHeight = UITableView.automaticDimension
        shiftsTableView.rowHeight = UITableView.automaticDimension

        
        
      
    
    }
 
    
    
    // MARK:- Methods
    private func changeAppearance(button: UIButton) {
              if button == upcomingButton {
                  button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
                  pastButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
              }
              else if button == pastButton{
                  button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
                  upcomingButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
              }
           
              
          }
    private func configureCalendar() {
        containerViewWidth.constant = UIScreen.main.bounds.size.width - 20
              bottomLayerViewWidth.constant =   (containerViewWidth.constant / 2) - 30
              previousFrameToConstant = bottomLayerView.frame
              
              calendarView.delegate = self
              calendarView.dataSource = self
              calendarView.appearance.selectionColor = UIColor(rgb: 0x9A9AC6)
              calendarView.allowsMultipleSelection = true
              calendarView.calendarWeekdayView.layer.masksToBounds = true
              calendarView.calendarWeekdayView.layer.cornerRadius = 10
              calendarView.appearance.headerTitleFont = UIFont(name: Fonts.Book, size: 18)
             
              calendarView.calendarWeekdayView.weekdayLabels.forEach { (label) in
                        label.backgroundColor = UIColor(rgb: 0xC0DDB8)
                        label.textColor = .white
                    }
              dateFormatter.dateFormat = "dd LLLL, yyyy"

              
    }
    
    
    
    
    
    // MARK:- UI Methods
    
    
    
    
    
    // MARK:- IBAction Methods
    @IBAction func upcomingButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerBackward()
        animateTableViewTransitionLeft()
    }
    @IBAction func pastButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerForward()
        calendarView.collectionView.reloadData()
        animateTableViewTransitionRight()

    }
    
    
    
    
    
    // MARK:- Animation Methods
    private func animateBottomLayerForward() {
            previousFrameToReset = bottomLayerView.frame
            
            UIView.animate(withDuration: 0.3) {
                self.bottomLayerView.frame = CGRect(x: self.containerView.frame.width / 2 + 15, y: self.previousFrameToReset.origin.y, width: self.previousFrameToReset.width, height: self.previousFrameToReset.height)
            }
        }
        private func animateBottomLayerBackward() {
            
            UIView.animate(withDuration: 0.3) {
                self.bottomLayerView.frame = CGRect(x: self.previousFrameToConstant.origin.x, y: self.previousFrameToConstant.origin.y, width: self.previousFrameToConstant.width, height: self.previousFrameToConstant.height)
            }
        }
    private func animateTableViewTransitionRight() {
           let transition = CATransition()
           transition.type = CATransitionType.push
           transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           transition.fillMode = CAMediaTimingFillMode.forwards
           transition.duration = 0.4
           transition.subtype = CATransitionSubtype.fromRight
           self.shiftsTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
           // Update your data source here
           self.shiftsTableView.reloadData()
       }
       private func animateTableViewTransitionLeft() {
             let transition = CATransition()
             transition.type = CATransitionType.push
             transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
             transition.fillMode = CAMediaTimingFillMode.forwards
             transition.duration = 0.4
             transition.subtype = CATransitionSubtype.fromLeft
             self.shiftsTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
             // Update your data source here
             self.shiftsTableView.reloadData()
         }
    

}


extension JobCalendar: FSCalendarDelegate , FSCalendarDataSource ,FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        selectedDates.append(dateFormatter.string(from: date))
       
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDates = selectedDates.filter { $0 != dateFormatter.string(from: date) }


    }

    
}

extension JobCalendar: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookingscell", for: indexPath) as? CalendarCell {
        
            cell.dateLabel.text = selectedDates[indexPath.section]
            
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
              let headerView = UIView()
              headerView.backgroundColor = UIColor.clear
              return headerView
          }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
       }
    
    
    
    
}
