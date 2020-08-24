//
//  BottomSheetViewController.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 07/08/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit
protocol BottomSheetButtonTapDelegate: class {
    func applyPressed()
}

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var crossBtn: UIButton!
    
    var selectedJob : JobsList?
   
    let price = UILabel()
    let clientName        = UILabel()
    let roleLabel         = UILabel()
    let categoryLabel     = UILabel()
    let availabilityLabel = UILabel()
    let lineView          = UIView()
    let addressLabel      = UILabel()
    let applyJobbutton    = UIButton()
    let seeMoreButton     = UIButton()
    let separator         = UIView()
    let InstructionsView  = UITextView()


    
    var address = [String]()




    var height : CGFloat = 0
    var yComponent: CGFloat = 0.0

    var seeMoreCollapsed = true
    
    weak var delegate: BottomSheetButtonTapDelegate?

    
    var dimissBtnCallBack : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       prepareBackgroundView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    func jobSelectedFromPreviousController(job :JobsList){
        self.selectedJob = job
        if let amount = selectedJob?.amount {
            var paymentType = ""
            if let type = selectedJob?.payment_type {
                switch type {
                case "1":
                    paymentType = "\\total"
                    break
                case "2":
                    paymentType = "\\hr"
                case "3":
                    paymentType = "\\day"
                case "4":
                    paymentType = "\\week"
                
                    
                default:
                    break
                }
            }
            price.attributedText = NSAttributedString(string: "£" + amount + paymentType, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 16)!])
                  
        } else {
             price.attributedText = NSAttributedString(string: "NA", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 16)!])
        }
      
        
        clientName.attributedText = NSAttributedString(string: selectedJob?.hospitalName ?? "NA", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 12)!])
        
        roleLabel.attributedText = NSAttributedString(string: selectedJob?.contactDesignation ?? "NA", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x484F55) , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 13)!])
               
        categoryLabel.attributedText = NSAttributedString(string: selectedJob?.jobCategory ?? "NA", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0xD1D1D1) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 12)!])
               
        availabilityLabel.attributedText = NSAttributedString(string: selectedJob?.jobTo ?? "NA", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x9A9AC6) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 12)!])
               
        if let instructions = selectedJob?.jobInstructions {
            InstructionsView.attributedText = NSAttributedString(string: instructions, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 14)!])
        }
        print("Address :: " , address)
        view.setNeedsLayout()
        view.updateConstraints()
    }
    @IBAction func crossBtnPressed(_ sender: Any) {
    }
    func changeHeight() {
        UIView.animate(withDuration: 0.3) { [weak self] in
                   let frame = self?.view.frame
            if UIScreen.main.bounds.size.height > 667.0 {
                self?.yComponent = UIScreen.main.bounds.height * 0.65
            }
            else if UIScreen.main.bounds.size.height <= 667.0 {
                self?.yComponent = UIScreen.main.bounds.height * 0.6
            }
            self?.view.frame = CGRect(x: 0, y: CGFloat(self!.yComponent), width: frame!.width, height: frame!.height)
               }
    }
    func increaseHeight() {
        var yComponent2 : CGFloat = 0.0
        if !seeMoreCollapsed {
            UIView.animate(withDuration: 0.3) { [weak self] in
                                    let frame = self?.view.frame
                            if UIScreen.main.bounds.size.height > 667.0 {
                                            yComponent2 = UIScreen.main.bounds.height * 0.65
                                yComponent2 -= 160
                                        }
                                        else if UIScreen.main.bounds.size.height <= 667.0 {
                                            yComponent2 = UIScreen.main.bounds.height * 0.6
                                            yComponent2 -= 175
                                        }
                                    self?.view.frame = CGRect(x: 0, y: yComponent2, width: frame!.width, height: frame!.height)
                self?.separator.isHidden = false
                self?.InstructionsView.isHidden = false
                                }
        }
        else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                                              let frame = self?.view.frame
                                      // let yComponent = UIScreen.main.bounds.height * 0.65
                self?.view.frame = CGRect(x: 0, y: self!.yComponent, width: frame!.width, height: frame!.height)
                self?.separator.isHidden = true
                self?.InstructionsView.isHidden = true
                                          }
        }
       
    }
    func hideView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
                        let frame = self?.view.frame
                        let yComponent = UIScreen.main.bounds.height
                        self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
                    }
    }
    func prepareBackgroundView(){
 
        
        let mainView = UIView()
        mainView.frame = UIScreen.main.bounds
        mainView.backgroundColor = .white
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 20.0
        let button = UIButton(type: .close)
         mainView.addSubview(button)
        button.tintColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1, constant: -10).isActive = true
        button.addTarget(self, action: #selector(dimissBtnPressed), for: .touchUpInside)
        
        
        // Image
        let clientImage = UIImageView(image: UIImage(named: "generic-hospital"))
        clientImage.contentMode = .scaleAspectFill
        mainView.addSubview(clientImage)
        clientImage.translatesAutoresizingMaskIntoConstraints = false
        clientImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        clientImage.widthAnchor.constraint(equalToConstant: 100 ).isActive  = true
        clientImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        clientImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        
        // Price Label
        
        let priceLabel = UILabel()
        priceLabel.attributedText = NSAttributedString(string: "Price", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x27418F) , NSAttributedString.Key.font: UIFont(name: Fonts.Book, size: 16)!])
        mainView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: clientImage.bottomAnchor, constant: 20).isActive = true
        priceLabel.textAlignment = .center
        priceLabel.centerXAnchor.constraint(equalTo: clientImage.centerXAnchor, constant: 0).isActive = true
      
        //Price
       
       
        mainView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        price.textAlignment = .center
        price.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor, constant: 0).isActive = true
        
        // Adding STACKVIEW
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        mainView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        _ = stackView.leftAnchor.constraint(equalTo: clientImage.rightAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 10).isActive = true
        
        // Client Name Label
        clientName.numberOfLines = 0
        stackView.addArrangedSubview(clientName)
        
        roleLabel.numberOfLines = 0
        stackView.addArrangedSubview(roleLabel)
        
        categoryLabel.numberOfLines = 0
        stackView.addArrangedSubview(categoryLabel)
        
        availabilityLabel.numberOfLines = 0
        stackView.addArrangedSubview(availabilityLabel)
        
        mainView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        lineView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
        lineView.backgroundColor = .darkGray
        lineView.layer.masksToBounds = true
        lineView.layer.cornerRadius = 1.0
        
        // address label and Image
        
        let marker = UIImageView()
        marker.image = UIImage(named: "location-icon")
        marker.contentMode = .scaleAspectFill
        mainView.addSubview(marker)
        marker.translatesAutoresizingMaskIntoConstraints = false
        marker.leftAnchor.constraint(equalTo: lineView.leftAnchor, constant: 0).isActive = true
        marker.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20).isActive = true
        
        mainView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.centerYAnchor.constraint(equalTo: marker.centerYAnchor, constant: 0).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: marker.rightAnchor, constant: 10).isActive = true
        addressLabel.numberOfLines = 0
        addressLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        addressLabel.font = UIFont(name: Fonts.Demi, size: 12)
        addressLabel.textColor = UIColor(rgb: 0x27418F)
        addressLabel.text = "Lahore"
        
        
        
        
       // Adding Buttons
        
        mainView.addSubview(applyJobbutton)
        applyJobbutton.translatesAutoresizingMaskIntoConstraints = false
        
        applyJobbutton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 35).isActive = true
      
        applyJobbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
   
        applyJobbutton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        applyJobbutton.widthAnchor.constraint(equalToConstant: (self.view.bounds.size.width * 0.49 ) - 10).isActive = true
        
      
        applyJobbutton.backgroundColor = .red
        applyJobbutton.setTitleColor(.white, for: .normal)
       
        let string = NSAttributedString(string: "Apply Job", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 16)!])
        applyJobbutton.setAttributedTitle(NSAttributedString(attributedString: string), for: .normal)
        applyJobbutton.setGradientBackgroundColor(colors: [ UIColor(red: 192/255.0, green: 221/255.0, blue: 184/255.0, alpha: 1.0), UIColor(red: 174/255.0, green: 200/255.0, blue: 55/255.0, alpha: 1.0)], axis: .vertical, cornerRadius: 25) { view in
           guard let btn = view as? UIButton, let imageView = btn.imageView else { return }
           btn.bringSubviewToFront(imageView) // To display imageview of button
            
    
       }
        
        mainView.addSubview(seeMoreButton)
               seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
               
        seeMoreButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 35).isActive = true
               seeMoreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          
               seeMoreButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
               seeMoreButton.widthAnchor.constraint(equalToConstant: (self.view.bounds.size.width * 0.49 ) - 10).isActive = true
               
             
               seeMoreButton.backgroundColor = .red
               seeMoreButton.setTitleColor(.white, for: .normal)
              
               let string2 = NSAttributedString(string: "See More", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font: UIFont(name: Fonts.Demi, size: 16)!])
               seeMoreButton.setAttributedTitle(NSAttributedString(attributedString: string2), for: .normal)
               seeMoreButton.setGradientBackgroundColor(colors: [ UIColor(red: 154/255.0, green: 154/255.0, blue: 198/255.0, alpha: 1.0), UIColor(red: 39/255.0, green: 65/255.0, blue: 143/255.0, alpha: 1.0)], axis: .vertical, cornerRadius: 25) { view in
                  guard let btn = view as? UIButton, let imageView = btn.imageView else { return }
                  btn.bringSubviewToFront(imageView) // To display imageview of button
              }
        // Add See More View
        
          // Add Seaparator
        mainView.addSubview(separator)
        separator.backgroundColor = .darkGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separator.layer.masksToBounds = true
        separator.layer.cornerRadius = 1
        separator.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        separator.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        separator.topAnchor.constraint(equalTo: seeMoreButton.bottomAnchor, constant: 10).isActive = true
        separator.isHidden = true
        // Add Instructions View
        mainView.addSubview(InstructionsView)
        InstructionsView.translatesAutoresizingMaskIntoConstraints = false
        InstructionsView.layer.masksToBounds = true
        InstructionsView.layer.cornerRadius = 12.0
        InstructionsView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10).isActive = true
        InstructionsView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        InstructionsView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        InstructionsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        InstructionsView.backgroundColor = .tertiarySystemBackground
        InstructionsView.layer.borderColor = UIColor.lightGray.cgColor
        InstructionsView.layer.borderWidth = 1.0
        InstructionsView.isEditable = false
      
        // Add Button Targets
                   applyJobbutton.addTarget(self, action: #selector(applyJobTapped), for: .touchUpInside)
                   seeMoreButton.addTarget(self, action: #selector(seeMoreTapped), for: .touchUpInside)
    
        view.insertSubview(mainView, at: 0)
    }
    @objc func cancelTapped(){
        dimissBtnCallBack!()
    }
    @objc func dimissBtnPressed() {
        dimissBtnCallBack!()
    }
    @objc func applyJobTapped() {
        delegate?.applyPressed()
    }
    @objc func seeMoreTapped() {
        self.increaseHeight()
        self.seeMoreCollapsed = !self.seeMoreCollapsed
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        print(translation.y)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
   
    
}
extension UILabel{

public var requiredHeight: CGFloat {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.attributedText = attributedText
    label.sizeToFit()
    return label.frame.height
  }
}
