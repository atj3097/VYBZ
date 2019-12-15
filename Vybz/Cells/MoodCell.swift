//
//  MoodCell.swift
//  Vybz
//
//  Created by God on 12/10/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class MoodCell: UICollectionViewCell {
    @IBOutlet weak var moodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func bind(color: String, imageName: String) {
        contentView.backgroundColor = color.hexColor
        
    }
}
