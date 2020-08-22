//
//  ViewJobs.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class ViewJobs: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var bottomLayerView: UIView!
    @IBOutlet weak var pastJobBtn: UIButton!
    
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var containerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bottomLayerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var latestJobBtn: UIButton!
    
    
    
    
    
    // MARK:- Variables
    
    var viewModel = ViewJobsViewModel()
    var previousFrameToReset = CGRect()
    var previousFrameToConstant = CGRect()
    var selectedTab = 0
    
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        
//        viewModel.getJobsDelegate = self
//        viewModel.getAvailableJobs()

    }
    
    // MARK:- Methods
    private func setProperties(){
        containerViewWidth.constant = UIScreen.main.bounds.size.width - 20
        bottomLayerWidth.constant =   (containerViewWidth.constant / 2) - 30
        previousFrameToConstant = bottomLayerView.frame
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        jobsTableView.estimatedRowHeight = 44.0
        jobsTableView.rowHeight = UITableView.automaticDimension
        jobsTableView.allowsSelection = false
        jobsTableView.register(UINib(nibName: "ExpireJobTableViewCell", bundle: nil), forCellReuseIdentifier: "expirejobcell")
    }
    private func changeAppearance(button: UIButton) {
           if button == latestJobBtn {
               button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
               pastJobBtn.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
           }
           else if button == pastJobBtn{
               button.setTitleColor(UIColor(rgb: 0x27418F), for: .normal)
               latestJobBtn.setTitleColor(UIColor(rgb: 0x9A9AC6), for: .normal)
           }
        
           
       }
    
    
    // MARK:- IBAction Methods
    @IBAction func latestJobButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerBackward()
        selectedTab = 0
        animateTableViewTransitionLeft()
        
    }
    @IBAction func pastJobButtonTapped(_ sender: UIButton) {
        changeAppearance(button: sender)
        animateBottomLayerForward()
        selectedTab = 1
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
    private func animateTableViewReloadData() {
        UIView.transition(with: jobsTableView,
        duration: 0.35,
        options: .transitionFlipFromLeft,
        animations: { self.jobsTableView.reloadData() })
    }
    private func animateTableViewTransitionRight() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 0.4
        transition.subtype = CATransitionSubtype.fromRight
        self.jobsTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        // Update your data source here
        self.jobsTableView.reloadData()
    }
    private func animateTableViewTransitionLeft() {
          let transition = CATransition()
          transition.type = CATransitionType.push
          transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
          transition.fillMode = CAMediaTimingFillMode.forwards
          transition.duration = 0.4
          transition.subtype = CATransitionSubtype.fromLeft
          self.jobsTableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
          // Update your data source here
          self.jobsTableView.reloadData()
      }
    
}
extension ViewJobs: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTab == 0 {
            return viewModel.latestJobs?.jobsList?.count ?? 0
         }
        else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTab == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "viewjobcell", for: indexPath) as? ViewJobsTableViewCell {
                cell.buttonTapDelegate = self
                if let job = viewModel.latestJobs?.jobsList?[indexPath.row] {
                    cell.configureCell(job: job)
                }
                return cell
            }
            
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "expirejobcell", for: indexPath) as? ExpireJobTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){


        if #available(iOS 13, *) {
            (scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]).backgroundColor = UIColor(rgb: 0x27418F) //verticalIndicator
            (scrollView.subviews[(scrollView.subviews.count - 2)].subviews[0]).backgroundColor = UIColor(rgb: 0x27418F) //horizontalIndicator
        } else {
            if let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as? UIImageView) {
                verticalIndicator.backgroundColor = UIColor(rgb: 0x27418F)
            }

            if let horizontalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 2)] as? UIImageView) {
                horizontalIndicator.backgroundColor = UIColor(rgb: 0x27418F)
            }
        }
    }
}
// MARK:- Cell Delegate Methods
extension ViewJobs : JobsButtonsTapped {
    func seeJobTapped() {
        print("See Job Tapped")
    }
    
    func applyJobTapped() {
        print("Apply Job Tapped")
    }
    
    func expireJobTapped() {
        print("Expire Job Tapped")
    }
    
    
}

// MARK:- ViewJobs Delegate Methods
//extension ViewJobs: GetJobsProtocol {
//    func getJobsSuccess() {
//        DispatchQueue.main.async {
//            self.jobsTableView.reloadData()
//        }
//    }
//
//    func getJobsFailed() {
//        print("Didn't got jobs from server")
//    }
//
//
//}
