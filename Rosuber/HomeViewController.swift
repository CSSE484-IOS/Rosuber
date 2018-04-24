//
//  ViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/17.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    var showMenu = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
    }
    
    @IBAction func pressedMenu(_ sender: Any) {
        if showMenu {
            menuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        } else {
            menuLeadingConstraint.constant = -150
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        showMenu = !showMenu
    }
    
    @objc func handleDismiss() {
        menuLeadingConstraint.constant = -150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

