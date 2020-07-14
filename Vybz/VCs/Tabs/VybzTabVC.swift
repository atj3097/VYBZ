//
//  VybzTabVC.swift
//  Vybz
//
//  Created by God on 12/10/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class VybzTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = .systemFill
        self.tabBar.tintColor = .darkGray
        self.tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
    }


}
