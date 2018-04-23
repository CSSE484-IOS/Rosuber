//
//  ViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/17.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let menuLauncher = LeftMenuLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedMenu(_ sender: Any) {
        menuLauncher.showMenu()
    }
    

}

