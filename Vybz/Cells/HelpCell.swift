//
//  HelpCell.swift
//  Vybz
//
//  Created by God on 3/23/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit

class HelpCell: UICollectionViewCell {
    var currentTip: Help!
    @IBOutlet weak var helpTitle: UILabel!
    @IBOutlet weak var helpParahraph: UILabel!
    @IBOutlet weak var helpGif: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func bind(color: String, imageName: String) {
        contentView.backgroundColor = color.hexColor
    }
}
