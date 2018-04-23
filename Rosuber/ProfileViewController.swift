//
//  ProfileViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    let menuLauncher = BottomMenuLauncher(
        menuItems: [
            MenuItem(title: " Upload Profile Image", image: "add_photo", action: {
                ()->() in print("pressed upload")
            }),MenuItem(title: " Update Phone Number", image: "phone", action: {
                ()->() in print("pressed update")
            })])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        menuLauncher.showMenu()
    }
    
}
