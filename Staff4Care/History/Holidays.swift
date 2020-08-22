//
//  Holidays.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
import FSCalendar

class Holidays: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var holidaysTableView: UITableView!
    
    // MARK:- Variables
    var selectedDates = [String]() {
           didSet{
               UIView.transition(with: holidaysTableView,
               duration: 0.35,
               options: .curveEaseOut,
               animations: { self.holidaysTableView.reloadData() })
           }
       }
       let dateFormatter = DateFormatter()
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]? {
        didSet {
            datesRange?.forEach({ (date) in
            selectedDates.append(dateFormatter.string(from: date))
            })
        }
    }

       
       
    
    
    
    
    
    
    // MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        holidaysTableView.delegate = self
        holidaysTableView.dataSource = self
        holidaysTableView.estimatedRowHeight = UITableView.automaticDimension
        holidaysTableView.rowHeight = UITableView.automaticDimension

             

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Methods
    private func configureCalendar() {
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
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }


}

extension Holidays: FSCalendarDelegate , FSCalendarDataSource ,FSCalendarDelegateAppearance{
    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//
//        selectedDates.append(dateFormatter.string(from: date))
//
//    }
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        selectedDates = selectedDates.filter { $0 != dateFormatter.string(from: date) }
//
//
//    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]

            print("datesRange contains: \(datesRange!)")

            return
        }

        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]

                print("datesRange contains: \(datesRange!)")

                return
            }

            let range = datesRange(from: firstDate!, to: date)

            lastDate = range.last

            for d in range {
                calendar.select(d)
            }

            datesRange = range

            print("datesRange contains: \(datesRange!)")

            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []

            print("datesRange contains: \(datesRange!)")
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:

        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
}

extension Holidays: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "holidaycell", for: indexPath) as? HolidayCell {
        
            cell.dateRangeLabel.text = selectedDates[indexPath.section]
            
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

