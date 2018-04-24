//
//  ProfileViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    //    let menuLauncher = BottomMenuLauncher(
    //        menuItems: [
    //            MenuItem(title: " Upload Profile Image", image: "add_photo", action: {
    //                ()->() in print("pressed upload")
    //            }),MenuItem(title: " Update Phone Number", image: "phone", action: {
    //                ()->() in print("pressed update")
    //            })])
    //    var buttons: [UIButton]!
    //    let menuLauncher: BottomMenuLauncher!
    
    let menuLauncher = BottomMenuLauncher(
        buttons: [
            {
                let button = UIButton(type: UIButtonType.system)
                button.setTitle(" Upload Profile Image", for: .normal)
                button.setImage(UIImage(named: "add_photo"), for: .normal)
                button.addTarget(self, action: #selector(pressedUploadPhoto), for: .touchUpInside)
                return button
            }(),
            {
                let button = UIButton(type: UIButtonType.system)
                button.setTitle(" Update Phone Number", for: .normal)
                button.setImage(UIImage(named: "phone"), for: .normal)
                button.addTarget(self, action: #selector(pressedUpdatePhone), for: .touchUpInside)
                return button
            }()
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let photoBtn: UIButton = {
        //            let button = UIButton(type: UIButtonType.system)
        //            button.setTitle(" Upload Profile Image", for: .normal)
        //            button.setImage(UIImage(named: "add_photo"), for: .normal)
        //            button.addTarget(self, action: #selector(pressedUploadPhoto), for: .touchUpInside)
        //            return button
        //        }()
        //        let phoneBtn: UIButton = {
        //            let button = UIButton(type: UIButtonType.system)
        //            button.setTitle(" Update Phone Number", for: .normal)
        //            button.setImage(UIImage(named: "phone"), for: .normal)
        //            button.addTarget(self, action: #selector(pressedUpdatePhone), for: .touchUpInside)
        //            return button
        //        }()
        //        buttons = [photoBtn, phoneBtn]
        //        menuLauncher = BottomMenuLauncher(buttons: buttons)
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        menuLauncher.showMenu()
    }
    
    @objc func pressedUploadPhoto() {
        print("pressed upload")
    }
    
    @objc func pressedUpdatePhone() {
        print("pressed update")
    }
    
}
