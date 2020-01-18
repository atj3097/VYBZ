//
//  UIButton.swift
//  Vybz
//
//  Created by God on 1/18/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    func roundButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
       button.layer.shadowColor = UIColor.darkGray.cgColor
       button.layer.shadowRadius = 5
       button.layer.shadowOpacity = 0.5
       button.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
