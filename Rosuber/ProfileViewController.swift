//
//  ProfileViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    let menuLauncher = BottomMenuLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        menuLauncher.showMenu()
    }

}
