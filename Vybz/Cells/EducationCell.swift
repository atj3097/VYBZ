//
//  EducationCell.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import FirebaseAuth
class EducationCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var edLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func bind(color: String, imageName: String) {
        contentView.backgroundColor = color.hexColor
    }
}
