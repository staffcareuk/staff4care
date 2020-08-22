//
//  ClientCollectionViewCell.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 27/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

class ClientCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clientImage: ImageFromSource!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    override init(frame: CGRect) {
     super.init(frame: frame)
       }
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    func configureCell(category: Category) {
        self.parentView.applyStylingProperties(foregoundColor: .white, shadowColor: 0x707070)
        if let imageUrl = category.categoryImage{
            self.clientImage.contentMode = .scaleAspectFill
            self.clientImage.loadImageUsingUrlString(imageUrl: imageUrl,resize: true,targetSize: CGSize(width: 62, height: 62))
        }
        self.clientName.font = UIFont(name: Fonts.Demi, size: 14)
        self.clientName.text = category.categoryTitle
    }
    
   
}
