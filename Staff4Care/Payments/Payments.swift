//
//  Payments.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 05/07/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class Payments: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var currencyTitleLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pendingAmountLabel: UILabel!
    @IBOutlet weak var rejectedAmountLabel: UILabel!
    @IBOutlet weak var paymentsTableView: UITableView!
    
    
    
    
    
    
    
    
    // MARK:- Variables
    var displayLink = CADisplayLink()
    var startValue:Double = 0
    var endValue:Double = 30.00
    lazy var animationDuration:Double = endValue / (endValue/2)
    let animationStartDate = Date()


    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        paymentsTableView.estimatedRowHeight = UITableView.automaticDimension
        paymentsTableView.rowHeight = UITableView.automaticDimension
        convertToCurrencyString(label: currencyTitleLbl)
        convertToCurrencyString(label: pendingAmountLabel)
        convertToCurrencyString(label: rejectedAmountLabel)
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimationPendingLabel))
        self.displayLink.add(to: .main, forMode: .default)
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimationRejectedLabel))
        self.displayLink.add(to: .main, forMode: .default)
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimationTitleLabel))
        self.displayLink.add(to: .main, forMode: .default)
        
        
        }
    
       
        
        // Do any additional setup after loading the view.
    
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
    
    
    // MARK:- Animation Methods
    @objc func handleAnimationPendingLabel()
    {
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration {
            self.pendingAmountLabel.text = "\(endValue)"
            convertToCurrencyString(label: pendingAmountLabel)
        }
        else {
            let percentage = elapsedTime / animationDuration
            let value = percentage * (endValue - startValue)
            self.pendingAmountLabel.text = String(format: "%.3f", value)
            convertToCurrencyString(label: pendingAmountLabel)
            
        }
        
        
    }
    @objc func handleAnimationRejectedLabel()
       {
           
           let now = Date()
           let elapsedTime = now.timeIntervalSince(animationStartDate)
           if elapsedTime > animationDuration {
               self.rejectedAmountLabel.text = "\(endValue)"
               convertToCurrencyString(label: rejectedAmountLabel)
           }
           else {
               let percentage = elapsedTime / animationDuration
               let value = percentage * (endValue - startValue)
               self.rejectedAmountLabel.text = String(format: "%.3f", value)
               convertToCurrencyString(label: rejectedAmountLabel)
               
           }
           
           
       }
    @objc func handleAnimationTitleLabel() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration {
            self.currencyTitleLbl.text = "\(endValue)"
            convertToCurrencyString(label: currencyTitleLbl)
        }
        else {
            let percentage = elapsedTime / animationDuration
            let value = percentage * (endValue - startValue)
            self.currencyTitleLbl.text = String(format: "%.3f", value)
            convertToCurrencyString(label: currencyTitleLbl)
            
        }
    }
       
    
    
}

extension Payments: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "paymentcell", for: indexPath) as? PaymentCell {
            convertToCurrencyString(label: cell.amountLabel)
           
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
