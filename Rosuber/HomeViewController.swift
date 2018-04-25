//
//  HomeViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/17.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    var showMenu = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    @IBAction func pressedMenu(_ sender: Any) {
        if showMenu {
            blackView.alpha = 1
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            menuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            handleDismiss()
        }
        showMenu = !showMenu
    }
    
    @objc func handleDismiss() {
        blackView.alpha = 0
        menuLeadingConstraint.constant = -150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

