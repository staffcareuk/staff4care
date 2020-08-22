//
//  TravelHistory.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 06/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class TravelHistory: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bottomLayerView: UIView!
    @IBOutlet weak var bottomLayerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var shiftsButton: UIButton!
    @IBOutlet weak var travelTableView: UITableView!
    
    
    
    
    
    
    
    // MARK:- Variables
    var previousFrameToReset = CGRect()
    var previousFrameToConstant = CGRect()
    var isTravelTab = true
    
    
    
    // MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        travelTableView.delegate = self
        travelTableView.dataSource = self

    }
    
    // MARK:- Methods
    private func convertToCurrencyString(label: UILabel) {
          let currencyFormatter = NumberFormatter()
          currencyFormatter.usesGroupingSeparator = true
          currencyFormatter.numberStyle = .currency
          currencyFormatter.locale = Locale.current
          if let myInteger = Double(label.text!) {
              let myNumber = NSNumber(value:myInteger)
              let priceString = currencyFormatter.string(from: myNumber)
              label.text = priceString
          
            }
      }
    private func configureViews() {
        containerViewWidth.constant = UIScreen.main.bounds.size.width - 20
        bottomLayerViewWidth.constant =   (containerViewWidth.constant / 2) - 30
        previousFrameToConstant = bottomLayerView.frame
    }
    private func changeAppearance(button: UIButton) {
        if button == travelButton {
            button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
            shiftsButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
        }
        else if button == shiftsButton{
            button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
            travelButton.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
        }
        
        
    }
    
    
    
    
    // MARK:- IBActions
    @IBAction func travelButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerBackward()
        self.isTravelTab = true
        animateTableViewTransitionLeft()
    }
    @IBAction func shiftsButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerForward()
        self.isTravelTab = false
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
              self.travelTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
              // Update your data source here
              self.travelTableView.reloadData()
          }
          private func animateTableViewTransitionLeft() {
                let transition = CATransition()
                transition.type = CATransitionType.push
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.fillMode = CAMediaTimingFillMode.forwards
                transition.duration = 0.4
                transition.subtype = CATransitionSubtype.fromLeft
                self.travelTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
                // Update your data source here
                self.travelTableView.reloadData()
            }
    
}

extension TravelHistory: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "travelhistorycell", for: indexPath) as? TravelHistoryCell {
            if isTravelTab {
                convertToCurrencyString(label: cell.amountLabel)
                cell.amountStack.isHidden = true
                cell.milesStack.isHidden = false
            }
            else if !isTravelTab {
                cell.amountStack.isHidden = false
                cell.milesStack.isHidden = true
               }
            
           
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
        return 5.0
    }
    
    
}
